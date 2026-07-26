local WEEKDAYS = {
    [0] = 'Sunday',
    [1] = 'Monday',
    [2] = 'Tuesday',
    [3] = 'Wednesday',
    [4] = 'Thursday',
    [5] = 'Friday',
    [6] = 'Saturday'
}

local MONTHS = {
    [0] = 'January',
    [1] = 'February',
    [2] = 'March',
    [3] = 'April',
    [4] = 'May',
    [5] = 'June',
    [6] = 'July',
    [7] = 'August',
    [8] = 'September',
    [9] = 'October',
    [10] = 'November',
    [11] = 'December'
}

local displayText = ''

local function padNumber(value)
    value = tonumber(value) or 0
    return value < 10 and ('0%d'):format(value) or tostring(value)
end

local function formatGameTime(hours, minutes)
    hours = tonumber(hours) or 0
    minutes = tonumber(minutes) or 0

    if not Config.Use12HourClock then
        return ('%s:%s'):format(padNumber(hours), padNumber(minutes))
    end

    local suffix = hours >= 12 and 'PM' or 'AM'
    local displayHour = hours % 12

    if displayHour == 0 then
        displayHour = 12
    end

    return ('%d:%s %s'):format(displayHour, padNumber(minutes), suffix)
end

local function buildGameClockText()
    -- These CLOCK natives read the active RDR2 world clock. They do not read
    -- the player's computer clock or the server machine's real-world clock.
    local gameHour = GetClockHours()
    local gameMinute = GetClockMinutes()
    local gameWeekday = GetClockDayOfWeek()
    local gameMonth = GetClockMonth()
    local gameMonthDay = GetClockDayOfMonth()
    local gameYear = GetClockYear()

    if Config.ForceRedDeadYear then
        gameYear = tonumber(Config.RedDeadYear) or 1899
    end

    local dateText = ''

    if Config.ShowWeekday then
        dateText = WEEKDAYS[gameWeekday] or 'Unknown Day'
    end

    if Config.ShowDate then
        local monthDate = ('%s %d'):format(MONTHS[gameMonth] or 'Unknown', gameMonthDay)

        if Config.ShowYear then
            monthDate = ('%s, %d'):format(monthDate, gameYear)
        end

        if dateText ~= '' then
            dateText = ('%s, %s'):format(dateText, monthDate)
        else
            dateText = monthDate
        end
    end

    local timeText = formatGameTime(gameHour, gameMinute)

    if dateText ~= '' then
        displayText = dateText .. Config.Separator .. timeText
    else
        displayText = timeText
    end
end

local function drawText(text, x, y)
    if text == '' then
        return
    end

    SetTextScale(Config.Scale, Config.Scale)
    SetTextColor(Config.Color.r, Config.Color.g, Config.Color.b, Config.Color.a)
    SetTextCentre(false)
    SetTextFontForCurrentCommand(Config.Font)

    local textString = CreateVarString(10, 'LITERAL_STRING', text)
    DisplayText(textString, x, y)
end

CreateThread(function()
    while true do
        buildGameClockText()
        Wait(math.max(100, tonumber(Config.RefreshInterval) or 500))
    end
end)

CreateThread(function()
    while true do
        Wait(0)

        if not (Config.HideWhilePaused and IsPauseMenuActive()) then
            drawText(displayText, Config.Position.x, Config.Position.y)
        end
    end
end)


AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    print('[node7-timehud] Started. Displaying synchronized Red Dead world day and time.')
end)
