const network = await Service.import('network');
const bluetooth = await Service.import('bluetooth');
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';

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
