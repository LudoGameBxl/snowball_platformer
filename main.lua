-- [Wiki Love2D](https://love2d.org/wiki/Main_Page), [Wiki LUA](https://www.lua.org/docs.html)
-- [Fonction mathématiques Love2D](https://love2d.org/wiki/General_math)

--love.graphics.setDefaultFilter("nearest") -- pas d'aliasing pour la 2D old scool





function love.load()
  love.window.setTitle("Snowman project (by Ludo)")
  -- love.window.setMode(1280, 768)
end


function love.update(dt)

end

function love.draw()

end

function love.keypressed(key)
  if key=="escape" then love.event.quit() end
  print(key)
end
