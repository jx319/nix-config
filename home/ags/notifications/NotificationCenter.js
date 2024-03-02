import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { timeout } from 'resource:///com/github/Aylur/ags/utils.js';
import { Animated } from './popups.js';
const notifications = await Service.import("notifications")

const NotificationList = () => {
    const map = new Map
    const box = Widget.Box({
        hpack: "end",
        vertical: true,
    })

    function remove(_, id) {
        map.get(id)?.dismiss()
        map.delete(id)
    }

    return box
        .hook(notifications, (_, id) => {
            if (id !== undefined) {
                if (map.has(id))
                    remove(null, id)

                const w = Animated(id)
                map.set(id, w)
                box.children = [w, ...box.children]
            }
        }, "notified")
        .hook(notifications, remove, "closed")
}

const notification_list = NotificationList();

const menu_revealer = Widget.Revealer({
    transition: "slide_down",
    transition_duration: 200,
    reveal_child: false,
    child: Widget.Box({
        class_name: "notificationcenterbox",
        vertical: true,
        children: [
            Widget.CenterBox({
                class_name: "top-bar",
                start_widget: Widget.Icon({
                    icon: "notification-symbolic",
                    size: 32,
                    xalign: 0
                }),
                center_widget: Widget.Label({
                    label: "Benachrichtigungen"
                }),
                end_widget: Widget.Box({
                    hpack: "end",
                    children: [
                        Widget.Button({
                            on_primary_click: () => {
                                notification_list.children = []
                            },
                            hexpand: false,
                            xalign: 1,
                            child: Widget.Icon({
                                icon: "window-close-symbolic",
                                size: 32
                            })
                        })
                    ]
                })
            }),
            Widget.Scrollable({
                hpack: "center",
                vexpand: true,
                hscroll: "never",
                vscroll: "always",
                child: notification_list
            })
          ]
    })   
})

export const NotificationCenter = () => Widget.Window({
    name: "notificationcenter",
    class_name: "notificationcenter",
    anchor: [ "top" ],
    layer: "top",
    visible: true,
    keymode: "on_demand",
    child: Widget.Box({ 
        css: `
            min-height: 2px;
            min-width: 2px;
        `,
        children: [menu_revealer]
    }).keybind("Escape", () => toggleNotificationCenter())
})

globalThis.toggleNotificationCenter = () => {
    menu_revealer.reveal_child = !menu_revealer.reveal_child 
}
