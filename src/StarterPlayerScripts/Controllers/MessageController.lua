
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
-- local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local MessageController = Knit.CreateController { Name="MessageController"}

-- function MessageController.setMessage(player, message,timer,confirm)

--     local MessageGUI = player:WaitForChild('PlayerGui'):WaitForChild('MessageGUI')
--     MessageGUI:WaitForChild('MessageFrame'):WaitForChild('MessageLabel').Text = message
--     MessageGUI.Enabled = true
--     -- if confirm then
--     --     -- add confirm buttons 

--     -- end
--     task.wait(timer)
--     MessageGUI.Enabled = false

-- end
-- function MessageController.KnitStart()
   
-- end
return MessageController