-- SSQL = {}

-- local Player = FindMetaTable("Player")

-- function SSQL.Query(q, callback)
--     local query = sql.Query( q )
--     if callback then
--         callback(query)
--     end
--     return
-- end

-- function SSQL.CreateTables() -- Creates the House tables
--     if !sql.TableExists("Gryffindor") then
--         SSQL.Query("CREATE TABLE Gryffindor(charid TEXT, points INTEGER)")
--     end
--     if !sql.TableExists("Slytherin") then
--         SSQL.Query("CREATE TABLE Slytherin(charid TEXT, points INTEGER)")
--     end
--     if !sql.TableExists("Ravenclaw") then
--         SSQL.Query("CREATE TABLE Ravenclaw(charid TEXT, points INTEGER)")
--     end
--     if !sql.TableExists("Hufflepuff") then
--         SSQL.Query("CREATE TABLE Hufflepuff(charid TEXT, points INTEGER)")
--     end
-- end

-- SSQL.CreateTables()

-- function PlayerHouseJoin(ply, house)
--     SSQL.Query("INSERT INTO " .. sql.SQLStr(house) .. "(charid) VALUES(" .. sql.SQLStr(ply:GetCharacterID()) .. ")")
-- end

-- function Player:InFaction(house)
--     SSQL.Query("SELECT charid FROM " .. sql.SQLStr(house) .. " WHERE charid = " .. sql.SQLStr(Player:GetCharacterID()), function(data)
--         if house then
--             if data then
--                 return true
--             else
--                 return false
--             end
--         else
--             return false
--         end
--     end)
-- end