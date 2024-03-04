import { Bar } from "./bar/bar.js";
import { monitorFile, timeout, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import { PowerMenu } from "./powermenu/powermenu.js";
import notificationPopup from './notifications/popups.js';
import { NotificationCenter } from "./notifications/NotificationCenter.js";
// import { QuickSettings } from "./quicksettings/quicksettings.js";

// test notifications

// timeout(100, () => execAsync([
//     'notify-send',
//     'Notification Popup Example',
//     'Lorem ipsum dolor sit amet, qui minim labore adipisicing ' +
//     'minim sint cillum sint consectetur cupidatat.',
//     '-A', 'Cool!',
//     "-A", "2",
//     '-i', 'info-symbolic',
//     "-t", "500000000"
// ]));

monitorFile(
    `${App.configDir}/style.css`,
    function() {
        App.resetCss();
        App.applyCss(`${App.configDir}/style.css`);
    },
);

export default {
    style: App.configDir + '/style.css',
    windows: [
        Bar(),
        PowerMenu(),
        notificationPopup(),
        NotificationCenter()
        // QuickSettings()
    ],
};
