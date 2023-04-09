local repStore = game:GetService("ReplicatedStorage")
local Knit = require(repStore.Packages.Knit)
local TableUtil = require(repStore.Packages.TableUtil)
local testing = true
local GameService = Knit.CreateService( { 
    Name="GameService", 
    Client = {
        GameEventSignal = Knit.CreateSignal()
    },
    runningGame=false
})

GameService.BoardData = {
    stones = {
        {  stoneName = "field1",
            position = {41.25, 25, 105.75},
            size = { 14.5, 1, 12.7 },
            instances = {},
            timer=8
        }
    },
    currRound=1,
    colors={"White", "Bright red","Bright blue","Bright yellow","Bright green","Bright violet","Bright orange","Black"}
}
function GameService.DrawBoard(redraw) 
   local boardData = GameService.BoardData
 --   FieldController.FieldService:GetFieldData():andThen(function(fieldData) 
     -- iterate through fields and create each field at position and size 
     local stone =  repStore.Stone -- A Part which should have all the base properties
     local rando = Random.new()
     local inCt = 1
     for i, brd in  boardData.stones do -- this loop is for the keystones in the stones table
        local xit = 6 -- brd['size'][1] --/6 
        local zit = 6 -- brd['size'][3] -- /6
        local xpos = brd['position'][1]
        local cn = 1
        for xi=1, xit, 1 do
            local zpos = brd['position'][3]
            
            for zi=1, zit, 1 do
                local node = stone:Clone()
               local pos = CFrame.new(xpos,brd['position'][2],zpos)
                
                --- local pos = CFrame.new(brd['position'][1],brd['position'][2],brd['position'][3])               
                node.Anchored = true
                node.Transparency = 0
                node.Material = Enum.Material.Cobblestone
                node.Size = Vector3.new(brd['size'][1],brd['size'][2],brd['size'][3])
            -- this does random number generation, 
            -- but we need to ensure the winning square has an increasing percentage 
                cn = rando:NextInteger(1,8)
                node.Name = "stone_"..xi.."_"..zi
                node.BrickColor = BrickColor.new(boardData.colors[cn])
                boardData.stones[i].instances[inCt] = {name=node.Name, position=brd['position'], color=boardData.colors[cn]}
                inCt = inCt + 1
                node:PivotTo(pos)
                node.Parent = workspace.GamePieces
                zpos = (zpos - brd['size'][3])
             end
            xpos = (xpos - brd['size'][1])
        end
    end
    
end
function GameService.TeleportPlayersToGame(fromLobby,winnerList)
    local players = GameService.PlayerService.PlayerList
    local randy = Random.new()
    if fromLobby then
        for _, player in ipairs(players) do
            -- pick random piece position
            GameService.teleportToPlace(player,GameService.BoardData.stones[1].instances[randy:NextInteger(1,#GameService.BoardData.stones[1].instances)].position)
        end
    else
        -- just do the winners of the last round 
        for _, player in ipairs(winnerList) do
            GameService.teleportToPlace(player,GameService.BoardData.stones[1].instances[randy:NextInteger(1,#GameService.BoardData.stones[1].instances)].position)
        end
    end
end
function GameService.teleportToPlace(player, dest)
    
    local newDest = Vector3.new(dest[1], dest[2],dest[3]) 
    player.Character:MoveTo(newDest)
   --  task.wait(5)

end

function GameService.Client:PlayerAdded(player)
    -- a player has entered the game, check if a game is running
    -- if no running game then start game now with all players
    if not GameService.runningGame then
        GameService.StartGame(player)
        -- the game should be running continuously after this2
    end
   
end
function GameService.StartGame(player) 
 -- draw board 
    GameService.DrawBoard()
-- teleport players to board 
    task.wait(2)
    GameService.TeleportPlayersToGame(true) -- send them all from the lobby since this is the first round
    GameService.runningGame = true
-- begin game play 
    while GameService.runningGame do
        local roundWinners = GameService.startRound(player) 
        if #roundWinners == 1 or not testing then
            GameService.endRound(player)
            GameService.endGame(player, roundWinners[1])
        else 
            GameService.endRound(player)
            GameService.DrawBoard(true)
            task.wait(1)
            --GameService.TeleportPlayersToGame(false,roundWinners)
        end
    end
end
function GameService.endRound(player)
    -- GameService.clearBoard()
    GameService:UpdateGameEventSignal(player,{event="endRound", allPlayers=true})
end
function GameService.endGame(player, winner)
    -- we have a winner so put up their name in the status gui
    -- now 
    GameService.runningGame = false
    GameService:UpdateGameEventSignal(player,{event="endGame",allPlayers=true, message=winner.Name.." has won."})
    task.wait(5)
    print("ReStarting a new game now")
    GameService.StartGame(player)
end
function GameService.startRound(player)
    local rando = Random.new()
    local win = rando:NextInteger(1,#GameService.BoardData.colors)
    local winningColor = GameService.BoardData.colors[win]
    -- show timer GUI and start timer
    local update = {event="startRound", allPlayers=true, winner=winningColor, timer=5}
    -- fire game event signal to start the round, the client should show a 5 sec timer display.
    GameService:UpdateGameEventSignal(player, update) 
    -- we will loop here and send the countdown to the ui to keep all players in sync
    local i = 0
    local ctr = update.timer
    while i < ctr do
     --print(5-i)
     update.event = "startTimer"
     GameService:UpdateGameEventSignal(player, update) 
     task.wait(1)
     i = i + 1
     update.timer = (ctr - i)
    end
    task.wait(1)
    update.event = "showWinnerStartCountdown"
    GameService:UpdateGameEventSignal(player, update)
    -- do round countdown here like the start countdown
    local ix = 0
    local tmr = 5
    while ix < tmr do
        update.event = "updateRoundCountdown"
        update.timer = (tmr - ix)
        GameService:UpdateGameEventSignal(player, update)
        task.wait(1)
        ix = ix + 1
    end
    update.timer = 0
    GameService:UpdateGameEventSignal(player, update)

    -- drop the parts from here , unanchor all parts that don't have the winning color
    local gamePieces = workspace.GamePieces:GetChildren()
    for _, piece in ipairs(gamePieces) do
        if piece.BrickColor.Name ~= winningColor then
            piece.Anchored = false
        end
    end
    return GameService.getRoundWinners()
end
function GameService.getRoundWinners()
    local winnersList = {}
    local allPlayers = GameService.PlayerService.PlayerList
    for _, player in ipairs(allPlayers) do
        
        -- this is the height of the board so if you are above it or below it then you didn't make it
        if player.Character.PrimaryPart.CFrame.p.Y < 30 and player.Character.PrimaryPart.CFrame.p.Y > 25 then
            winnersList[#winnersList+1] = player
        end
    end
    -- print(winnersList)
    return winnersList
end

function GameService.clearBoard()
    local gamePieces = workspace.GamePieces:GetChildren()
    for _, piece in ipairs(gamePieces) do
       piece:Destroy()
    end
end

function GameService:UpdateGameEventSignal(player, update) 
    self.Client.GameEventSignal:Fire(player,update)
end

function GameService.KnitStart()
    GameService.PlayerService = Knit.GetService("PlayerService")
end

return GameService