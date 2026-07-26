Config = {}

-- Plain text position in normalized screen coordinates.
Config.Position = {
    x = 0.015,
    y = 0.020
}

Config.Scale = 0.32
Config.Font = 0
Config.Color = {
    r = 255,
    g = 255,
    b = 255,
    a = 230
}

-- RED DEAD WORLD CLOCK ONLY.
-- This resource never reads os.date(), os.time(), GetLocalTime(), or real-world time.
Config.Use12HourClock = true
Config.ShowWeekday = true
Config.ShowDate = false
Config.ShowYear = false

-- Red Dead Redemption 2 is set in 1899. Keeping this enabled prevents another
-- time-sync resource from making the HUD display a modern real-world year.
Config.ForceRedDeadYear = true
Config.RedDeadYear = 1899

Config.Separator = '  |  '
Config.HideWhilePaused = true
Config.RefreshInterval = 500
