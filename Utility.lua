---------- // Config // ----------
local frame = {
	["PlayerFrame"] = { 	
		position = {"CENTER", UIParent, "CENTER", -210, -185};
		scale = 1.1},		
	["PlayerFrameExtraBar"] = { 	
		position = {"CENTER", UIParent, "CENTER", 200, -200};
		scale = 1},
	["PetFrame"] = { 	
		position = {"CENTER","PlayerFrame","CENTER", 0, -50};
		scale = 1},													
	["TargetFrame"]	= {
		position = {"CENTER", UIParent,"CENTER", -225, 195};  --100 , -45
		scale = 1},
	["TargetFrameToT"] =	{
		position = {"CENTER","TargetFrame", "CENTER", 125, -10};
		scale = 1},
	["FocusFrame"] = {
		position = {"CENTER", UIParent, "CENTER", 310, 0};		
		scale = 1},
	["FocusFrameToT"] = {
		position = {"CENTER", "FocusFrame", "CENTER", 52, -37};	
		scale = 1},
	["PartyMemberFrame1"] = {
		position = {"CENTER",UIParent,"CENTER", -400, 100};
		scale = 1.2},
	["Boss1TargetFrame"] = {
		position = {"CENTER",UIParent,"CENTER", 800, 125};
		scale = 0.75},
	["ScenarioBlocksFrame"] = {
		position = {"TOPRIGHT",MinimapCluster,"BOTTOMRIGHT", -10, 0};
		scale = 0.75},
};

PlayerHitIndicator:SetText(nil) 
PlayerHitIndicator.SetText = function() end
PetHitIndicator:SetText(nil) 
PetHitIndicator.SetText = function() end

SetCVar("showAllEnemyDebuffs", 0)
SetCVar("showAllEnemyDebuffs", 1)
SetCVar("stopAutoAttackOnTargetChange", 0)
SetCVar("stopAutoAttackOnTargetChange", 1)

MainMenuBarLeftEndCap:Hide()
MainMenuBarRightEndCap:Hide()
MainMenuBarRightEndCap:SetPoint("CENTER", 32, 0)
MainMenuBarMaxLevelBar:SetAlpha(0)
MinimapBorderTop:Hide()
MinimapBorder:Hide()
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')


-- MainMenuBar:ClearAllPoints()
-- MainMenuBar:SetPoint("BOTTOM", 200, 0)
-- MainMenuBar.SetPoint = function() end

--MainMenuExpBar:SetAlpha(0)
MonkHarmonyBar:Hide()
--StanceBarFrame:SetAlpha(0)
MainMenuBar:SetPoint("CENTER", 32, 0)
MainMenuBarTexture0:Hide()
MainMenuBarTexture1:Hide()
MainMenuBarTexture2:Hide()
MainMenuBarTexture3:Hide()

StanceBarFrame:ClearAllPoints()
StanceBarFrame:SetPoint ("CENTER", -300, 75)
StanceBarFrame:SetScale (1.1)
StanceBarFrame.SetPoint = function() end

BuffFrame:SetScale(1.1)
TemporaryEnchantFrame:SetScale(1.1)

MonkHarmonyBar:Hide()
MonkHarmonyBar:HookScript("OnShow",function(self) self:Hide() end)

PriestBarFrame:Hide()
PriestBarFrame:HookScript("OnShow",function(self) self:Hide() end)

EclipseBarFrame:ClearAllPoints()
EclipseBarFrame:SetScale (1.1)
EclipseBarFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, -100)
EclipseBarFrame.SetPoint = function() end

---------- // MOVE FRAMES // ----------

local _, class = UnitClass("player")
-- Player frame
hooksecurefunc("PlayerFrame_ResetPosition", function(self)
	--self:ClearAllPoints()
	PlayerFrame.name:Hide() 
	PlayerFrameFlash:Hide(); PlayerFrameFlash.Show = function() end
	TargetFrameFlash:Hide(); TargetFrameFlash.Show = function() end
	FocusFrameFlash:Hide(); FocusFrameFlash.Show = function() end
	if ( class == "nill") then
	print(class)
		self:SetPoint(unpack(frame["PlayerFrameExtraBar"].position))
		PlayerFrame:SetScale(frame["PlayerFrameExtraBar"].scale)
	else
		--self:SetPoint(unpack(frame["PlayerFrame"].position))
		--PlayerFrame:SetScale(frame["PlayerFrame"].scale) 
	end
end)




--Pet Frame
PetFrame:ClearAllPoints()
PetFrame:SetPoint(unpack(frame["PetFrame"].position));
PetFrame:SetScale(frame["PetFrame"].scale)
PetFrame.SetPoint = function() end


-- Target frame
TargetFrame:ClearAllPoints()
TargetFrame:SetPoint(unpack(frame["TargetFrame"].position));
TargetFrame:SetScale(frame["TargetFrame"].scale)

-- Target of target frame
TargetFrameToT:ClearAllPoints()
TargetFrameToT:SetPoint(unpack(frame["TargetFrameToT"].position));
TargetFrameToT:SetScale(frame["TargetFrameToT"].scale)

-- Focus frame
FocusFrame:ClearAllPoints()
FocusFrame:SetPoint(unpack(frame["FocusFrame"].position))
FocusFrame:SetScale(frame["FocusFrame"].scale)
FocusFrameSpellBar:ClearAllPoints()
FocusFrameSpellBar:SetPoint("CENTER", FocusFrame, "CENTER", -10,50)	
FocusFrameSpellBar.SetPoint = function() end

	
-- Target of focus frame
FocusFrameToT:ClearAllPoints()
FocusFrameToT:SetPoint(unpack(frame["FocusFrameToT"].position))
FocusFrameToT:SetScale(frame["FocusFrameToT"].scale)

-- Party Frame
PartyMemberFrame1:ClearAllPoints()
PartyMemberFrame1:SetPoint(unpack(frame["PartyMemberFrame1"].position))
PartyMemberFrame1:SetScale(frame["PartyMemberFrame1"].scale)
PartyMemberFrame2:SetScale(frame["PartyMemberFrame1"].scale)
PartyMemberFrame3:SetScale(frame["PartyMemberFrame1"].scale)
PartyMemberFrame4:SetScale(frame["PartyMemberFrame1"].scale)

-- BOSS FRAME
Boss1TargetFrame:ClearAllPoints()
Boss1TargetFrame:SetPoint(unpack(frame["Boss1TargetFrame"].position))
Boss1TargetFrame:SetScale(frame["Boss1TargetFrame"].scale)
Boss1TargetFrame.SetPoint = function() end

Boss2TargetFrame:ClearAllPoints()
Boss2TargetFrame:SetPoint("CENTER", Boss1TargetFrame, "CENTER", 0, -125)
Boss2TargetFrame:SetScale(frame["Boss1TargetFrame"].scale)
Boss2TargetFrame.SetPoint = function() end

Boss3TargetFrame:ClearAllPoints()
Boss3TargetFrame:SetPoint("CENTER", Boss2TargetFrame, "CENTER", 0, -125)
Boss3TargetFrame:SetScale(frame["Boss1TargetFrame"].scale)
Boss3TargetFrame.SetPoint = function() end

Boss4TargetFrame:ClearAllPoints()
Boss4TargetFrame:SetPoint("CENTER", Boss3TargetFrame, "CENTER", 0, -125)
Boss4TargetFrame:SetScale(frame["Boss1TargetFrame"].scale)
Boss4TargetFrame.SetPoint = function() end

Boss5TargetFrame:ClearAllPoints()
Boss5TargetFrame:SetPoint("CENTER", Boss4TargetFrame, "CENTER", 0, -125)
Boss5TargetFrame:SetScale(frame["Boss1TargetFrame"].scale)
Boss5TargetFrame.SetPoint = function() end

-- Scenario Block
ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:Hide()
ObjectiveTrackerFrame.HeaderMenu.MinimizeButton:Hide()
ScenarioStageBlock.Stage:Hide()
ScenarioStageBlock.NormalBG:Hide()
ScenarioStageBlock.GlowTexture:Hide()
ScenarioStageBlock.Name:Hide()
ScenarioStageBlock.Stage:Hide()
--ObjectiveTrackerFrame:ClearAllPoints()
ObjectiveTrackerFrame:SetPoint(unpack(frame["ScenarioBlocksFrame"].position))
ObjectiveTrackerFrame:SetScale(frame["ScenarioBlocksFrame"].scale)
ObjectiveTrackerFrame.SetPoint = function() end

---------- // CASTBARS // ----------
local cbf = "CastingBarFrame"
_G[cbf.."Icon"]:Show()
_G[cbf.."Icon"]:SetHeight(25)
_G[cbf.."Icon"]:SetWidth(25)
--[[ castbar timer from thek ]]
_G[cbf].timer = _G[cbf]:CreateFontString(nil)
_G[cbf].timer:SetFont("Fonts\\cn_bold.ttf", 14, "OUTLINE")
_G[cbf].timer:SetPoint("RIGHT", _G[cbf], "RIGHT", 28, 2.5)
_G[cbf].update = .1
local tcbf = "TargetFrameSpellBar"
_G[tcbf].timer = _G[tcbf]:CreateFontString(nil)
_G[tcbf].timer:SetFont("Fonts\\cn_bold.ttf", 13, "OUTLINE")
_G[tcbf].timer:SetPoint("RIGHT", _G[tcbf], "RIGHT", 24, 0)
_G[tcbf].update = .1
local fcbf = "FocusFrameSpellBar"
_G[fcbf].timer = _G[fcbf]:CreateFontString(nil)
_G[fcbf].timer:SetFont("Fonts\\cn_bold.ttf", 13, "OUTLINE")
_G[fcbf].timer:SetPoint("RIGHT", _G[fcbf], "RIGHT", 24, 0)
_G[fcbf].update = .1
hooksecurefunc("CastingBarFrame_OnUpdate", function(self, elapsed)
	if not self.timer then return end
		if self.update and self.update < elapsed then
			if self.casting then
				self.timer:SetText(format("%.1f", max(self.maxValue - self.value, 0)))
			elseif self.channeling then
				self.timer:SetText(format("%.1f", max(self.value, 0)))
			else
				self.timer:SetText("")
			end
		self.update = .1
	else
	  self.update = self.update - elapsed
	end
end)

---------- // DARK FRAMES // ----------
local ef=CreateFrame("Frame")
   	ef:RegisterEvent("ADDON_LOADED")
	ef:SetScript("OnEvent", function(self, event, addon)
	if(addon=="Blizzard_TimeManager") then
		for i,v in pairs({
			PlayerFrameTexture, 
			CastingBarFrameBorder,
			PetFrameTexture, 
			TargetFrameTextureFrameTexture, 
			TargetFrameToTTextureFrameTexture, 
			TargetFrameSpellBarBorder,
			ToTFrame.Texture,
			ToFFrame.Texture,
			TargetFrameSpellBarBorder,
			PartyMemberFrame1Texture,
			PartyMemberFrame2Texture,
			PartyMemberFrame3Texture,
			PartyMemberFrame4Texture,
			PartyMemberFrame1PetFrameTexture,
			PartyMemberFrame2PetFrameTexture,
			PartyMemberFrame3PetFrameTexture,
			PartyMemberFrame4PetFrameTexture,
			FocusFrameTextureFrameTexture, 
			FocusFrameToTTextureFrameTexture,
			FocusFrameSpellBarBorder, 
			BonusActionBarFrameTexture0,
			BonusActionBarFrameTexture1,
			BonusActionBarFrameTexture2,
			BonusActionBarFrameTexture3,
			BonusActionBarFrameTexture4,	
			MainMenuBarTexture0,
			MainMenuBarTexture1,
			MainMenuBarTexture2,
			MainMenuBarTexture3,
			MainMenuMaxLevelBar0,
			MainMenuMaxLevelBar1,
			MainMenuMaxLevelBar2,
			MainMenuMaxLevelBar3,		
			MinimapBorder,
			AtlasLoot_MiniMapButton.overlay,
			QueueStatusMinimapButtonBorder,
			LibDBIcon10_Skada.overlay,
			GarrisonLandingPageMinimapButtonBorder,
			MiniMapTrackingButtonBorder,
			MiniMapLFGFrameBorder,
			MiniMapBattlefieldBorder,
			MiniMapMailBorder,	 
			select(1, TimeManagerClockButton:GetRegions()), 
		}) do
			v:SetVertexColor(.2, .2, .2)
        end
		for i,v in pairs({
			select(2, TimeManagerClockButton:GetRegions()),
		}) do
            v:SetVertexColor(1, 1, 1)
        end 
		self:UnregisterEvent("ADDON_LOADED")
		ef:SetScript("OnEvent", nil)
    end
end)
for i,v in pairs({
	MainMenuBarLeftEndCap,
	MainMenuBarRightEndCap,  
	PlayerPVPIcon,
	FocusFrameTextureFramePVPIcon,
	TargetFrameTextureFramePVPIcon,
}) do
	v:SetVertexColor(.5, .5, .5)
end

---------- // MINIMAP // ----------
MinimapBorderTop:Hide()
MiniMapWorldMapButton:Hide()
MinimapZoneText:SetPoint("TOPLEFT","MinimapZoneTextButton","TOPLEFT", 8, 0) -- to center the minimap zone text
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
Minimap:EnableMouseWheel(true)
Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, delta)
	if delta > 0 then
		Minimap_ZoomIn()
	else
		Minimap_ZoomOut() 
	end
end)



---------- // ACTION BAR TEXTURE FIX // ----------
hooksecurefunc("ActionButton_ShowGrid", function(btn)
for i=1,12 do
	local buttonTexture = _G["ActionButton"..i.."NormalTexture"]:SetVertexColor(1, 1, 1, 1)
	local buttonTexture = _G["MultiBarBottomRightButton"..i.."NormalTexture"]:SetVertexColor(1, 1, 1, 1)
	local buttonTexture = _G["MultiBarBottomLeftButton"..i.."NormalTexture"]:SetVertexColor(1, 1, 1, 1)
	local buttonTexture = _G["MultiBarRightButton"..i.."NormalTexture"]:SetVertexColor(1, 1, 1, 1)
	local buttonTexture = _G["MultiBarLeftButton"..i.."NormalTexture"]:SetVertexColor(1, 1, 1, 1)
	end
end)

--------- // COMBAT STATE SWORDS TARGET AND FOCUS // ----------
local t = CreateFrame("Frame", UIParent)
t.t = t:CreateTexture()
t.t:SetTexture("Interface\\CHARACTERFRAME\\UI-StateIcon.blp")
t.t:SetTexCoord(0.5,1,0,0.49);
t.t:SetAllPoints(t)
t:SetWidth(25)
t:SetHeight(25)
t:SetPoint("CENTER", TargetFrame, "CENTER", 62, -16)
t:Show()

local function FrameOnUpdate(self)
           if UnitAffectingCombat("target") then
                  self:Show()
           else
                  self:Hide()
           end
end
local g = CreateFrame("Frame")
g:SetScript("OnUpdate", function(self) FrameOnUpdate(t) end)

-- Combat State Sword FOCUS
local f = CreateFrame("Frame", UIParent)
f.t = f:CreateTexture()
f.t:SetTexture("Interface\\CHARACTERFRAME\\UI-StateIcon.blp")
f.t:SetTexCoord(0.5,1,0,0.49);
f.t:SetAllPoints(f)
f:SetWidth(25)
f:SetHeight(25)
f:SetPoint("CENTER", FocusFrame, "CENTER", 57, -13)
f:Show()

local function FrameOnUpdateFocus(self)
           if UnitAffectingCombat("focus") then
                  self:Show()
           else
                  self:Hide()
           end
end
local g = CreateFrame("Frame")
g:SetScript("OnUpdate", function(self) FrameOnUpdateFocus(f) end)

---------- // HP/MP // ----------
local function round(n, dp)
    return math.floor((n * 10^dp) + .5) / (10^dp)
end

function convert(n)
	local strLen = strlen(n)
	if strLen > 9 then
		return round(n/1e6, 1).." G"
	elseif strLen > 6 then
		return round(n/1e6, 1).." M"
	elseif strLen > 4 then
		return round(n/1e3, 0).." K"
	end
	return n
end

local specialFont = 'Interface\\AddOns\\nMainbar\\media\\font.ttf'
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function()

	
	local php, thp, fhp
	php = convert(UnitHealth("player"))
	thp = convert(UnitHealth("target"))
	fhp = convert(UnitHealth("focus"))
	
	PlayerFrameHealthBar.TextString:SetFont("Fonts\\cn_bold.TTF", 12, "OUTLINE")
	if UnitHealth("player") > 0 then
		PlayerFrameHealthBar.TextString:SetText(php)
	else
		PlayerFrameHealthBar.TextString:Hide()
	end
	PlayerFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("player")))
	
	TargetFrameHealthBar.TextString:SetFont("Fonts\\cn_bold.TTF", 12, "OUTLINE")
	if UnitHealth("target") > 0 then
		TargetFrameHealthBar.TextString:SetText(thp)
	else	
		TargetFrameHealthBar.TextString:Hide()
	end
	TargetFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("target")))
	
	FocusFrameHealthBar.TextString:SetFont("Fonts\\cn_bold.TTF", 12, "OUTLINE")
	if UnitHealth("focus") > 0 then
		FocusFrameHealthBar.TextString:SetText(fhp)
	else
		FocusFrameHealthBar.TextString:Hide()
	end
	FocusFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("focus")))

end) 

---------- // CLASS COLOR BARS EXCEPT SELF // ----------
-- local   UnitIsPlayer, UnitIsConnected, UnitClass, RAID_CLASS_COLORS =
        -- UnitIsPlayer, UnitIsConnected, UnitClass, RAID_CLASS_COLORS
-- local _, class, c

-- local function colour(statusbar, unit)
    -- if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
        -- _, class = UnitClass(unit)
        -- c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
        -- statusbar:SetStatusBarColor(c.r, c.g, c.b)
    -- end
-- end

-- hooksecurefunc("UnitFrameHealthBar_Update", colour)
-- hooksecurefunc("HealthBar_OnValueChanged", function(self)
	-- colour(self, self.unit)
-- end)

-- local sb = _G.GameTooltipStatusBar
-- local addon = CreateFrame("Frame", "StatusColour")
-- addon:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
-- addon:SetScript("OnEvent", function()
	-- colour(sb, "mouseover")
-- end)

---------- // EVENT // ----------
-- local w = CreateFrame("Frame")
-- w:RegisterEvent("PLAYER_ENTERING_WORLD")
-- function w:OnEvent(event, ...)
    -- if event == "PLAYER_ENTERING_WORLD" then
        -- SlashCmdList['RELOAD'] = function() ReloadUI() end
        -- SLASH_RELOAD1 = '/rl'
    -- end

-- end

--------- // AUTO SELL GREY // ----------
local g = CreateFrame("Frame")
g:RegisterEvent("MERCHANT_SHOW")

g:SetScript("OnEvent", function()  
        local bag, slot
        for bag = 0, 4 do
                for slot = 0, GetContainerNumSlots(bag) do
                        local link = GetContainerItemLink(bag, slot)
                        if link and (select(3, GetItemInfo(link)) == 0) then
                                UseContainerItem(bag, slot)
                        end
                end
        end

        if(CanMerchantRepair()) then
                local cost = GetRepairAllCost()
                if cost > 0 then
                        local money = GetMoney()
                        if IsInGuild() then
                                local guildMoney = GetGuildBankWithdrawMoney()
                                if guildMoney > GetGuildBankMoney() then
                                        guildMoney = GetGuildBankMoney()
                                end
                                if guildMoney > cost and CanGuildBankRepair() then
                                        RepairAllItems(1)
                                        print(format("|cfff07100Repair cost covered by G-Bank: %.1fg|r", cost * 0.0001))
                                        return
                                end
                        end
                        if money > cost then
                                RepairAllItems()
                                print(format("|cffead000Repair cost: %.1fg|r", cost * 0.0001))
                        else
                                print("Not enough gold to cover the repair cost.")
                        end
                end
        end
end)




SlashCmdList['RELOAD'] = function() ReloadUI() end
SLASH_RELOAD1 = '/rl'


 SLASH_TEST1 = "/test"
 SlashCmdList["TEST"] = function()
	for i = 1, 5 do
		local f = _G["Boss"..i.."TargetFrame"]
		
		f:Show()
		f.unit = "player"
	end

	
	for i = 1, 4 do
		local f = _G["PartyMemberFrame"..i]
		
		f:Show()
		f.unit = "player"
	end
	
	TargetFrame:Show()
	FocusFrame:Show()
	ToTFrame:Show()
	ToFFrame:Show()
	
 end
 
 
 
 
 
 
 