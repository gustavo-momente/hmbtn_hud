
function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end


function printAffectionGirls(affectionAddr, name, x, y)
	affectionThresholds = {4999, 19999, 29999, 39999, 49999, 59999, 65535}
	affectionNames = {"Black", "Purple", "Blue", "Green", "Yellow", "Orange", "Red"}

	affection = memory.read_u16_le(affectionAddr)
	affectionThresholdsSize = table.getn(affectionThresholds)
	for i = 1, affectionThresholdsSize, 1
	do
		if(affection <= affectionThresholds[i]) then
			-- text = ""
			if (i < affectionThresholdsSize) then
				text = string.format("%-6s: %5d/%5d/%5d (%s)", name, affection, affectionThresholds[i], 
									 affectionThresholds[affectionThresholdsSize], affectionNames[i])
			else
				text = string.format("%-6s: %5d/%5d (%s)", name, affection, affectionThresholds[i], affectionNames[i])
			end
			-- path = string.format("./img/hearts/%d.png", i)
			-- gui.drawRectangle(x + 50, y - 20, 15, 12, nul, "white")
			-- gui.drawImage(path, x + 50, y - 10, 12, 10)
			gui.text(x, y, text)
			break
		end
	end
end


function printAffectionVillager(affectionAddr, name, x, y)
	affection = memory.read_u16_le(affectionAddr)
	text = string.format("%-13s: %3d/255", name, affection)
	gui.text(x, y, text, nul, "topright")
end

-- Main
local staminaAddr = 0x071A12
local fatigueAddr = 0x071A16
local lineHeight = 16
local karenAddr = 0x0767A0
local girls = {Ann = 0x076EF0, Elli = 0x077298, Karen = 0x0767A0, Mary = 0x077BBC, Popuri = 0x0786B4}
local villagers = {["Anna"] = 0x0779E6, ["Barley"] = 0x077D8E, ["Basil"] = 0x077812, ["Cliff"] = 0x07763E, 
				  ["Doctor"] = 0x0770C2, ["Doug"] = 0x076D1A, ["Duke"] = 0x078886, ["Ellen"] = 0x078C2E,
				  ["Gorumand"] = 0x0798FA, ["Gotz"] = 0x078E02, ["Gray"] = 0x076B46, ["Greg"] = 0x079CA2, 
				  ["Harris"] = 0x079552, ["Jeff"] = 0x0763F6, ["Kai"] = 0x078FD6, ["Kano"] = 0x079726,
				  ["Lillia"] = 0x07830A, ["Louis"] = 0x079ACE, ["Manna"] = 0x078A5A, ["May"] = 0x077F62,
				  ["Mayor Thomas"] = 0x078136, ["Pastor Carter"] = 0x07746A, ["Rick"] = 0x0784DE,
				  ["Saibara"] = 0x076972, ["Sasha"] = 0x0765CA, ["Stu"] = 0x07A04A, ["Won"] = 0x07A21E,
				  ["Your Baby"] = 0x07A3F2}

while true do

	-- Fatigue/Stamina
	stamina = memory.read_u16_le(staminaAddr)
	fatigue = memory.read_u16_le(fatigueAddr)

	strFtgStr = string.format("STM/FTG: %03d/%03d", stamina, fatigue)
	gui.text(0, lineHeight, strFtgStr)
	
	-- Girls affection
	girlsX = 0
	girlsStartY = 2 * lineHeight
	girlsCount = 0
	for name, addr in spairs(girls) do
		printAffectionGirls(addr, name, girlsX, girlsStartY + girlsCount * lineHeight)
		girlsCount = girlsCount + 1

	end

	-- Villagers affection
	villagersX = 0
	villagersStartY = lineHeight
	villagersCount = 0
	for name, addr in spairs(villagers) do
		printAffectionVillager(addr, name, villagersX, villagersStartY + villagersCount * lineHeight)
		villagersCount = villagersCount + 1
	end


	emu.frameadvance()
end