-- Select the compositor backdrop for Caelestia surfaces:
--   "liquid"   = Hyprglass refraction, contour and grain
--   "hyprland" = Hyprland's native Gaussian layer blur
local backend = "liquid"
if backend ~= "liquid" and backend ~= "hyprland" then
    backend = "liquid"
end
_G.caelestiaGlassBackend = backend

local hg = hl.plugin and hl.plugin.hyprglass
if not hg then
    -- Keep native Hyprland blur as a safe fallback if the plugin is absent.
    _G.caelestiaGlassBackend = "hyprland"
    return
end

local useLiquidGlass = backend == "liquid"

hg.config({
    enabled = false,
    layers = {
        enabled = useLiquidGlass,
        namespaces = "caelestia-drawers,caelestia-control-center,caelestia-dashboard,caelestia-launcher,caelestia-quickpanel,caelestia-sidebar,caelestia-session,caelestia-osd,caelestia-notifications,caelestia-lyrics,caelestia-popout,caelestia-bar,caelestia-toast",
        mask_mode = "alpha",
        manage_blur = true,
        live_resample = true,
        live_resample_fps = 0,
    },
})

if not useLiquidGlass then
    return
end

hg.preset("caelestia", {
    inherits = "clear",
    blur_strength = 0.15,
    blur_iterations = 1,
    refraction_strength = 2.2,
    chromatic_aberration = 0.65,
    -- Candidate plugin build: noise_strength = 0.016,
    edge_thickness = 0.08,
    tint_color = 0xffffff00,
    brightness = 1.0,
    contrast = 1.0,
    saturation = 1.0,
    adaptive_dim = 0.0,
    adaptive_boost = 0.0,
})

for _, panel in ipairs({ "control-center", "dashboard", "launcher", "quickpanel", "sidebar", "session", "osd", "notifications", "lyrics", "popout", "bar", "toast" }) do
    hg.layer("caelestia-" .. panel, {
        preset = "caelestia",
        mask_mode = "alpha",
        rounding = 24,
        live_resample = true,
    })
end

hg.layer("caelestia-drawers", {
    preset = "caelestia",
    mask_mode = "alpha",
    rounding = 0,
    contour = true,
    mask_threshold = 0.025,
    material_blur_strength = 0.85,
    material_blur_iterations = 1,
    -- Exclude the unified drawer background (0.14 alpha, quantized to 36/255).
    -- Only the additional card coverage should select the stronger blur.
    material_alpha_threshold = 0.15,
    live_resample = true,
})

hg.layer("caelestia-launchpad", { exclude = true })
hl.layer_rule({
    name = "caelestia-unified-animation",
    match = { namespace = "^caelestia-drawers$" },
    no_anim = true,
})

hg.preset("caelestia-frame", {
    inherits = "caelestia",
    blur_strength = 0,
    refraction_strength = 0.3,
    lens_distortion = 0,
})

for _, side in ipairs({ "top", "bottom", "left", "right" }) do
    hg.layer("caelestia-frame-" .. side, {
        preset = "caelestia-frame",
        mask_mode = "alpha",
        rounding = 25,
        frame_thickness = 10,
        live_resample = true,
    })
end
