-- [Wiki Love2D](https://love2d.org/wiki/Main_Page), [Wiki LUA](https://www.lua.org/docs.html)
-- [Fonction mathématiques Love2D](https://love2d.org/wiki/General_math)

--love.graphics.setDefaultFilter("nearest") -- pas d'aliasing pour la 2D old scool

local screenWidth, screenHeight


--player
local player = {}
player.frame = 1
player.max_frame = 6
player.frame_width = 300
player.frame_height = 400
player.anim_timer = 1
player.x= 0
player.y = 300
player.vX = 300
player.vY = 300
player.speed = 400
player.flip = 1
local quadList = {}

--Map
local map = {}
map.tiles = {}
map.grid = {
  {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
  {3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3},
  {3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3}
}



function love.load()
  love.window.setTitle("Snowball project (by Ludo)")
  love.window.setMode(1280, 768)
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()

  player.image = love.graphics.newImage("images/player_walk.png")
  player.width = 124
  player.height = 200

  map.image = love.graphics.newImage("images/tile.png")
  table.insert(map.tiles, love.graphics.newQuad(44,3, 38, 38,map.image:getWidth(),map.image:getHeight()))
  table.insert(map.tiles, love.graphics.newQuad(85,3, 38, 38,map.image:getWidth(),map.image:getHeight()))
  table.insert(map.tiles, love.graphics.newQuad(85,44, 38, 38,map.image:getWidth(),map.image:getHeight()))




  --124 x 200
  local width_frame = 0
  for i = 1, 9 do
    width_frame = width_frame + 124
    table.insert(quadList, love.graphics.newQuad(width_frame,0, 124, 200, player.image:getWidth(), player.image:getHeight()))
  end

end

local currentFrameTimer = 1
local numberOfFrame = 9
local animationSpeed = 5

function love.update(dt)

  local accel = 500
  local friction = 0
  local maxSpeed = 300
  local jumpVelocity = -280


  if player.vX > 0 then
    player.vX = player.vX - friction * dt
    if player.vX < 0 then player.vX = 0 end
  end
  if player.vX < 0 then
    player.vX = player.vX + friction * dt
    if player.vX > 0 then player.vX = 0 end
  end


  currentFrameTimer = currentFrameTimer + (dt * animationSpeed)
  animationSpeed = 5
  if currentFrameTimer > numberOfFrame then
    currentFrameTimer = 1
  end


  if player.vX == 0 then
    animationSpeed = 0
  end
  print(player.vX)

  if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    player.vX = player.vX + accel*dt
    if player.vX > maxSpeed then 
      player.vX = maxSpeed 
    end
  end
  if love.keyboard.isDown("left") or love.keyboard.isDown("q") then
    player.vX = player.vX - accel*dt
    if player.vX < -maxSpeed then 
      player.vX = -maxSpeed 
  end

  else
   

  end


  player.x = player.x + player.vX * dt
end

function love.draw()

  for row, valueRow in ipairs(map.grid) do
    for col, valueCol in ipairs(valueRow) do
      love.graphics.draw(map.image, map.tiles[valueCol], (col-1)*38, (row-1)*38 +screenHeight - 38*3)
    end
  end

  
  love.graphics.draw(map.image, map.tiles[2], 238, 600)
  love.graphics.draw(map.image, map.tiles[2], 276, 600)
 
  love.graphics.draw(player.image, quadList[math.floor(currentFrameTimer)] ,player.x, player.y,0, player.flip,1,player.width/2, player.height/2)

  love.graphics.rectangle("line", player.x -  player.width /2, player.y -player.height / 2, player.width, player.height)

  --debugs
  love.graphics.print("FPS: "..love.timer.getFPS(), 0 ,10)
  love.graphics.print("currentFrame player: " ..math.floor(currentFrameTimer), 0, 25)




end

function love.keypressed(key)
  if key=="escape" then love.event.quit() end
  print(key)

end
