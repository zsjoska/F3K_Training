local display = {}

function display.drawTelemetry()
	-- print(F3KConfig.MODEL_VOLTAGE)
	if (F3KConfig.MODEL_VOLTAGE) then
		mv, c1, f1 = getSourceValue(F3KConfig.MODEL_VOLTAGE)
		mvStr = (mv and string.format("M:%.1f", mv)) or "M:-.-"
		lcd.drawText(0, 38, mvStr, 0)
	end

	if(F3KConfig.RADIO_VOLTAGE) then
		rv, c1, f1 = getSourceValue(F3KConfig.RADIO_VOLTAGE)
		rvStr = (rv and string.format("R:%.1f", rv)) or "R:-.-"
		lcd.drawText(28, 38, rvStr, 0)
	end
	
	if(F3KConfig.HEIGHT) then
		h, c1, f1 = getSourceValue(F3KConfig.HEIGHT)
		hStr = (h and string.format("A:%.0f", h)) or "A:?"
		lcd.drawText(56, 38, hStr, 0)
	end
end


function display.drawCommon( task )
	lcd.drawText( 2, 2, task.name, 0 )
	task.timer1.draw( 24, 15, DBLSIZE )
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
