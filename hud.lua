local staminaAddr = 0x071A12
local fatigueAddr = 0x071A16
local lineHeight = 16

while true do
	stamina = memory.read_s16_le(staminaAddr)
	fatigue = memory.read_s16_le(fatigueAddr)

	strFtgStr = string.format("STM/FTG: %03d/%03d", stamina, fatigue)
	gui.text(0, lineHeight, strFtgStr)
	-- gui.text(0, 2 * lineHeight, "Fatigue: " .. fatigue, nil, nil, fontSize)
	emu.frameadvance()
end