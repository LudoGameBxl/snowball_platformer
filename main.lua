-- [Wiki Love2D](https://love2d.org/wiki/Main_Page), [Wiki LUA](https://www.lua.org/docs.html)
-- [Fonction mathématiques Love2D](https://love2d.org/wiki/General_math)

--love.graphics.setDefaultFilter("nearest") -- pas d'aliasing pour la 2D old scool

local screenWidth, screenHeight



local player = {}
player.frame = 1
player.max_frame = 6
player.frame_width = 300
player.frame_height = 400
player.anim_timer = 1
player.x= 200
player.y = 0
player.speed = 300

local flip = 0.5



local quadList = {}

local mapList = {}
local imgTest

function love.load()
  love.window.setTitle("Snowman project (by Ludo)")
  love.window.setMode(1280, 768)

  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()

  player.image = love.graphics.newImage("images/snowman_sprite.png")
  player.image_width = 300
  player.image_height = 388
  player.sprite = love.graphics.newQuad(0,1240, 300, 388, player.image:getWidth(), player.image:getHeight())



  -- table.insert(quadList, love.graphics.newQuad(0,1240, 290, 388, player.image:getWidth(), player.image:getHeight()))
  -- table.insert(quadList, love.graphics.newQuad(280,1240, 290, 388, player.image:getWidth(), player.image:getHeight()))
  -- table.insert(quadList, love.graphics.newQuad(560,1240, 290, 388, player.image:getWidth(), player.image:getHeight()))
  -- table.insert(quadList, love.graphics.newQuad(840,1240, 290, 388, player.image:getWidth(), player.image:getHeight()))
  -- table.insert(quadList, love.graphics.newQuad(1120,1240, 290, 388, player.image:getWidth(), player.image:getHeight()))
  -- table.insert(quadList, love.graphics.newQuad(1400,1240, 290, 388, player.image:getWidth(), player.image:getHeight()))
  -- table.insert(quadList, love.graphics.newQuad(1680,1240, 290, 388, player.image:getWidth(), player.image:getHeight()))

  imgTest = love.graphics.newImage("images/tile.png")
  table.insert(mapList, love.graphics.newQuad(44,3, 38, 38,imgTest:getWidth(),imgTest:getHeight()))
  table.insert(mapList, love.graphics.newQuad(85,3, 38, 38,imgTest:getWidth(),imgTest:getHeight()))





  local width_frame = 18
  for i = 1, 9 do
    width_frame = width_frame + 276
    table.insert(quadList, love.graphics.newQuad(width_frame,1240, 290, 388, player.image:getWidth(), player.image:getHeight()))
  end

end

local currentFrameTimer = 1
local numberOfFrame = 2
local animationSpeed = 5

function love.update(dt)

  currentFrameTimer = currentFrameTimer + (dt * animationSpeed)

  if currentFrameTimer > numberOfFrame + 1 then
    currentFrameTimer = 1
  end



  if love.keyboard.isDown("right") then
    player.x = player.x + player.speed * dt
    animationSpeed = 5
  elseif love.keyboard.isDown("left") then
    player.x = player.x - player.speed * dt
    animationSpeed = 5

  else
    animationSpeed = 0

  end



end

function love.draw()
  love.graphics.draw(imgTest, mapList[1], 200, 600)
  love.graphics.draw(imgTest, mapList[2], 238, 600)
  love.graphics.draw(imgTest, mapList[2], 276, 600)
  -- love.graphics.rectangle("line", 200, 600, 40, 40)
  love.graphics.draw(player.image, quadList[math.floor(currentFrameTimer)] ,player.x, 200, 0, flip,0.5, player.image_width/2, player.image_height/2)
  --love.graphics.draw(player.image , -20,-1240)
  love.graphics.rectangle("line", player.x - player.image_width/2, 0, player.image_width, player.image_height,1, player.image_width/2, player.image_height/2)
  love.graphics.rectangle("line", 0,0, 280*2, 388)

end

function love.keypressed(key)
  if key=="escape" then love.event.quit() end
  print(key)


  if key == "left" then
    flip = -flip
  end
  if key == "right" then
    flip = math.abs(flip)
  end
end
