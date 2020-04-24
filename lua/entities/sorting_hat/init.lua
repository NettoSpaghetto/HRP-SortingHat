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
	if SSQL.Query("SELECT userid FROM " ..  house .. " WHERE userid == " .. ply:SteamID64() ) then
		return true
	else
		return false
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
	for k, v in pairs(Houses) do
		if !PlayerHouseChecker(ply, v) then
			return true
		end
	end
	net.Start("OpenSortingHatMenu")
	net.Send(ply)
end

net.Receive("PlayerJoinedHouse", function(len, ply)

	local house = net.ReadUInt(2)

	PlayerHouseJoin(ply, Houses[house+1])

	net.Start("WelcomePlayer")
	net.WriteUInt(house, 2)
	net.WriteEntity(ply)
	net.Broadcast()
end)

