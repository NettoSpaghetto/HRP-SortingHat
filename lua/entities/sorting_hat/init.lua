AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

util.AddNetworkString( "OpenSortingHatMenu" )
util.AddNetworkString( "PlayerJoinedHouse" )
util.AddNetworkString( "WelcomePlayer" )

local Houses = {
	[1] = "Gryffindor",
	[2] = "Slytherin",
	[3] = "Ravenclaw",
	[4] = "Hufflepuff"
}

local function PlayerHouseChecker(ply, house)
	if SSQL.Query("SELECT userid FROM " .. sql.SQLStr(house) .. " WHERE userid = " .. sql.SQLStr(ply:SteamID64()) ) then
		return true
	else
		return nil
	end
end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 25
	local ent = ents.Create( "sorting_hat" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
	self:SetModel( sortinghat_model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
		local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use(ent, ply)
	local housecounter = 0
	-- for k, v in pairs(Houses) do
	-- 	if !SSQL.Query("SELECT userid FROM " .. sql.SQLStr(v) .. " WHERE userid = " .. sql.SQLStr(ply:SteamID64()) ) then
	-- 		housecounter = housecounter + 1
	-- 	end
	-- 	if housecounter == 4 then
	-- 	end
	-- end
	for z1, z2 in pairs(Houses) do
		SSQL.Query("SELECT userid FROM " .. z2 .. " WHERE userid = " .. ply:SteamID64(), function(data)
			if !data then 
				housecounter = housecounter + 1
				return
			end
			for k1, k2 in pairs(data) do
				for v1, v2 in pairs(k2) do
					if v2 != ply:SteamID64() then
						housecounter = housecounter + 1
					end
				end
			end
		end)
	end
	if housecounter == 4 then
		net.Start("OpenSortingHatMenu")
		net.Send(ply)
	else
		ply:PrintMessage(HUD_PRINTTALK, "You cannot be sorted twice!")
	end
	print("has ran")
end

net.Receive("PlayerJoinedHouse", function(len, ply)

	local house = net.ReadUInt(2)

	PlayerHouseJoin(ply, Houses[house+1])

	net.Start("WelcomePlayer")
	net.WriteUInt(house, 2)
	net.WriteEntity(ply)
	net.Broadcast()
end)

