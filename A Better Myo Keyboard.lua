-- Hack Arizona 2016 submission: Alexander Yee, Daniel Phillips, Benjamin Shields, and Michael Scott
scriptId = 'com.benisbitch.scripts.abetterkeyboard'
scriptTitle = "A Better Myo Keyboard"
scriptDetailsUrl = "" -- lol wut

function onForegroundWindowChange(app, title)
	--myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
	return true
end
    myo.setLockingPolicy("none")
    centreYaw = 0
    centreRoll = 0
    centrePitch = 0
    deltaRoll = 0

    YAW_DEADZONE = .1  
    ROLL_DEADZONE = .2  

    MOUSE_CONTROL_TOGGLE_DURATION = 1000
    PI = 3.1416  
    TWOPI = PI * 2

    printCount = 0
function onPoseEdge(pose, edge)  
        myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
        
        if (edge == "on") then
            myo.unlock("hold")
            if (pose == "waveOut") then
                onWaveOut()     
                myo.vibrate("short")
            elseif (pose == "waveIn") then
                onWaveIn()
                myo.vibrate("short")
            elseif (pose == "fist") then
                onFist()
                myo.vibrate("short")
            elseif (pose == "fingersSpread") then
                onFingersSpread()
                myo.vibrate("short")           
            end
            if (edge == "off") then
                myo.unlock("timed")
            end
        end
    end

function onWaveOut()
        local currentYaw = myo.getYaw()
        local currentPitch = myo.getPitch()
        local currentRoll = myo.getRoll()
        local deltaYaw = calculateDeltaRadians(currentYaw, centreYaw)
        deltaRoll = calculateDeltaRadians(currentRoll, centreRoll)
        deltaPitch = calculateDeltaRadians(currentPitch, centrePitch)
       -- myo.debug("Wave out")
        --if (deltaYaw < 2) then
            if (deltaRoll < -.2 and deltaRoll > -.6 and deltaPitch < -.8) then --
            myo.keyboard("x", "press")
            elseif (deltaRoll < -.6  and deltaRoll > -3 and deltaPitch < -.8) then
            myo.keyboard("b", "press")
            elseif (deltaRoll > -.2 and deltaPitch < -.8) then
            myo.keyboard("i", "press")
            elseif (deltaRoll >= -.6 and deltaRoll <= .2) then
            myo.keyboard("backspace", "press")
            elseif (deltaRoll > -3 and deltaRoll < -.6) then
            myo.keyboard("n", "press")
            elseif (deltaRoll > .2 and deltaRoll < .9) then
            myo.keyboard("s", "press")
            elseif (deltaRoll > .9) then
            myo.keyboard("h", "press")
            end
        
    end

    function onWaveIn()
        local currentYaw = myo.getYaw()
        local currentPitch = myo.getPitch()
        local currentRoll = myo.getRoll()
        local deltaYaw = calculateDeltaRadians(currentYaw, centreYaw)
        deltaRoll = calculateDeltaRadians(currentRoll, centreRoll)
        deltaPitch = calculateDeltaRadians(currentPitch, centrePitch)
        --myo.debug("Wave in")   
            if (deltaRoll < -.2 and deltaRoll > -.6 and deltaPitch < -.8) then --
            myo.keyboard("j", "press")
            elseif (deltaRoll < -.6  and deltaRoll > -3 and deltaPitch < -.8) then
            myo.keyboard("p", "press")
            elseif (deltaRoll > -.2 and deltaPitch < -.8) then
            myo.keyboard("w", "press")
            elseif (deltaRoll >= -.6 and deltaRoll <= .2) then
            myo.keyboard("u", "press")
            elseif (deltaRoll > -3 and deltaRoll < -.6) then
            myo.keyboard("m", "press")
            elseif (deltaRoll > .2 and deltaRoll < .9) then
            myo.keyboard("space", "press")
            elseif (deltaRoll > .9) then
            myo.keyboard("f", "press")
            end
    end

    function onFist()  
        local currentYaw = myo.getYaw()
        local currentPitch = myo.getPitch()
        local currentRoll = myo.getRoll()
        local deltaYaw = calculateDeltaRadians(currentYaw, centreYaw)
        deltaRoll = calculateDeltaRadians(currentRoll, centreRoll)
        deltaPitch = calculateDeltaRadians(currentPitch, centrePitch)
        --myo.debug("Fist")  
            if (deltaRoll > .2 and deltaRoll < .7 and deltaPitch < -.8) then --
            myo.keyboard("v", "press")
            elseif (deltaRoll < .2  and deltaRoll > -3 and deltaPitch < -.8) then
            myo.keyboard("g", "press")
            elseif (deltaRoll > .7 and deltaPitch < -.8) then
            myo.keyboard("q", "press")
            elseif (deltaRoll >= -.6 and deltaRoll <= .2) then
            myo.keyboard("e", "press")
            elseif (deltaRoll > -3 and deltaRoll < -.6) then
            myo.keyboard("t", "press")
            elseif (deltaRoll > .2 and deltaRoll < .9) then
            myo.keyboard("a", "press")
            elseif (deltaRoll > .9) then
            myo.keyboard("o", "press")
            end
    end

    function onFingersSpread() 
        local currentYaw = myo.getYaw()
        local currentPitch = myo.getPitch()
        local currentRoll = myo.getRoll()
        local deltaYaw = calculateDeltaRadians(currentYaw, centreYaw)
        deltaRoll = calculateDeltaRadians(currentRoll, centreRoll)
        deltaPitch = calculateDeltaRadians(currentPitch, centrePitch)        --myo.debug("Fingers Spread")
            if (deltaRoll > .2 and deltaRoll < .7 and deltaPitch < -.8) then --
            myo.keyboard("k", "press")
            elseif (deltaRoll < .2  and deltaRoll > -3 and deltaPitch < -.8) then
            myo.keyboard("y", "press")
            elseif (deltaRoll > .7 and deltaPitch < -.8) then
            myo.keyboard("z", "press")
            elseif (deltaRoll >= -.6 and deltaRoll <= .2) then
            myo.keyboard("r", "press")
            elseif (deltaRoll > -3 and deltaRoll < -.6) then
            myo.keyboard("d", "press")
            elseif (deltaRoll > .2 and deltaRoll < .9) then
            myo.keyboard("l", "press")
            elseif (deltaRoll > .9) then
            myo.keyboard("c", "press")
            end
    end 
    
function onPeriodic()  
        local currentYaw = myo.getYaw()
        local currentPitch = myo.getPitch()
        local currentRoll = myo.getRoll()
        local deltaYaw = calculateDeltaRadians(currentYaw, centreYaw)
        deltaRoll = calculateDeltaRadians(currentRoll, centreRoll)
        deltaPitch = calculateDeltaRadians(currentPitch, centrePitch)
        printCount = printCount + 1
        if printCount >= 200 then
           --myo.debug("deltaYaw = " .. deltaYaw .. ", currentYaw = " .. currentYaw)
           myo.debug("deltaPitch = " .. deltaPitch .. " currentPitch = " .. currentPitch)
           myo.debug("deltaRoll = " .. deltaRoll .. " currentRoll = " .. currentRoll)
            printCount = 0
        end
        -- You can use this to swap out different onPeriodic behaviour for different bindings
    end
function centre()  
        myo.debug("Centred")
        centreYaw = myo.getYaw()
        centreRoll = myo.getRoll()
        centrePitch = myo.getPitch()
        myo.controlMouse(false);
        myo.vibrate("short")
        myo.keyboard("return", "press")
    end

function calculateDeltaRadians(currentYaw, centreYaw)  
        local deltaYaw = currentYaw - centreYaw

        if (deltaYaw > PI) then
            deltaYaw = deltaYaw - TWOPI
        elseif(deltaYaw < -PI) then
            deltaYaw = deltaYaw + TWOPI
        end
        return deltaYaw
    end