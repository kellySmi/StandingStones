local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
-- local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local GameController = Knit.CreateController { Name="GameController"}

function GameController.UpdatePlayer(player)
--     GameController.GameMenu.Enabled = true

end
-- function GameController.startRound(update)
--     local player = game:GetService("Players").LocalPlayer
--    -- show screen gui and refresh numberlabel every second in loop
--    local message = "Game Starts In"
--    local messageGui = player:WaitForChild("PlayerGui"):WaitForChild("GameMessage")
--    messageGui.MessageFrame.TitleLabel.Text= message
   
-- end
function GameController.startTimer(update)
    local player = game:GetService("Players").LocalPlayer
    local message = "Game Starts In"
    local messageGui = player:WaitForChild("PlayerGui"):WaitForChild("GameMessage")
    messageGui.MessageFrame.TitleLabel.Text= message
    messageGui.Enabled = true
    messageGui.MessageFrame.NumberLabel.Text = update.timer
end
function GameController.showWinnerStartCountdown(update)
    local player = game:GetService("Players").LocalPlayer
    local messageGui = player:WaitForChild("PlayerGui"):WaitForChild("GameMessage")
    messageGui.Enabled = false
    local statusGui = player:WaitForChild("PlayerGui"):WaitForChild("GameStatus")
    statusGui.StatusFrame.Title2Label.Text = update.winner
    local wColor = BrickColor.new(update.winner)
    statusGui.StatusFrame.Title2Label.BackgroundColor3 = wColor.Color -- Color3.fromRGB(wColor.r,wColor.g,wColor.b)
    statusGui.StatusFrame.Title2Label.BackgroundTransparency = 0
    statusGui.Enabled = true
   
end
function GameController.updateRoundCountdown(update)
    local player = game:GetService("Players").LocalPlayer
    local statusGui = player:WaitForChild("PlayerGui"):WaitForChild("GameStatus")
    statusGui.StatusFrame.Number1Label.Text =  update.timer
end
function GameController.endRound(update)
    local player = game:GetService("Players").LocalPlayer
    local messageGui = player:WaitForChild("PlayerGui"):WaitForChild("GameMessage")
    messageGui.Enabled = false
    local statusGui = player:WaitForChild("PlayerGui"):WaitForChild("GameStatus")
    statusGui.Enabled = false
end

function GameController.endGame(update)
    local player = game:GetService("Players").LocalPlayer
    local messageGui = player:WaitForChild("PlayerGui"):WaitForChild("GameMessage")
    messageGui.MessageFrame.TitleLabel.Text = update.message
    messageGui.MessageFrame.NumberLabel.Text = " "
    messageGui.Enabled = true
    task.wait(3)
    messageGui.Enabled = false

end

function GameController.listenGameUpdates()
    -- this signal comes from the service and updates the GUIs whenever there is a save to the service
    GameController.GameService.GameEventSignal:Connect( function(update)  
       -- local playa = game:GetService("Players").LocalPlayer
        if update.allPlayers then 
            -- dispatch events from server here
            GameController[update.event](update)
        -- elseif player.UserId == playa.UserId then
        --     -- handle player specific events here
        --     GameController.UpdatePlayer(playa)
        end
    end)
end
function GameController.KnitStart()
    GameController.GameService = Knit.GetService("GameService")
    GameController.ScreenGUIController = Knit.GetController("ScreenGUIController")
    -- local player = game:GetService("Players").LocalPlayer
    -- GameController.GameMenu = player:WaitForChild("PlayerGui"):WaitForChild("GameMenu")
    GameController.listenGameUpdates()
end
return GameController