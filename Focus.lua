FocusFrame.nameBackground:Hide()
FocusFrameBackground:Hide()
FocusFrameHealthBar.background = FocusFrameHealthBar:CreateTexture("FocusFrameHealthBarBackground", "BACKGROUND")
FocusFrameHealthBar.background:SetTexture(0, 0, 0, 0.5)
FocusFrameHealthBar.background:SetAllPoints()

FocusFrameManaBar.background = FocusFrameManaBar:CreateTexture("FocusFrameHealthBarBackground", "BACKGROUND")
FocusFrameManaBar.background:SetTexture(0, 0, 0, 0.5)
FocusFrameManaBar.background:SetAllPoints()

FocusFrameHealthBar:ClearAllPoints()
FocusFrameHealthBar:SetPoint("TOPLEFT", 5, -24)
FocusFrameHealthBar.SetPoint = function() end
FocusFrameHealthBar:SetHeight(27)
FocusFrame.deadText:ClearAllPoints()
FocusFrame.deadText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)

FocusFrameHealthBar.TextString:ClearAllPoints();
FocusFrameHealthBar.TextString:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)
FocusFrameTextureFrameName:SetVertexColor(1, 1, 1)
FocusFrameTextureFrameName:ClearAllPoints()
FocusFrameTextureFrameName:SetFont("Fonts\\cn_bold.TTF", 12, "OUTLINE")
FocusFrameTextureFrameName:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 20)

---------- // FOCUS COLOR BAR // ----------
local function focusChanged()
   FocusFrame.nameBackground:Hide()
	FocusFrameBackground:Hide()
	if UnitExists("focus") then
		local HealthBarColor = {r=0, g=1, b=0}
		local color = {r=1, g=0, b=0}
		if UnitIsPlayer("focus") then
			HealthBarColor = RAID_CLASS_COLORS[select(2, UnitClass("focus"))] or {r=0, g=1, b=0};
		else	
			HealthBarColor = FACTION_BAR_COLORS[UnitReaction("focus", "player")]
		end
		if UnitIsEnemy("focus","player") and UnitIsPlayer("focus") then
			color = {r=1, g=0, b=0};
		else
			color = HealthBarColor
		end
		if ( not UnitPlayerControlled("focus") and UnitIsTapped("focus") and not UnitIsTappedByPlayer("focus") and not UnitIsTappedByAllThreatList("focus") ) then
			FocusFrameHealthBar:SetStatusBarColor(0.5, 0.5, 0.5)
		else
			FocusFrameHealthBar:SetStatusBarColor(HealthBarColor.r, HealthBarColor.g, HealthBarColor.b);
		end
		FocusFrameTextureFrameName:SetVertexColor(color.r, color.g, color.b)
	end
end

local chb = CreateFrame("Frame")
FocusFrameHealthBar:SetScript("OnValueChanged", nil)
chb:RegisterEvent("PLAYER_FOCUS_CHANGED")
chb:RegisterEvent("UNIT_FACTION")
chb:RegisterEvent("UNIT_COMBAT")
chb:SetScript("OnEvent", focusChanged)
FocusFrameHealthBar.lockColor = true
