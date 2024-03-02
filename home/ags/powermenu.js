import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';

export const PowerMenu = () => Widget.Window({
  name: "powermenu",
  class_name: "powermenu",
  anchor: [ "top", "bottom", "left", "right" ],
  layer: "overlay",
  exclusivity: "ignore",
  // popup: true,
  visible: false,
  keymode: "exclusive",
  child: Widget.CenterBox({
    centerWidget: Widget.CenterBox({
      vertical: true,
      centerWidget: Widget.Box({
        class_name: "powermenuBar",
        children: [
          Widget.Button({
            onClicked: () => {
              App.closeWindow("powermenu");
              execAsync("systemctl suspend");
            },
            child: Widget.Icon({
              class_name: "powermenuIcon",
              icon: "system-suspend-symbolic",
              size: 192
            })
          }),
          Widget.Button({
            onClicked: () => Hyprland.sendMessage("dispatch exit"),
            child: Widget.Icon({
              class_name: "powermenuIcon",
              icon: "system-log-out-symbolic",
              size: 192
            })
          }),
          Widget.Button({
            onClicked: () => execAsync("systemctl poweroff"),
            child: Widget.Icon({
              class_name: "powermenuIcon",
              icon: "system-shutdown-symbolic",
              size: 192
            })
          }),
          Widget.Button({
            onClicked: () => execAsync("systemctl reboot"),
            child: Widget.Icon({
              class_name: "powermenuIcon",
              icon: "system-reboot-symbolic",
              size: 192
            })
          })
        ]
      })
    })
  })
}).keybind("Escape", () => App.closeWindow("powermenu"));
