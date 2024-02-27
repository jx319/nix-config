import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';

const NotificationItem = () => {
  return Widget.Box({
    class_name: "notificationItem",
    children: [
      Widget.Icon({
        class_name: "notificationIcon",
        size: 96,
        icon: "AdobeIllustrator"
      }),
      Widget.Label("summary")
    ]
  });
};

export const NotificationWindow = () => Widget.Window({
  name: "notifications",
  anchor: [ "top" ],
  layer: "overlay",
  visible: true,
  child: Widget.Box({
    vertical: true,
    spacing: 8,
    children: [
      NotificationItem(),
      NotificationItem()
    ]
  })
});
