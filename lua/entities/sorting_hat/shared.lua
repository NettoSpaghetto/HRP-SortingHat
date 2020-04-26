ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Sorting Hat"
ENT.Author = "Netto Spaghetto"
ENT.Category = "Hogwarts RolePlay"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end

local gryffindor = "hrp/sortinghat/gryffindor.png"
local gryffindorsound = "sound/hrp/gryffindor.mp3"
local slytherin = "hrp/sortinghat/slytherin.png"
local slytherinsound = "sound/hrp/slytherin.mp3"
local ravenclaw = "hrp/sortinghat/ravenclaw.png"
local ravenclawsound = "sound/hrp/ravenclaw.mp3"
local hufflepuff = "hrp/sortinghat/hufflepuff.png"
local hufflepuffsound = "sound/hrp/hufflepuff.mp3"

sortinghat_model = "models/choixpeau/choixpeau.mdl"

sortinghat_listOfHouses = {
	{
		sound = gryffindorsound,
		imagefunction = function(width, height) 
							SortingHatGryffindor = vgui.Create("DImage", SortingHatMenu)
							SortingHatGryffindor:SetSize(width/7, height/5)
							SortingHatGryffindor:SetPos(50, 50)
							SortingHatGryffindor:SetAlpha(0)
							SortingHatGryffindor:AlphaTo(255, 1)
							SortingHatGryffindor:SetImage(gryffindor)
						end,
		movetocenter = function(width, height)
							SortingHatGryffindor:MoveTo(width/2-120, height*2/3-100, 1)
						end,
		imageid = function(width, height)
					SortingHatGryffindor:AlphaTo(0, 0.5)
					SortingHatGryffindor:AlphaTo(255, 0.5, 1)
				end

	},
	{
		sound = slytherinsound,
		imagefunction = function(width, height)
							SortingHatSlytherin = vgui.Create("DImage", SortingHatMenu)
							SortingHatSlytherin:SetSize(width/7, height/5)
							SortingHatSlytherin:SetPos(50, height-250)
							SortingHatSlytherin:SetAlpha(0)
							SortingHatSlytherin:AlphaTo(245, 1)
							SortingHatSlytherin:SetImage(slytherin)
						end,
		movetocenter = function(width, height)
							SortingHatSlytherin:MoveTo(width/2-120, height*2/3-100, 1)
						end,
		imageid = function(width, height)
					SortingHatSlytherin:AlphaTo(0, 0.5)
					SortingHatSlytherin:AlphaTo(255, 0.5, 1)
				end
	},
	{
		sound = ravenclawsound,
		imagefunction = function(width, height)
							SortingHatRavenclaw = vgui.Create("DImage", SortingHatMenu)
							SortingHatRavenclaw:SetSize(width/7, height/5)
							SortingHatRavenclaw:SetPos(width - 300, 50)
							SortingHatRavenclaw:SetAlpha(0)
							SortingHatRavenclaw:AlphaTo(245, 1)
							SortingHatRavenclaw:SetImage(ravenclaw)
						end,
		movetocenter = function(width, height)
							SortingHatRavenclaw:MoveTo(width/2-120, height*2/3-100, 1)
						end,
		imageid = function()
					SortingHatRavenclaw:AlphaTo(0, 0.5)
					SortingHatRavenclaw:AlphaTo(255, 0.5, 1)
				end
	},
	{
		sound = hufflepuffsound,
		imagefunction = function(width, height)
							SortingHatHufflepuff = vgui.Create("DImage", SortingHatMenu)
							SortingHatHufflepuff:SetSize(width/7, height/5)
							SortingHatHufflepuff:SetPos(width - 300, height-250)
							SortingHatHufflepuff:SetAlpha(0)
							SortingHatHufflepuff:AlphaTo(245, 1)
							SortingHatHufflepuff:SetImage(hufflepuff)
						end,
		movetocenter = function(width, height)
							SortingHatHufflepuff:MoveTo(width/2-120, height*2/3-100, 1)
						end,
		imageid = function(width, height)
					SortingHatHufflepuff:AlphaTo(0, 0.5)
					SortingHatHufflepuff:AlphaTo(255, 0.5, 1)
				end
	},
}

