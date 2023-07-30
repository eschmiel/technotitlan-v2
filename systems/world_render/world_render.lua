systems.worldRender = {
    createWorldRenderSystem = function(self, gameObjectManager)
        local system = {
            gameObjectManager = gameObjectManager,
            
            render = function(self)
                local coordinates = self.gameObjectManager.mapCoordinates
                map(coordinates[1], coordinates[2])

                for factionIndex, faction in ipairs(self.gameObjectManager.unitManager.factions) do
                    for unit in all(faction.units) do
                        self:renderUnit(unit, factionIndex)
                    end
                end
            end,

            renderUnit = function(self, unit, factionIndex)
                if(not unit.active) pal(colorEnum.black, colorEnum.grey)
                if(factionIndex > 1) pal(9, factionIndex)
                local pixelPosition = convertMapPositionToPixelPosition(unit.mapPosition)
                spr(unit.sprite, pixelPosition[1], pixelPosition[2])
                pal()
                palt(colorEnum.black, false)
            end
        }
        return system
    end
}