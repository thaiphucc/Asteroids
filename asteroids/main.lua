local love=require "love"
local Player=require "objects/Player"
local Game=require "states/Game"
math.randomseed(os.time())--randomize the game bc math.random does not really randomize the game
function love.load()
    love.mouse.setVisible(false)
    mouse_x=0
    mouse_y=0
    local show_debugging=true --turn on or off debugging mode
    player=Player(show_debugging)
    game=Game()
    game:startNewGame(player)
end
function love.keypressed(key)
   if game.state.running then
        if key=="w" then 
            player.thrusting=true
        end
    
        if key=="escape" then
            game:changeGameState("paused")
        end
    elseif  game.state.paused then
        if key == "escape" then
        game:changeGameState("running")
        end
    end
    
end

function love.keyreleased(key)
    if key=="w" then 
        player.thrusting=false
    end
end

function love.update(dt)
mouse_x,mouse_y=love.mouse.getPosition()
if game.state.running then
player:movePlayer()

for ast_index, asteroid in pairs(asteroids) do
    asteroid:move(dt)
end
end
end

function love.draw()
if game.state.running or game.state.paused then
    player:draw(game.state.paused)
   
    for _, asteroid in pairs(asteroids) do
        asteroid:draw(game.state.paused)
    end
    game:draw(game.state.paused)
end--draw if the paused state is true
love.graphics.setColor(1,1,1,1)
love.graphics.print(love.timer.getFPS(),10,10)


end

