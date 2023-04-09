local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
local ScreenGUIController = Knit.CreateController { Name="ScreenGUIController"}
-- local playa = game:GetService("Players").LocalPlayer
function ScreenGUIController.displayMessage(message)


end
function ScreenGUIController.displayStatus(messages)
-- display the status GUI and set the text
    -- local statusGui = playa:WaitForChild("PlayerGui"):WaitForChild("GameStatus")
    -- statusGui.MessageFrame.TitleLabel = messages.label1

end

-- function ScreenGUIController.startRound()
--  -- display the message gui and count down 
-- -- 

-- end

-- function ScreenGUIController.dropParts()

-- end
-- add listener for game updates, open Game status GUI and set
-- function ScreenGUIController.listenGameUpdates()
    
--     ScreenGUIController.GameService.GameEventSignal:Connect( function(player, update) 
--         -- check if this is for allplayers or just this player
--         if update.allPlayers then 
--         --     -- call function for 
--             ScreenGUIController[update.event]()
--         --     ScreenGUIController.displayMessage(update)
--         -- elseif player.UserId == playa.UserId then
--         --      -- then call function for update status
--         --     ScreenGUIController.displayStatus()
--         end

--     end)
-- end

function ScreenGUIController.KnitStart() 
  --  ScreenGUIController.GameService =  Knit.GetService("GameService")
   -- ScreenGUIController.listenGameUpdates()
end
return ScreenGUIController