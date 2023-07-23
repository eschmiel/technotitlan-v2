systems.worldRender = {
    createWorldRenderSystem = function(self, gameObjectManager)
        local system = {
            render = function(self)
                local coordinates = gameObjectManager.mapCoordinates
                map(coordinates[1], coordinates[2])

                for faction in all(gameObjectManager.playerFactions) do
                    for unit in all(faction) do
                        self:renderUnit(unit)
                    end
                end
            end,

            renderUnit = function(self, unit)
                if(not unit.active) pal(colorEnum.black, colorEnum.grey)
                local pixelPosition = convertMapPositionToPixelPosition(unit.mapPosition)
                spr(unit.sprite, pixelPosition[1], pixelPosition[2])
                pal()
                palt(colorEnum.black, false)
            end
        }
        return system
    end
}