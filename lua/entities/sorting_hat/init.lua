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
	for z1, z2 in pairs(Houses) do
		HSQL.Query("SELECT charid FROM " .. sql.SQLStr(z2) .. " WHERE charid = " .. sql.SQLStr(ply:GetCharacterID()), function(data)
			if !data then
				housecounter = housecounter + 1
				return
			end
			for k1, k2 in pairs(data) do
				for v1, v2 in pairs(k2) do
					if v2 != ply:GetCharacterID() then
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
end

net.Receive("PlayerJoinedHouse", function(len, ply)

	local house = net.ReadUInt(2)

	HSQL.PlayerHouseJoin(ply, Houses[house + 1])

	net.Start("WelcomePlayer")
	net.WriteUInt(house, 2)
	net.WriteEntity(ply)
	net.Broadcast()

end)

