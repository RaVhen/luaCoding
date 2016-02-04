

    if tonumber(GetCVar'modTooltip') == 0 then return end

    local sb = [[Interface\AddOns\modui\statusbar\texture\sb.tga]]
    local GameTooltip = GameTooltip
    local GameTooltipStatusBar = GameTooltipStatusBar
    local orig = {}

    local statustext = function()
        TextStatusBar_UpdateTextString()
        ShowTextStatusBarText(this)
		if this:GetParent() == TargetFrame then
            GameTooltip_SetDefaultAnchor(GameTooltip, this)
            if GameTooltip:SetUnit(TargetFrame.unit) then
                TargetFrame.updateTooltip = TOOLTIP_UPDATE_TIME
            else
                TargetFrame.updateTooltip = nil
            end
            TargetFrame.r, TargetFrame.g, TargetFrame.b = GameTooltip_UnitColor(TargetFrame.unit)
            GameTooltipTextLeft1:SetTextColor(TargetFrame.r, TargetFrame.g, TargetFrame.b)
            GameTooltip:AddLine' '
        end
        GameTooltip:Show()
    end

    orig.UnitFrame_OnEnter = UnitFrame_OnEnter
    orig.GameTooltip_SetDefaultAnchor = GameTooltip_SetDefaultAnchor

    GameTooltipStatusBar:SetHeight(5)
    GameTooltipStatusBar:SetStatusBarTexture(sb)
    GameTooltipStatusBar:SetBackdrop({  bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
                                        insets = {left = -1, right = -1, top = -1, bottom = -1} })
    GameTooltipStatusBar:SetBackdropColor(0, 0, 0, 1)
    GameTooltipStatusBar:ClearAllPoints()
    GameTooltipStatusBar:SetPoint('LEFT', GameTooltipStatusBar:GetParent(), 10, 0)
    GameTooltipStatusBar:SetPoint('RIGHT', GameTooltipStatusBar:GetParent(), -10, 0)
    GameTooltipStatusBar:SetPoint('TOP', GameTooltipStatusBar:GetParent(), 'BOTTOM', 0, 17)
    GameTooltipStatusBar:SetFrameLevel(GameTooltipStatusBar:GetFrameLevel() + 2)

    GameTooltipHeaderText:SetFont(STANDARD_TEXT_FONT, 13)
    GameTooltipHeaderText:SetShadowOffset(.7, -.7)
    GameTooltipHeaderText:SetShadowColor(0, 0, 0, 1)

    GameTooltipText:SetFont(STANDARD_TEXT_FONT, 12)
    GameTooltipText:SetShadowOffset(.7, -.7)
    GameTooltipText:SetShadowColor(0, 0, 0,1)


    local tooltips = {  GameTooltip,
                        ItemRefTooltip,
                        ItemRefShoppingTooltip1,
                     	ItemRefShoppingTooltip2,
                        ItemRefShoppingTooltip3,
                        ShoppingTooltip1,
                        ShoppingTooltip2,
                        ShoppingTooltip3,
                        WorldMapTooltip,
                        WorldMapCompareTooltip1,
                        WorldMapCompareTooltip2,
                        WorldMapCompareTooltip3,
                        FriendsTooltip,
                        QuestTip, }

    local menus =    {  DropDownList1MenuBackdrop,
                        DropDownList2MenuBackdrop,
                        DropDownList3MenuBackdrop,
                        ChatMenu,
                        EmoteMenu,
                        LanguageMenu, }


    for i, v in ipairs(menus) do v:SetScript('OnShow', function()
            this:SetBackdropColor(0, 0, 0)
            this:SetBackdropBorderColor(.1, .1, .1)
        end)
    end


    for i = 1, 6 do                 -- QUEST PROGRESS TOOLTIP
        local p = _G['QuestProgressItem'..i]
        p:SetScript('OnEnter', function()
            if GameTooltip then
                GameTooltip:SetOwner(p, 'ANCHOR_RIGHT')
                if GetNumQuestItems() > 0 then GameTooltip:SetQuestItem(p.type, p:GetID()) end
            end
        end)
    end


    local f = CreateFrame'Frame'    -- GUILD TAG
    f:RegisterEvent'UPDATE_MOUSEOVER_UNIT'
    f:SetScript('OnEvent', function()
        local g = GetGuildInfo'mouseover'
        local n = GameTooltipTextLeft2:GetText()
        local c = UnitClassification'mouseover'
        if g then GameTooltip:AddLine('<'..g..'>', 0, 1, .5) end
        if n and string.find(n, 'Level (.+)') and c ~= 'normal' and c ~= 'minus' then
            local t = gsub(n, 'Level (.+) ((.+))', '%1')
            local classification = c == 'elite' and '(Elite)' or c == 'rare' and '(Rare)' or c == 'rareelite' and '(Rare Elite)' or '(Boss)'
            GameTooltipTextLeft2:SetText('Level '..t..' '..classification)
        end
        if GameTooltipStatusBar:IsShown() and GameTooltipStatusBar:GetValue() > 0
        and (not string.find(GameTooltip:GetParent():GetName(), 'PlayerFrame')
         or  not string.find(GameTooltip:GetParent():GetName(), 'TargetFrame')
         or  not string.find(GameTooltip:GetParent():GetName(), 'PartyFrame')
         or  not string.find(GameTooltip:GetParent():GetName(), 'RaidFrame')) then
            GameTooltip:AddLine' '
        else
            GameTooltipStatusBar:Hide()
        end
        GameTooltip:Show()
    end)

    function UnitFrame_OnEnter()
        orig.UnitFrame_OnEnter()
        GameTooltipStatusBar:Hide()
    end

    for _, v in pairs({TargetFrameHealthBar, TargetFrameManaBar}) do v:SetScript('OnEnter', statustext) end

    local r = CreateFrame'Frame'
    r:RegisterEvent'ADDON_LOADED'
    r:SetScript('OnEvent', function()
        if arg1 == 'Blizzard_RaidUI' then
            orig.RaidGroupButton_OnEnter = RaidGroupButton_OnEnter
            function RaidGroupButton_OnEnter()
                orig.RaidGroupButton_OnEnter()
                GameTooltipStatusBar:Hide()
            end
            r:UnregisterAllEvents()
        end
    end)

    --
