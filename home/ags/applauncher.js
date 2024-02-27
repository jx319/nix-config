// based on https://github.com/Aylur/ags/blob/f5c2bbe3f68dd7a5316c3cd77e52076af560cd3e/example/applauncher/applauncher.js
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Applications from 'resource:///com/github/Aylur/ags/service/applications.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

const WINDOW_NAME = 'applauncher';

/** @param {import('resource:///com/github/Aylur/ags/service/applications.js').Application} app */
const AppItem = app => Widget.Button({
    on_clicked: () => {
        App.closeWindow(WINDOW_NAME);
        app.launch();
    },
    attribute: { app },
    child: Widget.Box({
        children: [
            Widget.Icon({
                icon: app.icon_name || '',
                size: 42,
            }),
            Widget.Label({
                class_name: 'title',
                label: app.name,
                xalign: 0,
                vpack: 'center',
                truncate: 'end',
            }),
        ],
    }),
});

const Applauncher = ({ width = 500, height = 500, spacing = 12 }) => {
    // list of application buttons
    let applications = Applications.query('').map(AppItem);

    const nix_run_button = Widget.Button({
        onClicked: () => {},
        visible: false,
        child: Widget.Box({
            children: [
                Widget.Icon({
                   icon: `${App.configDir}/icons/nix-snowflake.svg`,
                   size: 42 
                }),
                Widget.Label({
                    class_name: "title",
                    xalign: 0,
                    label: "nix run"
                })
            ]
        })
    });
    
    // container holding the buttons
    const list = Widget.Box({
        vertical: true,
        children: applications,
        spacing,
    });

    // repopulate the box, so the most frequent apps are on top of the list
    function repopulate() {
        applications = Applications.query('').map(AppItem);
        list.children = applications;
    }

    function nix_run(pkg) {
        App.toggleWindow(WINDOW_NAME);
        execAsync(`nix run nixpkgs${pkg}`)        
    }

    // search entry
    const entry = Widget.Entry({
        hexpand: true,
        css: `margin-bottom: ${spacing}px;`,

        // to launch the first item on Enter
        on_accept: ({ text }) => {
            if (applications[0].visible) {
                App.toggleWindow(WINDOW_NAME);
                applications[0].attribute.app.launch();
            } else if (nix_run_button.visible) {
                nix_run(text);
            }
        },

        // filter out the list
        on_change: ({ text }) => {
            applications.forEach(item => {
                item.visible = item.attribute.app.match(text);
            });
            
            nix_run_button.onClicked = () => nix_run(text);
            nix_run_button.visible = text.match("#");
            nix_run_button.child.children[1].label = `>nix run nixpkgs${text}`;
            
        }
    });

    return Widget.Box({
        vertical: true,
        css: `margin: ${spacing * 2}px;`,
        children: [
            entry,

            // wrap the list in a scrollable
            Widget.Scrollable({
                hscroll: 'never',
                css: `
                    min-width: ${width}px;
                    min-height: ${height}px;
                `,
                child: Widget.Box({
                    vertical: true,
                    children: [ list, nix_run_button ]
                })
            }),
        ],
        setup: self => self.hook(App, (_, windowName, visible) => {
            if (windowName !== WINDOW_NAME)
                return;

            // when the applauncher shows up
            if (visible) {
                repopulate();
                entry.text = '';
                entry.grab_focus();
            }
        }),
    });
};

// there needs to be only one instance
export const applauncher = Widget.Window({
    name: WINDOW_NAME,
    popup: true,
    visible: false,
    keymode: "exclusive",
    child: Applauncher({
        width: 500,
        height: 500,
        spacing: 12,
    }),
});
