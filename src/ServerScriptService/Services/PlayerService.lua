local repStore = game:GetService("ReplicatedStorage")
local Knit = require(repStore.Packages.Knit)
local TableUtil = require(repStore.Packages.TableUtil)
local PlayerService = Knit.CreateService( { Name="PlayerService", Client = {} } )
PlayerService.PlayerList = {}
function PlayerService.Client:PlayerAdded(self, player)
    -- add to player list
    PlayerService.PlayerList[#PlayerService.PlayerList+1] = player
end

function PlayerService.Client.PlayerLeft(player)
    -- remove from list 
    PlayerService.PlayerList = TableUtil.Map(PlayerService.PlayerList, function (p)
        if p.UserId ~= player.UserId then 
            return p
        end
    end)
end
--local playerData = { coins=0, doors={}, backsack={}, lastConnectDate="", lastSpawnPt="Start"}
return PlayerService