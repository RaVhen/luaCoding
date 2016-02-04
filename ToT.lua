--ToT

local ToTFrame = CreateFrame("Button", "ToTFrame", TargetFrame, "SecureUnitButtonTemplate");
ToTFrame:SetFrameLevel(8);
ToTFrame:SetWidth(96);
ToTFrame:SetHeight(48);
ToTFrame:ClearAllPoints();
ToTFrame:SetPoint("LEFT", TargetFrame, "RIGHT", -20, 0);
ToTFrame:SetAlpha(0);
ToTFrame:SetMovable(1);

ToTFrame.Portrait = ToTFrame:CreateTexture("ToTPortrait", "BORDER");
ToTFrame.Portrait:SetWidth(27);
ToTFrame.Portrait:SetHeight(27);
ToTFrame.Portrait:ClearAllPoints();
ToTFrame.Portrait:SetPoint("TOPLEFT", ToTFrame, "TOPLEFT", 6, -5);

ToTFrame.Texture = ToTFrame:CreateTexture("ToTTexture", "ARTWORK");
ToTFrame.Texture:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame");
ToTFrame.Texture:SetWidth(96);
ToTFrame.Texture:SetHeight(48);
ToTFrame.Texture:ClearAllPoints();
ToTFrame.Texture:SetPoint("TOPLEFT", ToTFrame, "TOPLEFT", 0, -2);

ToTFrame.Name = ToTFrame:CreateFontString("ToTName", "ARTWORK", "GameFontNormalSmall");
ToTFrame.Name:ClearAllPoints();
ToTFrame.Name:SetFont("Fonts\\cn_bold.TTF", 9, "OUTLINE")
ToTFrame.Name:SetPoint("BOTTOMLEFT", ToTFrame, "BOTTOMLEFT", 33, 39);

ToTFrame.HealthBar = CreateFrame("StatusBar", "ToTHealthBar", TargetFrame);
ToTFrame.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToTFrame.HealthBar:SetFrameLevel(2);
ToTFrame.HealthBar:SetMinMaxValues(0, 100);
ToTFrame.HealthBar:SetValue(0);
ToTFrame.HealthBar:SetWidth(53);
ToTFrame.HealthBar:SetHeight(9);
ToTFrame.HealthBar:ClearAllPoints();
ToTFrame.HealthBar:SetPoint("TOPLEFT", ToTFrame, "TOPLEFT", 35, -9);
ToTFrame.HealthBar:SetStatusBarColor(0, 1, 0);

ToTFrame.PowerBar = CreateFrame("StatusBar", "ToTPowerBar", TargetFrame);
ToTFrame.PowerBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToTFrame.PowerBar:SetFrameLevel(2);
ToTFrame.PowerBar:SetMinMaxValues(0, 100);
ToTFrame.PowerBar:SetValue(0);
ToTFrame.PowerBar:SetWidth(53);
ToTFrame.PowerBar:SetHeight(2);
ToTFrame.PowerBar:ClearAllPoints();
ToTFrame.PowerBar:SetPoint("TOPLEFT", ToTFrame, "TOPLEFT", 35, -19);
ToTFrame.PowerBar:SetStatusBarColor(0, 0, 1);

local showmenu = (function()
	ToggleDropDownMenu(1, nil, ToTFrame.DropDown, "ToTFrame", 40, 0);
end)
SecureUnitButton_OnLoad(ToTFrame, "targettarget", showmenu);

local oldscale = 1 ;
local newscale = 1.2 ;
local tot = CreateFrame("Frame");
local ToTNameColor = PowerBarColor["MANA"];
tot:SetScript("OnUpdate", function(self, elapsed)
	self.timer = (self.timer or 0) + elapsed;
	if self.timer >= 0.1 then
		if UnitExists("targettarget") then
			ToTFrame:SetAlpha(1);
			ToTFrame.Name:SetText(UnitName("targettarget"));

			ToTNameColor = PowerBarColor[UnitPowerType("targettarget")] or PowerBarColor["MANA"];
			ToTFrame.PowerBar:SetStatusBarColor(ToTNameColor.r, ToTNameColor.g, ToTNameColor.b);

			SetPortraitTexture(ToTFrame.Portrait, "targettarget");

			if UnitHealthMax("targettarget") > 0 then
				ToTFrame.HealthBar:SetValue(UnitHealth("targettarget") / UnitHealthMax("targettarget") * 100);
				
			else
				ToTFrame.HealthBar:SetValue(0);
			end

			if UnitPowerMax("targettarget") > 0 then
				ToTFrame.PowerBar:SetValue(UnitPower("targettarget") / UnitPowerMax("targettarget") * 100);
			else
				ToTFrame.PowerBar:SetValue(0);
			end
		else
			ToTFrame:SetAlpha(0);
			ToTFrame.HealthBar:SetValue(0);
			ToTFrame.PowerBar:SetValue(0);
		end
		self.timer = 0;
	end
	if UnitIsPlayer("targettarget") then
		HealthBarColor = RAID_CLASS_COLORS[select(2, UnitClass("targettarget"))];
	else	
		HealthBarColor = FACTION_BAR_COLORS[UnitReaction("targettarget", "player")];
	end
	if UnitIsEnemy("targettarget","player") and UnitIsPlayer("targettarget") then
		color = {r=1, g=0, b=0};
	else
		color = HealthBarColor;
	end
	if HealthBarColor and color then
		ToTFrame.HealthBar:SetStatusBarColor(HealthBarColor.r, HealthBarColor.g, HealthBarColor.b);
		ToTFrame.Name:SetVertexColor(color.r, color.g, color.b);
	end
end);

if (not InCombatLockdown()) then
	local point, relativeTo, relativePoint, offsetX, offsetY = ToTFrame:GetPoint();
	ToTFrame:SetScale(newscale);
	ToTFrame.HealthBar:SetScale(newscale);
	ToTFrame.PowerBar:SetScale(newscale);
	ToTFrame:ClearAllPoints();
	ToTFrame:SetPoint(point, relativeTo, relativePoint, offsetX*oldscale/newscale, offsetY*oldscale/newscale);
end
