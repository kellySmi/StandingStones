local RepStore = game:GetService("ReplicatedStorage")
-- local ContextActionService = game:GetService("ContextActionService")
local Knit = require(RepStore.Packages.Knit)
local PlayerController = Knit.CreateController { Name="PlayerController", playerData={}}
local Players = game:GetService("Players")
local player = Players.LocalPlayer
player.CharacterAdded:Connect(function()
   -- print("player connecting")
    PlayerController.PlayerService:PlayerAdded(player)
    PlayerController.GameService:PlayerAdded(player)
end)
player.CharacterRemoving:Connect(function() 
    PlayerController.PlayerService:PlayerLeft()
end)
function PlayerController.KnitStart()

    --  print("player knitInited on player ctrlr")
    PlayerController.GameService = Knit.GetService("GameService")
    PlayerController.PlayerService = Knit.GetService("PlayerService")
     -- PlayerController
    -- Listen for signals from the server:
    
  end
  return PlayerController