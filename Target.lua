local AURA_START_X = 5;
local AURA_START_Y = 30;
local AURA_OFFSET_Y = 3
local AURA_ROW_WIDTH = 220
local NUM_TOT_AURA_ROWS = 3

TargetFrame.nameBackground:Hide()
TargetFrameBackground:Hide()
TargetFrameHealthBar.background = TargetFrameHealthBar:CreateTexture("TargetFrameHealthBarBackground", "BACKGROUND")
TargetFrameHealthBar.background:SetTexture(0, 0, 0, 0.5)
TargetFrameHealthBar.background:SetAllPoints()

TargetFrameManaBar.background = TargetFrameManaBar:CreateTexture("TargetFrameHealthBarBackground", "BACKGROUND")
TargetFrameManaBar.background:SetTexture(0, 0, 0, 0.5)
TargetFrameManaBar.background:SetAllPoints()

TargetFrameHealthBar:ClearAllPoints()
TargetFrameHealthBar:SetPoint("TOPLEFT", 5, -24)
TargetFrameHealthBar.SetPoint = function() end
TargetFrameHealthBar:SetHeight(27)
TargetFrame.deadText:ClearAllPoints()
TargetFrame.deadText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)

TargetFrameHealthBar.TextString:ClearAllPoints();
TargetFrameHealthBar.TextString:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0);
TargetFrameTextureFrameName:SetVertexColor(1, 1, 1)
TargetFrameTextureFrameName:ClearAllPoints()
TargetFrameTextureFrameName:SetFont("Fonts\\cn_bold.TTF", 12, "OUTLINE")
TargetFrameTextureFrameName:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 20)


---------- // TARGET COLOR BAR // ----------
local function targetChanged()
    TargetFrame.nameBackground:Hide()
	TargetFrameBackground:Hide()
	if UnitExists("target") then
		local HealthBarColor = {r=0, g=1, b=0}
		local color = {r=1, g=0, b=0}
		if UnitIsPlayer("target") then
			HealthBarColor = RAID_CLASS_COLORS[select(2, UnitClass("target"))] or {r=0, g=1, b=0};
		else	
			HealthBarColor = FACTION_BAR_COLORS[UnitReaction("target", "player")]
		end
		if UnitIsEnemy("target","player") and UnitIsPlayer("target") then
			color = {r=1, g=0, b=0};
		else
			color = HealthBarColor
		end
		if ( not UnitPlayerControlled("target") and UnitIsTapped("target") and not UnitIsTappedByPlayer("target") and not UnitIsTappedByAllThreatList("target") ) then
			TargetFrameHealthBar:SetStatusBarColor(0.5, 0.5, 0.5)
		else
			TargetFrameHealthBar:SetStatusBarColor(HealthBarColor.r, HealthBarColor.g, HealthBarColor.b);
		end
		TargetFrameTextureFrameName:SetVertexColor(color.r, color.g, color.b)
	end
end

local chb = CreateFrame("Frame")
TargetFrameHealthBar:SetScript("OnValueChanged", nil)
chb:RegisterEvent("PLAYER_TARGET_CHANGED")
chb:SetScript("OnEvent", targetChanged)
TargetFrameHealthBar.lockColor = true


hooksecurefunc("TargetFrame_CheckFaction", targetChanged)
hooksecurefunc("TargetFrame_CheckClassification", targetChanged)

---------- // TARGET & FOCUS BUFF/DEBUFF// ----------
hooksecurefunc("TargetFrame_UpdateAuraPositions", function(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
	local UFP_AURA_OFFSET_Y = 3;
	local UFP_LARGE_AURA_SIZE, UFP_SMALL_AURA_SIZE;
	UFP_LARGE_AURA_SIZE = 23;
	UFP_SMALL_AURA_SIZE = 21;
	local UFP_AURA_ROW_WIDTH = 122;
	local UFP_NUM_TOT_AURA_ROWS = 2;

	local UFP_SIZE;
	local UFP_OFFSETY = UFP_AURA_OFFSET_Y;
	local UFP_ROWWIDTH = 0;
	local UFP_FIRSTBUFFONROW = 1;
	
	for i=1, numAuras, 1 do
		if ( largeAuraList[i] ) then
			UFP_SIZE = UFP_LARGE_AURA_SIZE;
			UFP_OFFSETY = UFP_AURA_OFFSET_Y + UFP_AURA_OFFSET_Y;
		else
			UFP_SIZE = UFP_SMALL_AURA_SIZE;
		end
		if ( i == 1 ) then
			UFP_ROWWIDTH = UFP_SIZE;
			self.auraRows = self.auraRows + 1;
		else
			UFP_ROWWIDTH = UFP_ROWWIDTH + UFP_SIZE + offsetX;
		end
		if ( UFP_ROWWIDTH > maxRowWidth + 66) then
			updateFunc(self, auraName, i, numOppositeAuras, UFP_FIRSTBUFFONROW, UFP_SIZE, offsetX, UFP_OFFSETY, mirrorAurasVertically);
			UFP_ROWWIDTH = UFP_SIZE;
			self.auraRows = self.auraRows + 1;
			UFP_FIRSTBUFFONROW = i;
			UFP_OFFSETY = UFP_AURA_OFFSET_Y;
			if ( self.auraRows > UFP_NUM_TOT_AURA_ROWS ) or ( self.auraRows > 2 ) then
				maxRowWidth = UFP_AURA_ROW_WIDTH;
			end
		else
			updateFunc(self, auraName, i, numOppositeAuras, i - 1, UFP_SIZE, offsetX, UFP_OFFSETY, mirrorAurasVertically);
		end
	end
end)


hooksecurefunc("TargetFrame_UpdateBuffAnchor", function(self, buffName, index, numDebuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
    -- local point, relativePoint
    -- local startY, auraOffsetY
    -- if ( mirrorVertically ) then
        -- point = "BOTTOM"
        -- relativePoint = "TOP"
        -- startY = -8
        -- offsetY = -offsetY 
        -- auraOffsetY = -AURA_OFFSET_Y
    -- else
        -- point = "TOP"
        -- relativePoint="BOTTOM"
        -- startY = AURA_START_Y
        -- auraOffsetY = AURA_OFFSET_Y
    -- end
	
    
	-- local buff = _G[buffName..index]
	-- if self.unit ~= "focus" then
		-- if ( index == 1 ) then
			-- if ( UnitIsFriend("player", self.unit) or numDebuffs == 0 ) then
				-- -- unit is friendly or there are no debuffs...buffs start on top
				-- -- change startY value with castbar
				-- buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY)  
         
			-- else
				-- -- unit is not friendly and we have debuffs...buffs start on bottom
				-- buff:SetPoint(point.."LEFT", self.debuffs, relativePoint.."LEFT", 0, -offsetY )
			-- end
			-- self.buffs:SetPoint(point.."LEFT", buff, point.."LEFT", 0, -50)
			-- self.buffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY )
			-- self.spellbarAnchor = buff
		-- elseif ( anchorIndex ~= (index-1) ) then
			-- -- anchor index is not the previous index...must be a new row
			-- buff:SetPoint(point.."LEFT", _G[buffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY)
			-- self.buffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY)
			-- self.spellbarAnchor = buff
		-- else
			-- -- anchor index is the previous index
			-- buff:SetPoint(point.."LEFT", _G[buffName..anchorIndex], point.."RIGHT", offsetX, 0)
		-- end
	-- else
		-- buff:Hide()
	-- end
    -- buff:SetWidth(size)
    -- buff:SetHeight(size)
	
	
	local point, relativePoint
    local startY, auraOffsetY
    if ( mirrorVertically ) then
        point = "BOTTOM"
        relativePoint = "TOP"
        startY = -8
        offsetY = -offsetY
        auraOffsetY = -AURA_OFFSET_Y
    else
        point = "TOP"
        relativePoint="BOTTOM"
        startY = AURA_START_Y
        auraOffsetY = AURA_OFFSET_Y
    end
     
    local buff = _G[buffName..index]
	if self.unit ~= "focus" then
    if ( index == 1 ) then
        if ( UnitIsFriend("player", self.unit) or numDebuffs == 0 ) then
            -- unit is friendly or there are no debuffs...buffs start on top
            buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY)           
        else
            -- unit is not friendly and we have debuffs...buffs start on bottom
            buff:SetPoint(point.."LEFT", self.debuffs, relativePoint.."LEFT", 0, -offsetY)
        end
        self.buffs:SetPoint(point.."LEFT", buff, point.."LEFT", 0, 0)
        self.buffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY)
        self.spellbarAnchor = buff
    elseif ( anchorIndex ~= (index-1) ) then
        -- anchor index is not the previous index...must be a new row
        buff:SetPoint(point.."LEFT", _G[buffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY)
        self.buffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY)
        self.spellbarAnchor = buff
    else
        -- anchor index is the previous index
        buff:SetPoint(point.."LEFT", _G[buffName..anchorIndex], point.."RIGHT", offsetX, 0)
    end
	else
		buff:Hide()
	end
    buff:SetWidth(size)
    buff:SetHeight(size)
end)


hooksecurefunc("TargetFrame_UpdateDebuffAnchor", function(self, debuffName, index, numBuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
    -- local buff = _G[debuffName..index];
    -- local isFriend = UnitIsFriend("player", self.unit);
     
    -- --For mirroring vertically
    -- local point, relativePoint;
    -- local startY, auraOffsetY;
    -- if ( mirrorVertically ) then
        -- point = "BOTTOM";
        -- relativePoint = "TOP";
        -- startY = -8;
        -- offsetY = - offsetY;
        -- auraOffsetY = -AURA_OFFSET_Y;
    -- else
        -- point = "TOP";
        -- relativePoint="BOTTOM";
        -- startY = AURA_START_Y;
        -- auraOffsetY = AURA_OFFSET_Y;
    -- end
     
	 -- print(index)
    -- if ( index == 1 ) then
	-- print(offsetY)
	-- print(startY)
        -- if ( isFriend and numBuffs > 0 and self.unit ~= "focus") then
            -- -- unit is friendly and there are buffs...debuffs start on bottom
            -- buff:SetPoint(point.."LEFT", self.buffs, relativePoint.."LEFT", 0, -offsetY );
        -- else
            -- -- unit is not friendly or there are no buffs...debuffs start on top
            -- buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY);
        -- end
        -- self.debuffs:SetPoint(point.."LEFT", buff, point.."LEFT", 0, 0);
        -- self.debuffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
        -- if ( ( isFriend ) or ( not isFriend and numBuffs == 0) ) then
            -- self.spellbarAnchor = buff;
        -- end
    -- elseif ( anchorIndex ~= (index-1) ) then
        -- -- anchor index is not the previous index...must be a new row
        -- buff:SetPoint(point.."LEFT", _G[debuffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY);
        -- self.debuffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
        -- if ( ( isFriend ) or ( not isFriend and numBuffs == 0) ) then
            -- self.spellbarAnchor = buff;
        -- end
    -- else
        -- -- anchor index is the previous index
        -- buff:SetPoint(point.."LEFT", _G[debuffName..(index-1)], point.."RIGHT", offsetX, 0);
    -- end
 
    -- -- Resize
    -- buff:SetWidth(size);
    -- buff:SetHeight(size);
    -- local debuffFrame =_G[debuffName..index.."Border"];
    -- debuffFrame:SetWidth(size+2);
    -- debuffFrame:SetHeight(size+2);
	
	
	 local buff = _G[debuffName..index];
    local isFriend = UnitIsFriend("player", self.unit);
     
    --For mirroring vertically
    local point, relativePoint;
    local startY, auraOffsetY;
    if ( mirrorVertically ) then
        point = "BOTTOM";
        relativePoint = "TOP";
        startY = -8;
        offsetY = - offsetY;
        auraOffsetY = -AURA_OFFSET_Y;
    else
        point = "TOP";
        relativePoint="BOTTOM";
        startY = AURA_START_Y;
        auraOffsetY = AURA_OFFSET_Y;
    end
     
    if ( index == 1 ) then
        if ( isFriend and numBuffs > 0 ) then
            -- unit is friendly and there are buffs...debuffs start on bottom
            buff:SetPoint(point.."LEFT", self.buffs, relativePoint.."LEFT", 0, -offsetY);
        else
            -- unit is not friendly or there are no buffs...debuffs start on top
            buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY);
        end
        self.debuffs:SetPoint(point.."LEFT", buff, point.."LEFT", 0, 0);
        self.debuffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
        if ( ( isFriend ) or ( not isFriend and numBuffs == 0) ) then
            self.spellbarAnchor = buff;
        end
    elseif ( anchorIndex ~= (index-1) ) then
        -- anchor index is not the previous index...must be a new row
        buff:SetPoint(point.."LEFT", _G[debuffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY);
        self.debuffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
        if ( ( isFriend ) or ( not isFriend and numBuffs == 0) ) then
            self.spellbarAnchor = buff;
        end
    else
        -- anchor index is the previous index
        buff:SetPoint(point.."LEFT", _G[debuffName..(index-1)], point.."RIGHT", offsetX, 0);
    end
 
    -- Resize
    buff:SetWidth(size);
    buff:SetHeight(size);
    local debuffFrame =_G[debuffName..index.."Border"];
    debuffFrame:SetWidth(size+2);
    debuffFrame:SetHeight(size+2);
end)