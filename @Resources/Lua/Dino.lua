-- Dino.lua
-- PixelDesk Dino AI State Machine

state = "idle"
frame = 1
timer = 0
exp = 0
maxExp = 1200
level = 1
baseY = 700
bounce = 0
musicPlaying = false

function Initialize()
    -- Load saved data
    local savePath = SKIN:MakePathAbsolute("@Resources\\Data\\Save.inc")
    local f = io.open(savePath, "r")
    if f then
        for line in f:lines() do
            local k, v = line:match("(%w+)=(%d+)")
            if k == "Level" then level = tonumber(v) end
            if k == "Exp" then exp = tonumber(v) end
            if k == "MaxExp" then maxExp = tonumber(v) end
        end
        f:close()
    end
end

function Save()
    local savePath = SKIN:MakePathAbsolute("@Resources\\Data\\Save.inc")
    local f = io.open(savePath, "w")
    if f then
        f:write("Level=" .. level .. "\n")
        f:write("Exp=" .. exp .. "\n")
        f:write("MaxExp=" .. maxExp .. "\n")
        f:close()
    end
end

function Update()
    timer = timer + 1

    if musicPlaying then
        bounce = math.floor(math.sin(timer * 0.3) * 8)
    else
        bounce = 0
    end

    if timer % 30 == 0 and state == "idle" then
        if math.random(1, 3) == 1 then
            state = "walk"
        end
    end

    if state == "idle" then
        frame = (frame % 2) + 1
        return "idle" .. frame

    elseif state == "walk" then
        frame = (frame % 2) + 1
        if timer % 15 == 0 then
            state = "idle"
            frame = 1
            return "idle1"
        end
        return "walk" .. frame

    elseif state == "eat" then
        frame = (frame % 4) + 1
        if frame == 1 and timer % 4 == 0 then
            state = "idle"
            frame = 1
            exp = exp + 50
            if exp >= maxExp then
                level = level + 1
                exp = exp - maxExp
                maxExp = maxExp + 200
            end
            Save()
            return "idle1"
        end
        return "eat" .. frame

    elseif state == "jump" then
        frame = (frame % 2) + 1
        if timer % 10 == 0 then
            state = "idle"
            frame = 1
            return "idle1"
        end
        return "jump" .. frame
    end

    return "idle1"
end

function Eat()
    state = "eat"
    frame = 1
    timer = 0
end

function Jump()
    state = "jump"
    frame = 1
    timer = 0
end

function MusicBounce()
    musicPlaying = true
end

function MusicStop()
    musicPlaying = false
    bounce = 0
end

function GetState() return state end
function GetFrame() return frame end
function GetExp() return exp end
function GetMaxExp() return maxExp end
function GetLevel() return level end
function GetBounce() return bounce end
