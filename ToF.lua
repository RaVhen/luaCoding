--焦点目标
local ToFFrame = CreateFrame("Button", "ToFFrame", FocusFrame, "SecureUnitButtonTemplate");
ToFFrame:SetFrameLevel(7);
ToFFrame:SetWidth(96);
ToFFrame:SetHeight(48);
ToFFrame:ClearAllPoints();
ToFFrame:SetPoint("LEFT", FocusFrame, "RIGHT", -20, 0);
ToFFrame:SetAlpha(0);
ToFFrame:SetMovable(1);

ToFFrame.Portrait = ToFFrame:CreateTexture("ToFPortrait", "BORDER");
ToFFrame.Portrait:SetWidth(27);
ToFFrame.Portrait:SetHeight(27);
ToFFrame.Portrait:ClearAllPoints();
ToFFrame.Portrait:SetPoint("TOPLEFT", ToFFrame, "TOPLEFT", 6, -5);

ToFFrame.Texture = ToFFrame:CreateTexture("ToFTexture", "ARTWORK");
ToFFrame.Texture:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame");
ToFFrame.Texture:SetWidth(96);
ToFFrame.Texture:SetHeight(48);
ToFFrame.Texture:ClearAllPoints();
ToFFrame.Texture:SetPoint("TOPLEFT", ToFFrame, "TOPLEFT", 0, -2);

ToFFrame.Name = ToFFrame:CreateFontString("ToFName", "ARTWORK", "GameFontNormalSmall");
ToFFrame.Name:ClearAllPoints();
ToFFrame.Name:SetFont("Fonts\\cn_bold.TTF", 9, "OUTLINE")
ToFFrame.Name:SetPoint("BOTTOMLEFT", ToFFrame, "BOTTOMLEFT", 33, 39);

ToFFrame.HealthBar = CreateFrame("StatusBar", "ToFHealthBar", FocusFrame);
ToFFrame.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToFFrame.HealthBar:SetFrameLevel(2);
ToFFrame.HealthBar:SetMinMaxValues(0, 100);
ToFFrame.HealthBar:SetValue(0);
ToFFrame.HealthBar:SetWidth(53);
ToFFrame.HealthBar:SetHeight(9);
ToFFrame.HealthBar:ClearAllPoints();
ToFFrame.HealthBar:SetPoint("TOPLEFT", ToFFrame, "TOPLEFT", 35, -9);
ToFFrame.HealthBar:SetStatusBarColor(0, 1, 0);

ToFFrame.PowerBar = CreateFrame("StatusBar", "ToFPowerBar", FocusFrame);
ToFFrame.PowerBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToFFrame.PowerBar:SetFrameLevel(2);
ToFFrame.PowerBar:SetMinMaxValues(0, 100);
ToFFrame.PowerBar:SetValue(0);
ToFFrame.PowerBar:SetWidth(53);
ToFFrame.PowerBar:SetHeight(2);
ToFFrame.PowerBar:ClearAllPoints();
ToFFrame.PowerBar:SetPoint("TOPLEFT", ToFFrame, "TOPLEFT", 35, -19);
ToFFrame.PowerBar:SetStatusBarColor(0, 0, 1);

local showmenu = (function()
	ToggleDropDownMenu(1, nil, ToFFrame.DropDown, "ToFFrame", 40, 0);
end)
SecureUnitButton_OnLoad(ToFFrame, "focustarget", showmenu);

local oldscale = 1 ;
local newscale = 1.1;
local tof = CreateFrame("Frame");
tof:SetScript("OnUpdate", function(self, elapsed)
	self.timer = (self.timer or 0) + elapsed;
	if self.timer >= 0.1 then
		if UnitExists("focustarget") then
			ToFFrame:SetAlpha(1);
			local name = UnitName("focustarget")
			local tmp = string.format("%.11s", name)
			ToFFrame.Name:SetText(tmp);

			ToFNameColor = PowerBarColor[UnitPowerType("focustarget")] or PowerBarColor["MANA"];
			ToFFrame.PowerBar:SetStatusBarColor(ToFNameColor.r, ToFNameColor.g, ToFNameColor.b);

			SetPortraitTexture(ToFFrame.Portrait, "focustarget");

			if UnitHealthMax("focustarget") > 0 then
				ToFFrame.HealthBar:SetValue(UnitHealth("focustarget") / UnitHealthMax("focustarget") * 100);
			else
				ToFFrame.HealthBar:SetValue(0);
			end

			if UnitPowerMax("focustarget") > 0 then
				ToFFrame.PowerBar:SetValue(UnitPower("focustarget") / UnitPowerMax("focustarget") * 100);
			else
				ToFFrame.PowerBar:SetValue(0);
			end
		else
			ToFFrame:SetAlpha(0);
			ToFFrame.HealthBar:SetValue(0);
			ToFFrame.PowerBar:SetValue(0);
		end
		self.timer = 0;
	end
	if UnitIsPlayer("focustarget") then
		HealthBarColor = RAID_CLASS_COLORS[select(2, UnitClass("focustarget"))];
	else	
		HealthBarColor = FACTION_BAR_COLORS[UnitReaction("focustarget", "player")];
	end
	if UnitIsEnemy("focustarget","player") and UnitIsPlayer("focustarget") then
		color = {r=1, g=0, b=0};
	else
		color = HealthBarColor;
	end
	if HealthBarColor and color then
		ToFFrame.HealthBar:SetStatusBarColor(HealthBarColor.r, HealthBarColor.g, HealthBarColor.b);
		ToFFrame.Name:SetVertexColor(color.r, color.g, color.b);
	end
end);

if (not InCombatLockdown()) then
	local point, relativeTo, relativePoint, offsetX, offsetY = ToFFrame:GetPoint();
	ToFFrame:SetScale(newscale);
	ToFFrame.HealthBar:SetScale(newscale);
	ToFFrame.PowerBar:SetScale(newscale);
	ToFFrame:ClearAllPoints();
	ToFFrame:SetPoint(point, relativeTo, relativePoint, offsetX*oldscale/newscale, offsetY*oldscale/newscale);
end