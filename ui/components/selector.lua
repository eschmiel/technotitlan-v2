function ui:createSelector(startingPosition)
    local selector = {
        position = startingPosition or {x=0, y=0},
        stateColor = {
            default = colorEnum.brown,
            onUnit = colorEnum.pink
        }
    }

    function selector:controls(gameObjects)
        if (btnp(controllerEnum.left)) self.position.x -= 1
        if (btnp(controllerEnum.right)) self.position.x += 1
        if (btnp(controllerEnum.up)) self.position.y -= 1
        if (btnp(controllerEnum.down)) self.position.y += 1
        if (btnp(controllerEnum.o)) return self:select(gameObjects)
    end

    function selector:select(gameObjects)
        return {
            graphPosition = position.manager.mapPositionToGraphPosition[self.position.x][self.position.y],
            mapPosition = {self.position.x, self.position.y},
            unit = self:hoverTarget(gameObjects)
        }
    end
    function selector:hoverTarget(gameObjects)
        local graphPosition  = position.manager.mapPositionToGraphPosition[self.position.x][self.position.y]
        if(graphPosition) then
            for unit in all(gameObjects.faction) do
                if(graphPosition == unit.position) return unit 
            end
        end
    end

    function selector:draw(gameObjects)
        local selectorColor = self.stateColor.default

        if(self:hoverTarget(gameObjects)) selectorColor = self.stateColor.onUnit

        highlightPosition(self.position, selectorColor)
    end

    return selector
end