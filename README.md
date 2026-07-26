[README.md](https://github.com/user-attachments/files/30391865/README.md)

# node7-timehud

Lightweight plain-text HUD for the active Red Dead Redemption 2 world calendar and clock.

Default display:

```text
Monday, May 15, 1899  |  8:42 PM
```

## Important

This resource reads only the RDR2 `CLOCK` natives:

- `GetClockHours()`
- `GetClockMinutes()`
- `GetClockDayOfWeek()`
- `GetClockDayOfMonth()`
- `GetClockMonth()`
- `GetClockYear()`

It does not use `os.date`, `os.time`, `GetLocalTime`, the player's computer clock, or real-world server-machine time.

## Installation

1. Place `node7-timehud` in your resources folder.
2. Start it after the server's time/weather synchronization resource.

```cfg
ensure your-time-weather-resource
ensure node7-timehud
```

## Configuration

Edit `config.lua` to change:

- top-left position
- scale, font, and text color
- 12-hour or 24-hour time
- weekday/date/year visibility
- forced 1899 Red Dead year
- refresh interval

No SQL or NUI is required.

## Startup fix

Version 1.1.1 uses the exact RedM `rdr3_warning` acknowledgement required by the resource loader.
