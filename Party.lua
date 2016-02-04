
-- local partyMembers = GetNumGroupMembers()
-- if not InCombatLockdown() and partyMembers > 0 and partyMembers < 6 then
	-- for i = 1, partyMembers - 1 do
		-- _G["PartyMemberFrame"..i.."HealthBar"]:ClearAllPoints()
		-- _G["PartyMemberFrame"..i.."HealthBar"]:SetPoint("TOPLEFT", 45, -15)
		-- _G["PartyMemberFrame"..i.."HealthBar"]:SetHeight(10)
		-- _G["PartyMemberFrame"..i.."ManaBar"]:ClearAllPoints()
		-- _G["PartyMemberFrame"..i.."ManaBar"]:SetPoint("TOPLEFT", 45, -25)
		-- _G["PartyMemberFrame"..i.."ManaBar"]:SetHeight(3)
		-- color = RAID_CLASS_COLORS[select(2, UnitClass("party"..i))]
		-- if color then
			-- _G["PartyMemberFrame"..i.."HealthBar"]:SetStatusBarColor(color.r, color.g, color.b)
			-- _G["PartyMemberFrame"..i.."HealthBar"].lockColor = true
		-- end
		-- _G["PartyMemberFrame"..i.."HealthBarText"]:ClearAllPoints()
		-- _G["PartyMemberFrame"..i.."HealthBarText"]:Hide()
		-- _G["PartyMemberFrame"..i.."ManaBarText"]:ClearAllPoints()
		-- _G["PartyMemberFrame"..i.."ManaBarText"]:Hide()
	-- end
-- end

for id = 1, 4, 1 do
	local PartyLevel = CreateFrame("Frame", "PartyLevel"..id,  _G["PartyMemberFrame"..id]);
	PartyLevel.Text = _G["PartyLevel"..id]:CreateFontString("PartyMemberFrame"..id.."Level", "OVERLAY", "GameTooltipText");
	PartyLevel.Text:ClearAllPoints();
	PartyLevel.Text:SetPoint("TOPLEFT", _G["PartyMemberFrame"..id], "BOTTOMLEFT", -12, 12);
	PartyLevel.Text:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
	PartyLevel.Text:SetTextColor(1, 0.82, 0);
	PartyLevel.Text:SetJustifyH("LEFT");
end

for id = 1, 4, 1 do
	_G["PartyLevel"..id]:RegisterEvent("PLAYER_ENTERING_WORLD");
	_G["PartyLevel"..id]:RegisterEvent("GROUP_ROSTER_UPDATE");
	_G["PartyLevel"..id]:RegisterEvent("PARTY_LEADER_CHANGED");
	_G["PartyLevel"..id]:RegisterEvent("PARTY_MEMBER_ENABLE");
	_G["PartyLevel"..id]:RegisterUnitEvent("UNIT_CONNECTION", "party"..id);
	_G["PartyLevel"..id]:RegisterUnitEvent("UNIT_PHASE", "party"..id);
	_G["PartyLevel"..id]:RegisterUnitEvent("UNIT_LEVEL", "party"..id);
	_G["PartyLevel"..id]:SetScript("OnEvent", function(self, event, ...)
		local LevelText = "";
		if UnitExists("party"..id) then
				if UnitLevel(_G["PartyMemberFrame"..id].unit) and UnitLevel(_G["PartyMemberFrame"..id].unit) >= 1 then
					LevelText = UnitLevel(_G["PartyMemberFrame"..id].unit);
				end
		end
		_G["PartyLevel"..id].Text:SetText(LevelText);
	end)
end

for id = 1, 4, 1 do
	_G["PartyMemberFrame"..id.."HealthBar"]:SetScript("OnValueChanged", nil);
	_G["PartyMemberFrame"..id.."HealthBar"]:RegisterEvent("PLAYER_ENTERING_WORLD");
	_G["PartyMemberFrame"..id.."HealthBar"]:RegisterEvent("GROUP_ROSTER_UPDATE");
	_G["PartyMemberFrame"..id.."HealthBar"]:RegisterEvent("PARTY_LEADER_CHANGED");
	_G["PartyMemberFrame"..id.."HealthBar"]:RegisterEvent("PARTY_MEMBER_ENABLE");
	_G["PartyMemberFrame"..id.."HealthBar"]:RegisterUnitEvent("UNIT_CONNECTION", "party"..id);
	_G["PartyMemberFrame"..id.."HealthBar"]:RegisterUnitEvent("UNIT_PHASE", "party"..id);
	_G["PartyMemberFrame"..id.."HealthBar"]:SetScript("OnEvent", function(self, event, ...)
		if UnitExists("party"..id) then
			local color = {r=0, g=1, b=0};
			color = RAID_CLASS_COLORS[select(2, UnitClass("party"..id))];
			if not color then color = {r=0, g=1, b=0} end
			_G["PartyMemberFrame"..id.."HealthBar"]:SetStatusBarColor(color.r, color.g, color.b);
		end
	end)
	_G["PartyMemberFrame"..id.."HealthBar"]:ClearAllPoints()
	_G["PartyMemberFrame"..id.."HealthBar"]:SetPoint("TOPLEFT", 45, -15)
	_G["PartyMemberFrame"..id.."HealthBar"]:SetHeight(10)
	_G["PartyMemberFrame"..id.."ManaBar"]:ClearAllPoints()
	_G["PartyMemberFrame"..id.."ManaBar"]:SetPoint("TOPLEFT", 45, -25)
	_G["PartyMemberFrame"..id.."ManaBar"]:SetHeight(3)
	_G["PartyMemberFrame"..id.."HealthBarText"]:ClearAllPoints()
	_G["PartyMemberFrame"..id.."HealthBarText"]:Hide()
	_G["PartyMemberFrame"..id.."ManaBarText"]:ClearAllPoints()
	_G["PartyMemberFrame"..id.."ManaBarText"]:Hide()

	_G["PartyMemberFrame"..id.."HealthBar"].lockColor = true;
end

for id = 1, 4, 1 do
	local PartyColorName = CreateFrame("Frame", "PartyColorName"..id,  _G["PartyMemberFrame"..id]);
end

for id = 1, 4, 1 do
	_G["PartyColorName"..id]:RegisterEvent("PLAYER_ENTERING_WORLD");
	_G["PartyColorName"..id]:RegisterEvent("GROUP_ROSTER_UPDATE");
	_G["PartyColorName"..id]:RegisterEvent("PARTY_LEADER_CHANGED");
	_G["PartyColorName"..id]:RegisterEvent("PARTY_MEMBER_ENABLE");
	_G["PartyColorName"..id]:RegisterUnitEvent("UNIT_CONNECTION", "party"..id);
	_G["PartyColorName"..id]:RegisterUnitEvent("UNIT_PHASE", "party"..id);
	_G["PartyColorName"..id]:SetScript("OnEvent", function(self, event, ...)
		if UnitExists("party"..id) then
			local color = NORMAL_FONT_COLOR;
			color = RAID_CLASS_COLORS[select(2, UnitClass(_G["PartyMemberFrame"..id].unit))];
			if not color then color = NORMAL_FONT_COLOR end
			_G["PartyMemberFrame"..id].name:SetTextColor(color.r, color.g, color.b);
		end
	end)
end

for id = 1, 4, 1 do
	--队友死亡、灵魂提示
	local PartyDeath = CreateFrame("Frame", "PartyDeath"..id,  _G["PartyMemberFrame"..id]);
	PartyDeath:SetFrameLevel(7);
	PartyDeath.Text = PartyDeath:CreateFontString("PartyMemberFrame"..id.."DeathText", "OVERLAY", "GameTooltipText");
	PartyDeath.Text:ClearAllPoints();
	PartyDeath.Text:SetPoint("CENTER", _G["PartyMemberFrame"..id.."HealthBar"], "CENTER", 0, -5);
	PartyDeath.Text:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
	PartyDeath.Text:SetTextColor(1, 1, 1);
	PartyDeath.Text:SetJustifyH("CENTER");
end

--队友离线检测
for id = 1, 4, 1 do
	local PartyOfflineStatus = _G["PartyMemberFrame"..id]:CreateTexture("PartyOfflineStatus"..id, "OVERLAY", _G["PartyMemberFrame"..id]);
	_G["PartyOfflineStatus"..id]:SetTexture("Interface\\CharacterFrame\\Disconnect-Icon");
	_G["PartyOfflineStatus"..id]:SetWidth(64);
	_G["PartyOfflineStatus"..id]:SetHeight(64);
	_G["PartyOfflineStatus"..id]:ClearAllPoints();
	_G["PartyOfflineStatus"..id]:SetPoint("LEFT", _G["PartyMemberFrame"..id], "LEFT", -7, -1);
	_G["PartyOfflineStatus"..id]:SetAlpha(0);
end

--队友头像内战斗信息
for id = 1, 4, 1 do
	local PartyPortraitIndicator = CreateFrame("Frame", "PartyPortraitIndicator"..id, _G["PartyMemberFrame"..id]);
	_G["PartyPortraitIndicator"..id]:SetFrameStrata("MEDIUM");
	_G["PartyPortraitIndicator"..id].feedbackStartTime = GetTime();
	_G["PartyPortraitIndicator"..id]:CreateFontString("PartyHitIndicator"..id, "OVERLAY", "NumberFontNormalHuge");
	_G["PartyHitIndicator"..id]:ClearAllPoints();
	_G["PartyHitIndicator"..id]:SetPoint("CENTER", _G["PartyMemberFrame"..id.."Portrait"], "CENTER", 0, 0);
	CombatFeedback_Initialize(_G["PartyPortraitIndicator"..id], _G["PartyHitIndicator"..id], 20);
end

for id = 1, 4, 1 do
	_G["PartyPortraitIndicator"..id]:RegisterEvent("PLAYER_ENTERING_WORLD");
	_G["PartyPortraitIndicator"..id]:RegisterEvent("GROUP_ROSTER_UPDATE");
	_G["PartyPortraitIndicator"..id]:RegisterEvent("PARTY_LEADER_CHANGED");
	_G["PartyPortraitIndicator"..id]:RegisterUnitEvent("UNIT_COMBAT", "party"..id);
	_G["PartyPortraitIndicator"..id]:RegisterUnitEvent("UNIT_CONNECTION", "party"..id);
	_G["PartyPortraitIndicator"..id]:SetScript("OnEvent", function(self, event, ...)
		if GetCVar("useCompactPartyFrames") ~= 1 then
			local arg1, arg2, arg3, arg4, arg5 = ...;
			if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" or event == "PARTY_LEADER_CHANGED" or (event == "UNIT_CONNECTION" and arg2 == false) then
				_G["PartyHitIndicator"..id]:Hide();
			elseif event == "UNIT_COMBAT" then
				CombatFeedback_OnCombatEvent(self, arg2, arg3, arg4, arg5);
			end
		end
	end)

	_G["PartyPortraitIndicator"..id]:SetScript("OnUpdate", function(self, elapsed)
		if GetCVar("useCompactPartyFrames") ~= 1 then
			CombatFeedback_OnUpdate(self, elapsed);
		end
	end)
end