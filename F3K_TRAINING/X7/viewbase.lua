local display = {}

local sourceIdCache = {}

local function getFirstValue(sourceList)
	if not sourceList then
		return nil
	end

	for _, name in ipairs(sourceList) do
		local sourceId = sourceIdCache[name]
		if sourceId == nil then
			sourceId = getSourceIndex and getSourceIndex(name) or false
			sourceIdCache[name] = sourceId
		end

		local value = nil
		if sourceId and getSourceValue then
			value = getSourceValue(sourceId)
		end

		if value == nil then
			value = getValue(name)
		end

		if value ~= nil then
			return value
		end
	end

	return nil
end

function display.drawTelemetry()
	local modelVoltage = getFirstValue(F3KConfig.MODEL_VOLTAGE)
	local modelText = (modelVoltage ~= nil and string.format("M:%.1f", modelVoltage)) or "M:-.-"
	lcd.drawText(0, 38, modelText, 0)

	local radioVoltage = getFirstValue(F3KConfig.RADIO_VOLTAGE)
	local radioText = (radioVoltage ~= nil and string.format("R:%.1f", radioVoltage)) or "R:-.-"
	lcd.drawText(28, 38, radioText, 0)

	local altitude = getFirstValue(F3KConfig.HEIGHT)
	local altitudeText = (altitude ~= nil and string.format("A:%.0f", altitude)) or "A:?"
	lcd.drawText(56, 38, altitudeText, 0)
end

function display.drawCommon( task )
	lcd.drawText( 2, 2, task.name, 0 )
	task.timer1.draw( 24, 18, DBLSIZE )
	display.drawTelemetry()

	lcd.drawLine( 0, 47, 89, 47, SOLID, 2 )
	lcd.drawLine( 90, 0, 90, 63, SOLID, 2 )
end

function display.drawCommonLarge( task )
	lcd.drawText( 2, 2, task.name, 0 )
	task.timer1.draw( 22, 18, DBLSIZE )
	display.drawTelemetry()

	lcd.drawLine( 0, 47, 83, 47, SOLID, 2 )
	lcd.drawLine( 84, 0, 84, 63, SOLID, 2 )
end

function display.drawCommonLastBest( task )
	display.drawCommon( task )

	lcd.drawText( 2, 53, 'Current: ', 0 )
	task.timer2.drawReverse( lcd.getLastPos(), 50, MIDSIZE )

	lcd.drawFilledRectangle( 91, 53, 37, 11, 0 )
	lcd.drawTimer( 100, 55, task.times.getTotal(), INVERS )
end


return display