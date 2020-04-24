AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

util.AddNetworkString( "OpenSortingHatMenu" )
util.AddNetworkString( "PlayerJoinedHouse" )
util.AddNetworkString( "WelcomePlayer" )

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
	net.Start("OpenSortingHatMenu")
	net.Send(ply)
end

net.Receive("PlayerJoinedHouse", function(len, ply)

	local house = net.ReadUInt(2)
	net.Start("WelcomePlayer")
	net.WriteUInt(house, 2)
	net.WriteEntity(ply)
	net.Broadcast()
end)

