const network = await Service.import('network');
const bluetooth = await Service.import('bluetooth');
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Brightness from '../services/brightness.js';
import { VolumeIndicator, NetworkIndicatorLabel, BluetoothIndicator } from '../indicators/indicatorIcons.js'; 

const VolumeSlider = (stream) => Widget.Slider({
    hexpand: true,
    drawValue: false,
    onChange: ({ value }) => Audio.apps[stream].volume = value,
    value: Audio.apps[stream].bind('volume'),
})

export const QuickSettings = () => Widget.Window({
  name: "quicksettings",
  class_name: "quicksettings",
  anchor: [ "top", "right" ],
  layer: "top",
  visible: false,
  popup: true,
  keymode: "on-demand",
  child: Widget.Box({
    vertical: true,
    spacing: 5,
    children: [
      Widget.Box({
        class_name: "quicksettingsitem",
        children: [
          Widget.Button({
            class_name: network.wifi.bind("internet").transform(i => {
              return `${i === "connected" ? "active" : ""}`
            }),
            hexpand: true,
            on_primary_click: () => network.toggleWifi(),
            child: Widget.Box({
              children:[
                NetworkIndicatorLabel(),
              ]
            })
          })
        ]
      }),
      Widget.Box({
        class_name: "quicksettingsitem",
        vertical: true,
        children: [
          Widget.Box({
            children: [
              VolumeIndicator(),
              Widget.Slider({
                hexpand: true,
                draw_value: false,
                on_change: ({ value }) => Audio.speaker.volume = value,
                setup: self => self.hook(Audio, () => {
                    self.value = Audio.speaker?.volume || 0;
                }, 'speaker-changed'),
              }),
              // Widget.Box({
              //   children: Audio.bind("apps").transform(apps => {
              //     return apps
              //       .map(app => {
              //           print(app.volume)
              //           return VolumeSlider(app)
              //       })
              //   })              
              // })
            ]            
          })
        ]
      })
    ]
  })
})
