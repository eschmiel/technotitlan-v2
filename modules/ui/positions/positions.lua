modules.ui.positions = {
    highlightPositions = function(self, mapPositions, color)
        for position in all(mapPositions) do
            local origin = self:convertMapPositionToPixelCoordinates(position)
        
            local endPoint = { 
                origin[1] + spriteSideSizeInPixels - 1,
                origin[2] + spriteSideSizeInPixels - 1
            }

            rect(origin[1], origin[2], endPoint[1], endPoint[2], color)
        end
    end,

    convertMapPositionToPixelCoordinates = function(self, mapPosition)
        return {
            mapPosition[1] * spriteSideSizeInPixels,
            mapPosition[2] * spriteSideSizeInPixels,
        }
    end
}