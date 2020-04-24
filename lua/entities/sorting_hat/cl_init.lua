include("shared.lua")

local Houses = {
	[1] = "Gryffindor",
	[2] = "Slytherin",
	[3] = "Ravenclaw",
	[4] = "Hufflepuff"
}

local config = 
{
	--Textscreen 

	textscreen_color = Color(255, 255, 255, 255),
	-- Color of the textscreen that goes above the hat.

	textscreen_text = "Sorting Hat",
	-- The text that is displayed above the hat.


	--Main Panel Config

	setpanel_draggable = false,
	-- Set if the main panel should be draggable or not.

	setpanel_mainColor = Color(40,40,40,150),
	-- The color of the main rectangle of the panel.

	setpanel_outlineColor = Color(20,20,20,225),
	-- The color of the outline of the main panel.

	openingText = "           Welcome to Hogwarts RolePlay!\nToday you will be sorted into your new House.",
	-- NOTE: The \n is to skip to the next line - you will have to do this when configurating.


	--Close Button

	closebutton_Color = Color(211, 62, 46,255),
	-- Color that displays when the Close button is not touched.

	closebutton_hoverColor = Color(232, 68, 51,255),
	-- Color that displays when someone has their mouse over the Close Button.

	closebutton_downColor = Color(255, 75, 56, 255),
	-- Color that displays when someone clicks the Close Button.

	closebutton_outlineColor = Color(50,50,50,255),
	-- Color that displays a thin outline around the Close button.


	--Sort Button

	sortbutton_text = "Sort Me!",
	-- The Text that displays in the sort button.

	notification_notGroup = "You are already in a House!",
	-- The legacy notification that pops up on the side when the button is pressed
	-- and the person is not a user

	sortbutton_hoverColor = Color(216, 216, 216, 255),
	-- Color that displays when someone has their mouse over the Sort Button.

	sortbutton_Color = Color(204, 204, 204, 255),
	-- Color that displays when the Sort button is not touched.

	sortbutton_downColor = Color(225, 225, 225, 255),
	-- Color that displays when someone clicks the Sort Button.

	sortbutton_outlineColor = Color(50,50,50,255)
	-- Color that displays a thin outline around the Sort button.
}



surface.CreateFont( "2d3dFont", {
	font = "Harry P",
	extended = false,
	size =  ScreenScale(50),
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
})

surface.CreateFont( "panelText", {
	font = "Harry P",
	extended = false,
	size =  ScreenScale(25),
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})

surface.CreateFont( "buttonText", {
	font = "Arial",
	extended = false,
	size =  ScreenScale(7),
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})

-- We WIll Not Provide Support If You Edit Beyond This Point!
function ENT:Draw()
	self:DrawModel()

	local function textscreen(degree)

	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right(),degree)
	ang:RotateAroundAxis(self:GetAngles():Forward(),90)

	cam.Start3D2D(self:GetPos(),ang,0.1)

	draw.DrawText(config.textscreen_text,"2d3dFont",0,-300,config.textscreen_color,1)

	cam.End3D2D()
	end
	textscreen(90)
	textscreen(270)
end

/*
--------------->
GUI
--------------->
*/

local scrw, scrh = ScrW(), ScrH()
local vgui = vgui

local white = Color(255,255,255,255)
local black = Color(0,0,0,255)

local backgroundsound = "sound/hrp/background.mp3"
local sortinghat = "hrp/sortinghat/sortinghat.png"

surface.CreateFont("sortinghat_maintext", {font = "Harry P", size = 18, weight = 350})
surface.CreateFont("sortinghat_bigtext", {font = "Harry P", size = 50, outline = true, weight = 350})
surface.CreateFont("sortinghat_mediumtext", {font = "Harry P", size = 30, weight = 350})

local ChosenHouseInt = math.random(#sortinghat_listOfHouses)
local ChosenHouse = sortinghat_listOfHouses[ ChosenHouseInt ]
local HouseRotationNumber = math.random(#sortinghat_listOfHouses)

net.Receive( "OpenSortingHatMenu", function()

	sound.PlayFile( backgroundsound, "mono", function( station, errCode, errStr )
		if ( IsValid( station ) ) then
			station:Play()
		else
			print( "Error playing sound!", errCode, errStr )
		end
	end )

	sound.PlayFile(ChosenHouse.sound, "mono", function( station, errCode, errStr )
		if ( IsValid( station ) ) then
			station:Play()
		else
			print( "Error playing sound!", errCode, errStr )
		end
	end)

	SortingHatMenu = vgui.Create("DFrame")
		SortingHatMenu:SetSize(scrw, scrh)
		SortingHatMenu:SetAlpha(0)
		SortingHatMenu:AlphaTo(255, 1)
		SortingHatMenu:Center()
		SortingHatMenu:SetTitle("")
		SortingHatMenu:ShowCloseButton(true)
		SortingHatMenu:SetDraggable(false)
		SortingHatMenu:IsMouseInputEnabled(false)

		SortingHatMenu.Paint = function(self,w,h)

			surface.SetDrawColor(black)
			surface.DrawRect(0, 0, scrw, scrh)
			draw.SimpleText("Your new house is...", "panelText", scrw/2-10,scrh*1/2-50, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

		end

		SortingHatMenu.Remove = function()
			net.Start("PlayerJoinedHouse")
			net.WriteUInt(ChosenHouseInt-1, 2)
			net.SendToServer()
		end

	SortingHatImage = vgui.Create("DImage", SortingHatMenu)
		SortingHatImage:SetSize(scrw*1/6, scrh*1/5)
		SortingHatImage:MoveTo(scrw/2-140, scrh*1/5, 1.2)
		SortingHatImage:SetImage(sortinghat)

	for k, v in pairs(sortinghat_listOfHouses) do
		v.imagefunction(scrw, scrh)
	end

	function HouseRotationUI()
		for i = 1, 8 do
			coroutine.wait(2)
			sortinghat_listOfHouses[HouseRotationNumber].imageid()
			HouseRotationNumber = math.random(#sortinghat_listOfHouses)
		end
		coroutine.wait(3)
		ChosenHouse.movetocenter(scrw, scrh)
		coroutine.wait(3)
		SortingHatMenu:Close()
		coroutine.yield()
	end

	hook.Add("Think", "HouseRotation", function()
		if (not co) then
			co = coroutine.create(HouseRotationUI)
		elseif (co) then
			coroutine.resume( co )
		end
	end)

end)

net.Receive("WelcomePlayer", function()
	local house = net.ReadUInt(2)
	local housename = Houses[house+1]
	local ply = net.ReadEntity()
	LocalPlayer():ChatPrint("Please welcome " .. ply:Nick() .. " to " .. housename .. "!")
end)

