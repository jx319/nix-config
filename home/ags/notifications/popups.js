import Notification from "./Notification.js";

const notifications = await Service.import("notifications")
const transition = {
  value: 200
};
const { timeout, idle } = Utils

export const Animated = (id) => {
    const n = notifications.getNotification(id)
    const widget = Notification(n)

    const inner = Widget.Revealer({
        transition: "slide_down",
        transition_duration: transition.value,
        child: widget,
    })

    const outer = Widget.Revealer({
        transition: "slide_down",
        transition_duration: transition.value,
        child: inner,
    })

    const box = Widget.Box({
        hpack: "end",
        child: outer,
    })

    idle(() => {
        outer.reveal_child = true
        timeout(transition.value, () => {
            inner.reveal_child = true
        })
    })

    return Object.assign(box, {
        dismiss() {
            inner.reveal_child = false
            timeout(transition.value, () => {
                outer.reveal_child = false
                timeout(transition.value, () => {
                    box.destroy()
                })
            })
        },
    })
}

const PopupList = () => {
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

                if (notifications.dnd)
                    return

                const w = Animated(id)
                map.set(id, w)
                box.children = [w, ...box.children]
            }
        }, "notified")
        .hook(notifications, remove, "dismissed")
        .hook(notifications, remove, "closed")
}

export default () => Widget.Window({
    name: `notifications`,
    anchor: [ "top" ],
    class_name: "notifications",
    child: Widget.Box({
        css: "padding: 2px;",
        child: PopupList(),
    }),
})
