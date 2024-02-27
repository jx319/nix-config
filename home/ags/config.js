import { Bar } from "./bar/bar.js";
import { monitorFile, timeout, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import { applauncher } from "./applauncher.js";
import { PowerMenu } from "./powermenu.js";
// import { notificationPopup } from './notificationPopups.js';
import { QuickSettings } from "./quicksettings/quicksettings.js";

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
        applauncher,
        PowerMenu(),
        // notificationPopup,
        QuickSettings()
    ],
};
