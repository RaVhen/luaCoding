
local frame = {
	["Boss1TargetFrame"] = {
		position = {"CENTER",UIParent,"CENTER", 800, 125};
		scale = 0.75},
};
	

local function hide_flash()

	for id = 1, 5 do
		_G["Boss"..id.."TargetFrameFlash"]:Hide()
	end
end	
	
local function init_boss()

	for id = 1,5 do
		_G["Boss"..id.."TargetFrame"].nameBackground:Hide()
		_G["Boss"..id.."TargetFrameBackground"]:Hide()
		_G["Boss"..id.."TargetFrameHealthBar"].background = _G["Boss"..id.."TargetFrameHealthBar"]:CreateTexture("Boss"..id.."TargetFrameHealthBarBackground", "BACKGROUND")
		_G["Boss"..id.."TargetFrameHealthBar"].background:SetTexture(0, 0, 0, 0.5)
		 _G["Boss"..id.."TargetFrameHealthBar"].background:SetAllPoints()

		 _G["Boss"..id.."TargetFrameManaBar"].background = _G["Boss"..id.."TargetFrameManaBar"]:CreateTexture("Boss"..id.."TargetFrameHealthBarBackground", "BACKGROUND")
		 _G["Boss"..id.."TargetFrameManaBar"].background:SetTexture(0, 0, 0, 0.5)
		 _G["Boss"..id.."TargetFrameManaBar"].background:SetAllPoints()

		 --_G["Boss"..id.."TargetFrameHealthBar"]:ClearAllPoints()
		 _G["Boss"..id.."TargetFrameHealthBar"]:SetPoint("TOPLEFT", 5, -24)
		 _G["Boss"..id.."TargetFrameHealthBar"].SetPoint = function() end
		 _G["Boss"..id.."TargetFrameHealthBar"]:SetHeight(27)
		 --_G["Boss"..id.."TargetFrame"].deadText:ClearAllPoints()
		 _G["Boss"..id.."TargetFrame"].deadText:SetPoint("CENTER", _G["Boss"..id.."TargetFrameHealthBar"], "CENTER", 0, 0)

		--_G["Boss"..id.."TargetFrameHealthBar"].TextString:ClearAllPoints();
		 _G["Boss"..id.."TargetFrameHealthBar"].TextString:SetPoint("CENTER", _G["Boss"..id.."TargetFrameHealthBar"], "CENTER", 0, 0);
		 _G["Boss"..id.."TargetFrameTextureFrameName"]:SetVertexColor(1, 1, 1)
		-- _G["Boss"..id.."TargetFrameTextureFrameName"]:ClearAllPoints()
		 _G["Boss"..id.."TargetFrameTextureFrameName"]:SetFont("Fonts\\cn_bold.TTF", 12, "OUTLINE")
		 _G["Boss"..id.."TargetFrameTextureFrameName"]:SetPoint("CENTER", _G["Boss"..id.."TargetFrameHealthBar"], "CENTER", 0, 20)
		 
		_G["Boss"..id.."TargetFrameHealthBar"]:SetStatusBarColor(0.7, 0, 0)
	 end
	 
end

	
local chb = CreateFrame("Frame")
chb:RegisterEvent("PLAYER_ENTERING_WORLD")
chb:RegisterEvent("PLAYER_REGEN_DISABLED")
chb:RegisterEvent("PLAYER_REGEN_ENABLED")
chb:RegisterEvent("UNIT_COMBAT")
chb:RegisterEvent("UNIT_FACTION")	
chb:SetScript("OnEvent", function(self, event, ...)
	init_boss()
end)
chb:SetScript("OnUpdate", function(self, event, ...)
	hide_flash()
end)


