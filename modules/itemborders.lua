local _, addon = ...

---@param button table
---@param quality number?
function addon.UpdateItemBorder(button, quality)
	if button.ButlerQuality then
		button.ButlerQuality:Hide()
	end

	if
		not quality
		or quality < Enum.ItemQuality.Uncommon
		or quality > Enum.ItemQuality.Epic
		or (button.IconQuestTexture and button.IconQuestTexture:IsShown())
	then
		return
	end

	if not button.ButlerQuality then
		local border = button:CreateTexture(nil, "OVERLAY", nil, 1)
		border:SetAllPoints(button.IconBorder)
		border:SetTexture("Interface/Common/WhiteIconFrame")
		border:SetBlendMode("ADD")
		button.ButlerQuality = border
	end

	local r, g, b = C_Item.GetItemQualityColor(quality)
	button.ButlerQuality:SetVertexColor(r, g, b)
	button.ButlerQuality:Show()
end

hooksecurefunc("PaperDollItemSlotButton_Update", function(button)
	addon.UpdateItemBorder(button, GetInventoryItemQuality("player", button:GetID()))
end)
