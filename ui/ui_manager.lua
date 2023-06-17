function ui:createUIManager(positionManager, gameObjects, startingState)
    local manager = {
        positionManager = positionManager,
        gameObjects = gameObjects,
        state = startingState
    }

    function manager:update()
        local newState = self.state:update(self.positionManager, self.gameObjects)
        if(newState) self.state = newState
    end

    function manager:draw()
        self.state:draw(self.positionManager, self.gameObjects)
    end

    return manager
end