function ui:createUIManager(gameObjects, startingState)
    local manager = {
        gameObjects = gameObjects,
        state = startingState
    }

    function manager:update()
        local newState = self.state:update(self.gameObjects)
        if(newState) self.state = newState
    end

    function manager:draw()
        self.state:draw(self.gameObjects)
    end

    return manager
end