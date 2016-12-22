local FatigueAddr = 0x071A14
local Fatigue

while true do
	gui.text(0,20,"Fatigue: " .. FatigueAddr)
	Fatigue = memory.readword(FatigueAddr)
	gui.text(0,0,"Fatigue: " .. Fatigue)
	emu.frameadvance()
end