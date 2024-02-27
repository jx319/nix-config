const Hyprland = App.configDir + '/services/hyprland.ts';
const outdir = '/tmp/ags/js';

try {
    await Utils.execAsync([
        'bun', 'build', Hyprland,
        '--outdir', outdir,
        '--external', 'resource://*',
        '--external', 'gi://*',
    ])
} catch (error) {
    console.error(error)
}

export default hyprland_workspaces = await import(`file://${outdir}/main.js`)
