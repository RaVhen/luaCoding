
CastingBarFrame:ClearAllPoints()
CastingBarFrame:SetPoint("CENTER",UIParent,"CENTER", 5, -250)
CastingBarFrame.SetPoint = function() end
CastingBarFrame:SetScale(1.1)

local frame = {
	["PlayerFrame"] = { 	
		position = {"CENTER", UIParent, "CENTER", -450, 195};
		scale = 1},		
};

local function initPlayer()

	PlayerFrame:ClearAllPoints()
	PlayerFrame:SetPoint(unpack(frame["PlayerFrame"].position));
	PlayerFrame:SetScale(frame["PlayerFrame"].scale)
	--PlayerFrame.SetPoint = function() end


	PlayerFrameHealthBar:ClearAllPoints()
	PlayerFrameHealthBar:SetPoint("TOPLEFT", 107, -24)
	--PlayerFrameHealthBar.SetPoint = function() end
	PlayerFrameHealthBar:SetHeight(28)

	PlayerFrameGroupIndicatorText:ClearAllPoints()
	PlayerFrameGroupIndicatorText:SetPoint("BOTTOMLEFT", PlayerFrame, "TOP", 0, -20)
	PlayerFrameGroupIndicatorLeft:Hide()
	PlayerFrameGroupIndicatorMiddle:Hide()
	PlayerFrameGroupIndicatorRight:Hide()

	PlayerFrameHealthBar.TextString:ClearAllPoints()
	PlayerFrameHealthBar.TextString:SetPoint("CENTER", PlayerFrame, "CENTER", 50, 13)

end

---------- // PLAYER COLOR BAR // ----------
local chb = CreateFrame("Frame")
PlayerFrameHealthBar:SetScript("OnValueChanged", nil)
chb:RegisterEvent("PLAYER_ENTERING_WORLD")
chb:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
chb:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
chb:SetScript("OnEvent", function(self, event, ...)
	print(event)
	initPlayer()
	local HealthBarColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))] or {r=0, g=1, b=0}
	--if UnitHasVehicleUI("player") then HealthBarColor = {r=0, g=1, b=0} end
	PlayerFrameHealthBar:SetStatusBarColor(HealthBarColor.r, HealthBarColor.g, HealthBarColor.b)
end)
PlayerFrameHealthBar.lockColor = true
