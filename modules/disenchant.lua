local _, addon = ...

-- Confirmed exclusions: https://db.icy-veins.com/wow-forever/items/<itemID>
local cannotDisenchant = {
	[9149] = "Philosopher's Stone",
	[11287] = "Lesser Magic Wand",
	[11288] = "Greater Magic Wand",
	[11289] = "Lesser Mystic Wand",
	[18849] = "Insignia of the Horde",
	[18857] = "Insignia of the Alliance",
	[21119] = "Talisman of Arathor",
	[21120] = "Defiler's Talisman",
	[21566] = "Rune of Perfection",
	[247789] = "Novice's Practice Wand",
	[249385] = "Brilliant Wand",
	[260806] = "Emergency Field Cloak",
	[280766] = "Satchel of Potions",
}

---@param button table
---@param info ContainerItemInfo?
function addon.UpdateDisenchant(button, info)
	local overlay = button.ButlerDisenchant
	local bag = button:GetBagID()
	if
		InCombatLockdown()
		or not IsAltKeyDown()
		or IsShiftKeyDown()
		or IsControlKeyDown()
		or not C_SpellBook.IsSpellKnown(13262)
		or CursorHasItem()
		or SpellIsTargeting()
		or bag < 0
		or bag > NUM_BAG_SLOTS
		or not info
		or info.isLocked
		or cannotDisenchant[info.itemID]
		or not info.quality
		or info.quality < Enum.ItemQuality.Uncommon
		or info.quality > Enum.ItemQuality.Epic
	then
		if overlay then
			overlay:Hide()
		end

		return
	end

	local _, _, _, _, _, classID = C_Item.GetItemInfoInstant(info.itemID)
	if classID ~= Enum.ItemClass.Weapon and classID ~= Enum.ItemClass.Armor then
		if overlay then
			overlay:Hide()
		end

		return
	end

	if not overlay then
		-- This template casts only out of combat and leaves bag frames unprotected.
		overlay = CreateFrame("Button", nil, button, "InsecureActionButtonTemplate")
		overlay:SetAllPoints(button)
		overlay:RegisterForClicks("LeftButtonUp")
		overlay:SetPassThroughButtons("RightButton")
		overlay:SetAttribute("useOnKeyDown", false)
		overlay:SetAttribute("alt-type1", "spell")
		overlay:SetAttribute("alt-spell1", 13262)

		local glow = overlay:CreateTexture(nil, "OVERLAY")
		glow:SetAtlas("gearenchant_iconborder")
		glow:SetPoint("TOPLEFT", -5, 5)
		glow:SetPoint("BOTTOMRIGHT", 5, -5)
		glow:SetBlendMode("ADD")
		glow:SetVertexColor(0.7, 0.3, 1)

		overlay:SetScript("OnEnter", function()
			button:OnEnter()
		end)
		overlay:SetScript("OnLeave", function()
			button:OnLeave()
		end)
		button.ButlerDisenchant = overlay
	end

	overlay:SetAttribute("alt-target-bag1", bag)
	overlay:SetAttribute("alt-target-slot1", button:GetID())
	overlay:Show()
end

local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function()
	for _, container in ContainerFrameUtil_EnumerateContainerFrames() do
		if container:IsShown() then
			for _, button in container:EnumerateValidItems() do
				local info = C_Container.GetContainerItemInfo(button:GetBagID(), button:GetID())
				addon.UpdateDisenchant(button, info)
			end
		end
	end
end)

frame:RegisterEvent("MODIFIER_STATE_CHANGED")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("CURSOR_CHANGED")
frame:RegisterEvent("ITEM_LOCK_CHANGED")
