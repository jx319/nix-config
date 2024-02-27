// based on https://github.com/Aylur/ags/blob/f5c2bbe3f68dd7a5316c3cd77e52076af560cd3e/example/simple-bar/config.js
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Brightness from '../services/brightness.js';
import { execAsync, lookUpIcon } from 'resource:///com/github/Aylur/ags/utils.js';
import { Tray } from '../systray/tray.js';
import { VolumeIndicator, NetworkIndicator, BluetoothIndicator } from "../indicators/indicatorIcons.js";

const Workspaces = () => Widget.Box({
    class_name: 'workspaces',
    children: Hyprland.bind("workspaces")
        .transform(ws => {
        return ws
            .sort((a, b) => {
                return a.id - b.id; // sort by id to prevent higher values from appearing first
            })
            .map(({ id }) => id > 0 ? Widget.Button({
                on_clicked: () => Hyprland.messageAsync(`dispatch workspace ${id}`),
                expand: false,
                class_name: Hyprland.active.workspace.bind('id')
                     .transform(i => {
                         return `${i === id ? 'focused' : ''}`
                     }),
            }) : null); // ignore special workspaces
    })
});

const AppIcon = () => Widget.Icon().hook(Hyprland, self => {
    let iconClass = Hyprland.active.client.class;
    
    //if (iconClass == "")
    //    iconClass = JSON.parse(Hyprland.messageAsync("activewindow -j")).class;
    
    if (lookUpIcon(iconClass)) {
        self.visible = true;
        self.icon = iconClass;
        self.size = 32;
    } else {
        self.visible = false;
    }
    
}, "changed");

const ClientTitle = () => Widget.Label({
    class_name: 'client-title',
    label: Hyprland.active.client.bind('title').transform( title => {
        //if (title == "")
        //    return JSON.parse(Hyprland.messageAsync("activewindow -j")).title;
        //else
            return title;
    }),
    truncate: 'end',
    max_width_chars: 50,
    wrap: false,
});

const Clock = () => Widget.Box({
    class_names: ['clock', "pill"],
    setup: self => self
        .poll(1000, self => execAsync(['date', '+%T\|%d.%m.%Y'])
            .then(date => {
                date = date.split("|");
                self.children = [
                    Widget.Label(date[0]),
                    Widget.Label(date[1])
                ]
            })),
});

const LauncherButton = () => Widget.Button({
    onClicked: () => App.toggleWindow("applauncher"),
    class_name: "launcherbutton",
    child: Widget.Icon({
        icon: `${App.configDir}/icons/nix-snowflake.svg`,
        size: 32
    }),
});

const Media = () => Widget.Button({
    class_names: [ 'media', "pill"],
    on_primary_click: () => Mpris.getPlayer('')?.playPause(),
    on_scroll_up: () => Mpris.getPlayer('')?.next(),
    on_scroll_down: () => Mpris.getPlayer('')?.previous(),
    visible: Mpris.bind("players").transform(p => p.length > 0),
    child: Widget.Label('-').hook(Mpris, self => {
        if (Mpris.players[0]) {
            const { track_artists, track_title } = Mpris.players[0];
            self.label = (track_artists[0] || track_title) ? `${track_artists.join(', ')} - ${track_title}` : '';
        } else {
            self.label = '';
        }
        self.truncate = 'end';
        self.max_width_chars = 50;

    }, 'player-changed'),
});

const PowerButton = () => Widget.Button({
    class_name: "powerbutton",
    child: Widget.Icon("system-shutdown-symbolic"),
    onPrimaryClick: () => App.toggleWindow("powermenu")
})

const ScreenBrightness = () => Widget.EventBox({
    on_scroll_up: () => Brightness.screen_value = (Math.floor(Brightness.screen_value * 100) + 5) / 100, // perfect 5% steps
    on_scroll_down: () => Brightness.screen_value = (Math.floor(Brightness.screen_value * 100) - 5) / 100,
    class_names: [ 'brightness' ],
    child: Widget.Box({
        class_name: "pill",
        children: [
            Widget.Icon().hook(Brightness, self => {
            
                const category = {
                    67: 'high',
                    34: 'medium',
                    1: 'low',
                };

                const icon = [67, 34, 1].find(
                    threshold => threshold <= Brightness.screen_value * 100);

                self.icon = `display-brightness-${category[icon]}-symbolic`;
            }, 'screen-changed'),
            Widget.Label({
                label: Brightness.bind("screen_value").transform(brightness => `${Math.floor(brightness * 100)}`)
            }),
        ],
    })
});


const Volume = () => Widget.EventBox({
    on_primary_click: () => execAsync("pamixer -t"),
    on_secondary_click: () => execAsync("pavucontrol"),
    on_scroll_up: () => Audio.speaker.volume += 0.01,
    on_scroll_down: () => Audio.speaker.volume -= 0.01,
    class_names: [ 'volume' ],
    child: Widget.Box({
        class_name: "pill",
        children: [
            VolumeIndicator(),
            Widget.Label({
                label: Audio.speaker.bind("volume").transform(volume => `${Math.floor(volume * 100)}`),
            })
        ],
    })
});

const BatteryLabel = () => Widget.Box({
    class_names: [ 'battery', "pill" ],
    visible: Battery.bind('available'),
    children: [
        Widget.Icon({
            icon: Battery.bind('icon-name'),
        }),
        Widget.Label({
            label: Battery.bind("percent").transform(p => p + "%")
        })

        /*Widget.ProgressBar({
            vpack: 'center',
            fraction: Battery.bind('percent').transform(p => {
                return p > 0 ? p / 100 : 0;
            }),
        }),*/
    ],
});


// const QuickSettingsButton = () => Widget.Button({
//     on_primary_click: () => App.toggleWindow("quicksettings"),
//     class_name: "pill",
//     child: Widget.Box({
//         class_name: "quicksettingsbutton",
//         spacing: 2,
//         children: [
//             NetworkIndicator(),
//             BluetoothIndicator(),
//             VolumeIndicator()
//         ]
//     })
// })

// layout of the bar
const Left = () => Widget.Box({
    spacing: 8,
    children: [
        LauncherButton(),
        Workspaces(),
        AppIcon(),
        ClientTitle(),
    ],
});

const Center = () => Widget.Box({
    spacing: 8,
    children: [
        Media(),
        //Notification(),
    ],
});

const Right = () => Widget.Box({
    hpack: 'end',
    spacing: 8,
    children: [
        Tray(),
        ScreenBrightness(),
        Volume(),
        BatteryLabel(),
        Clock(),
        PowerButton(),
    ],
});

export const Bar = (monitor = 0) => Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: 'bar',
    monitor,
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(),
    }),
});
