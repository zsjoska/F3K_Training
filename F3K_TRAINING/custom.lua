--[[
	F3K Training - 	Mike, ON4MJ

	custom.lua
	This file is meant to contain the things which can be customized by the user
	See the documentation
--]]


-- Customize your switches and menu scroll input axis here.

-- On Horus using widgets, you can customize it in the GUI Widget settings menu 
-- by holding the select button while the widget is selected.

local PRELAUNCH_SWITCH = 'sa' 		-- temporary switch on the left
local MENU_SWITCH = 'sc'		-- a 3-pos switch is mandatory here : up=menu; mid=stop; down=run
local MENU_SCROLL_ENCODER = 'thr'

local RADIO_VOLTAGE = {"Batt"}
local MODEL_VOLTAGE = {"RxBt", "Rbt"}
local HEIGHT = {"GAlt", "Valt"}

local SOUND_PATH = F3K_SCRIPT_PATH .. 'sounds/'




local lastTimeLanded = 0	-- 0=must pull first ; other=time of the last pull

local function resetLaunchDetection()
	lastTimeLanded = 0
end



-- >>> Launch / Land detection <<< ---
local function launched()
	local ret = false
	if getValue( Options.PrelaunchSwitch ) < 0 then
		-- if the tmp switch is held for more than 0.6s, it's a launch ;
		-- otherwise it was just a trigger pull to indicate that the plane has landed
		if lastTimeLanded > 0 then
			if (getTime() - lastTimeLanded) > 60 then
				ret = true
			end
			lastTimeLanded = 0
		end
	else
		if lastTimeLanded == 0 then
			lastTimeLanded = getTime()
		end
	end
	return ret
end

local function landed()
	if getValue( Options.PrelaunchSwitch ) > 0 then
		lastTimeLanded = getTime()
		return true
	end
	return false
end
-- <<< End of launch/land detection section <<< --


--[[
	-- Alternate implementation of the launched / landed logic through traditional Tx programmation
	-- 	* Logical switch LS31 would be "launch detected"
	-- 	* Logical switch LS32 would be "landing detected"

local function launched()
	return getValue( 'ls31' ) > 0
end

local function landed()
	return getValue( 'ls32' ) > 0
end	
--]]

local function safeGetSoundPath(basePath)
	local ok, msg = pcall( function()
		local ver, radio, maj, minor, rev, osname = getVersion()
		if(osname and osname == 'EdgeTX') then
			return F3K_SCRIPT_PATH .. 'sndhd/'
		end
		return basePath
	end )

	if(not ok) then
		print(msg)
		return basePath
	end
	return msg
end

-- local function safeGetFieldIfoId(fieldList)
-- 	for key,value in ipairs(fieldList) 
-- 	do
-- 		local fi = getFieldInfo(value)
-- 		if( fi ) then
-- 			print("telemetry "..value.." looks usable")
-- 			return fi.id
-- 		end
-- 	end
-- 	return nil	
-- end

return { 
	MENU_SWITCH = getFieldInfo( MENU_SWITCH ).id,
	PRELAUNCH_SWITCH = getFieldInfo( PRELAUNCH_SWITCH ).id,
	MENU_SCROLL_ENCODER = getFieldInfo( MENU_SCROLL_ENCODER ).id,
	SOUND_PATH = safeGetSoundPath(SOUND_PATH),
	-- RADIO_VOLTAGE = safeGetFieldIfoId( RADIO_VOLTAGE ),
	-- MODEL_VOLTAGE = safeGetFieldIfoId( MODEL_VOLTAGE ),
	-- HEIGHT = safeGetFieldIfoId( HEIGHT ),
	RADIO_VOLTAGE = RADIO_VOLTAGE,
	MODEL_VOLTAGE = MODEL_VOLTAGE,
	HEIGHT = HEIGHT,

	resetLaunchDetection = resetLaunchDetection,
	launched = launched,
	landed = landed
}
