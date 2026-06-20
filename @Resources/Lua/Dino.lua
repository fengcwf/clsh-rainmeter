-- Dino.lua
-- Pixel Dinosaur state machine

state = "idle"
frame = 1
exp = 780
maxExp = 1200
level = 12

function Initialize()
end

function Update()
    if state == "idle" then
        frame = (frame % 2) + 1
    elseif state == "walk" then
        frame = (frame % 4) + 1
    elseif state == "eat" then
        frame = (frame % 2) + 1
        if frame == 1 then
            state = "idle"
            exp = exp + 50
            if exp >= maxExp then
                level = level + 1
                exp = exp - maxExp
                maxExp = maxExp + 200
            end
        end
    elseif state == "jump" then
        frame = (frame % 2) + 1
        if frame == 1 then
            state = "idle"
        end
    end
    return frame
end

function Eat()
    state = "eat"
    frame = 1
end

function Jump()
    state = "jump"
    frame = 1
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
