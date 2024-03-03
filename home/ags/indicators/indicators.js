const network = await Service.import('network');
const bluetooth = await Service.import('bluetooth');
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
const notifications = await Service.import("notifications");
import UnreadNotifications from "../services/unread_notifications.js";

export const VolumeIndicator = () => Widget.Icon().hook(Audio, self => {
    if (!Audio.speaker)
        return;

    const category = {
        101: 'overamplified',
        67: 'high',
        34: 'medium',
        1: 'low',
        0: 'muted',
    };

    const icon = Audio.speaker.stream.is_muted ? 0 : [101, 67, 34, 1, 0].find(
        threshold => threshold <= Audio.speaker.volume * 100);

    self.icon = `audio-volume-${category[icon]}-symbolic`;
}, 'speaker-changed')

const WifiIndicator = () => Widget.Icon({
    icon: network.wifi.bind('icon_name'),
})

const WiredIndicator = () => Widget.Icon({
    icon: network.wired.bind('icon_name'),
})

export const NetworkIndicator = () => Widget.Stack({
    children: {
        'wifi': WifiIndicator(),
        'wired': WiredIndicator(),
    },
    shown: network.bind('primary')
})

export const WifiIndicatorLabel = () => Widget.Box({
    children: [
        Widget.Icon({
            icon: network.wifi.bind('icon_name'),
        }),
        Widget.Label({
            label: network.wifi.bind('ssid').transform(ssid => `${ssid}`),
        })
    ]
})

export const NetworkIndicatorLabel = () => Widget.Stack({
    children: {
        'wifi': WifiIndicatorLabel(),
        'wired': WiredIndicator(),
    },
    shown: network.bind('primary'),
})

export const BluetoothIndicator = () => Widget.Icon({
    icon: bluetooth.bind('enabled').transform(on =>
        `bluetooth-${on ? 'active' : 'disabled'}-symbolic`),
})

export const MediaIndicator = () => Widget.Icon({
    setup: self => {
        self.hook(Mpris, self => {
                if (Mpris.players[0]) {
                    const { play_back_status } = Mpris.players[0];
                    switch(play_back_status) {
                        case "Playing":
                            self.icon = `${App.configDir}/icons/pause-symbolic.svg`;
                            break;
                        case "Paused":
                            self.icon = `${App.configDir}/icons/play-symbolic.svg`;
                            break;
                        case "Stopped":
                            self.icon = `${App.configDir}/icons/stop-symbolic.svg`
                            break;
                    }
                
                }
        }, 'player-changed')
    }
})

export const MediaIndicatorLabel = () => Widget.Box({
    children: [
        MediaIndicator(),
        Widget.Label('-').hook(Mpris, self => {
            if (Mpris.players[0]) {
                const { track_artists, track_title } = Mpris.players[0];
                self.label = (track_artists[0] || track_title) ? `${track_artists.join(', ')} - ${track_title}` : '';
            } else {
                self.label = '';
            }
            self.truncate = 'end';
            self.max_width_chars = 50;

        }, 'player-changed')
    ]
})

const get_notification_icon = () => {
    if(notifications.notifications.length > 0 && UnreadNotifications.unread_notifications)
        return "notification-new-symbolic";
    else if(notifications.dnd)
        return "notifications-disabled-symbolic";
    else 
        return "notification-symbolic";
}

export const NotificationIndicator = (props) => Widget.Icon({
    ...props,
    setup: self => {
        self.hook(notifications, self => {
            self.icon = get_notification_icon()
        }, "changed")
        self.hook(UnreadNotifications, self => {
            self.icon = get_notification_icon()
        }, "changed")
    }
})
