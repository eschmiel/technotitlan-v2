function ui:createSelector(startingMapPosition)
    local selector = {
        mapPosition = startingMapPosition or {0,0},
        stateColor = {
            default = colorEnum.brown,
            onUnit = colorEnum.pink
        }
    }

    function selector:controls(positionManager, gameObjects)
        if (btnp(controllerEnum.left)) self.mapPosition[1] -= 1
        if (btnp(controllerEnum.right)) self.mapPosition[1] += 1
        if (btnp(controllerEnum.up)) self.mapPosition[2] -= 1
        if (btnp(controllerEnum.down)) self.mapPosition[2] += 1
        if (btnp(controllerEnum.o)) return self:select(positionManager, gameObjects)
    end

    function selector:select(positionManager, gameObjects)
        return {
            graphPosition = positionManager.navGraph.mapPositionToGraphPosition[self.mapPosition[1]][self.mapPosition[2]],
            mapPosition = self.mapPosition,
            unit = self:hoverTarget(positionManager, gameObjects)
        }
    end
    function selector:hoverTarget(positionManager, gameObjects)
        local graphPosition  = positionManager.navGraph.mapPositionToGraphPosition[self.mapPosition[1]][self.mapPosition[2]]
        if(graphPosition) then
            for unit in all(gameObjects.faction) do
                if(graphPosition == unit.graphPosition) return unit 
            end
        end
    end

    function selector:draw(positionManager, gameObjects)
        local selectorColor = self.stateColor.default

        if(self:hoverTarget(positionManager, gameObjects)) selectorColor = self.stateColor.onUnit

        highlightPosition(self.mapPosition, selectorColor)
    end

    return selector
end