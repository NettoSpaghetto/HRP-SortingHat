SSQL = {}

function SSQL.Query(q, callback)
    local query = sql.Query( q )
    if callback then
        callback(query)
    end
    return
end

function SSQL.CreateTables() -- Creates the House tables
    if !sql.TableExists("Gryffindor") then
        SSQL.Query("CREATE TABLE Gryffindor(userid TEXT, points INTEGER)")
    end
    if !sql.TableExists("Slytherin") then
        SSQL.Query("CREATE TABLE Slytherin(userid TEXT, points INTEGER)")
    end
    if !sql.TableExists("Ravenclaw") then
        SSQL.Query("CREATE TABLE Ravenclaw(userid TEXT, points INTEGER)")
    end
    if !sql.TableExists("Hufflepuff") then
        SSQL.Query("CREATE TABLE Hufflepuff(userid TEXT, points INTEGER)")
    end
end

SSQL.CreateTables()
print("tables created")

function PlayerHouseJoin(ply, house)
    SSQL.Query("INSERT INTO " .. house .. "(userid) VALUES(" .. sql.SQLStr(ply:SteamID64()) .. ")")
    print("player added to house")
end