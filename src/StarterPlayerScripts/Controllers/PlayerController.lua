local RepStore = game:GetService("ReplicatedStorage")
-- local ContextActionService = game:GetService("ContextActionService")
local Knit = require(RepStore.Packages.Knit)
local PlayerController = Knit.CreateController { Name="PlayerController", playerData={}}
local Players = game:GetService("Players")
local player = Players.LocalPlayer
player.CharacterAdded:Connect(function()
    PlayerController.PlayerService:PlayerAdded(player)
    PlayerController.GameService:PlayerAdded(player)
--     local StarterGui = game:GetService("StarterGui")
--     StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
--     local BackgroundGUI = player:WaitForChild('PlayerGui'):WaitForChild('Background')
--     BackgroundGUI.Enabled = true
--     -- freeze player and camera
--     local ccamera= workspace.CurrentCamera
--     ccamera.CameraType = Enum.CameraType.Scriptable
--    -- ccamera.CFrame = CFrame.new(Vector3.new(215.364, 28.869, 45.529), Vector3.new(90, -90, 0))
--     ContextActionService:BindAction("freezeMovement",
--         function()
--             return Enum.ContextActionResult.Sink
--         end,false,unpack(Enum.PlayerActions:GetEnumItems()
--     ))
    
--     -- display welcome message and modal with mini games available
--    local MessageController = Knit.GetController("MessageController")
--     MessageController.setMessage(player,"Welcome to 2D Games ",1,false)
--     local GameController = Knit.GetController("GameController")
--     GameController.ShowMainMenu(player)
    -- display game gui


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