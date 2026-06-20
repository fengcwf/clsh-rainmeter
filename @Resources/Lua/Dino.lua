-- Dino.lua
-- PixelDesk Dino AI State Machine
-- Chrome Dino + GameBoy Sprite + 8bit RPG NPC style

state = "idle"
frame = 1
timer = 0
exp = 780
maxExp = 1200
level = 12
baseY = 700
bounce = 0
musicPlaying = false

function Initialize()
end

function Update()
    timer = timer + 1

    -- Music bounce sync
    if musicPlaying then
        bounce = math.floor(math.sin(timer * 0.3) * 8)
    else
        bounce = 0
    end

    -- Random behavior every 30 seconds
    if timer % 30 == 0 and state == "idle" then
        local r = math.random(1, 3)
        if r == 1 then
            state = "walk"
        end
    end

    -- State machine
    if state == "idle" then
        frame = (frame % 2) + 1

    elseif state == "walk" then
        frame = (frame % 2) + 1
        if timer % 15 == 0 then
            state = "idle"
            frame = 1
        end

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
        end

    elseif state == "jump" then
        frame = (frame % 2) + 1
        if timer % 10 == 0 then
            state = "idle"
            frame = 1
        end
    end

    return frame
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

function GetState()
    return state
end

function GetFrame()
    return frame
end

function GetExp()
    return exp
end

function GetMaxExp()
    return maxExp
end

function GetLevel()
    return level
end

function GetBounce()
    return bounce
end
