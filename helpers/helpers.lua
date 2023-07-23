function convertPositionToPixelCoordinates(position)

    -- 8 is the conversion rate between pixels and positions
    -- 7 is the length and width a position extends from its origin in pixels
    local pixelCoordinates = {
        originX = position.x * 8,
        originY = position.y * 8,
    }

    pixelCoordinates.endX = pixelCoordinates.originX + 7
    pixelCoordinates.endY = pixelCoordinates.originY + 7

    return pixelCoordinates
end

function convertMapPositionToPixelPosition(mapPosition)
    return {
        mapPosition[1] * spriteSideSizeInPixels,
        mapPosition[2] * spriteSideSizeInPixels,
    }
end

function highlightPosition(mapPosition, color)
    local pixelPosition = convertMapPositionToPixelPosition(mapPosition)

    rect(pixelPosition[1], pixelPosition[2], pixelPosition[1]+7, pixelPosition[2]+7, color)
end

function makeTupleCopy(tuple)
    return {tuple[1], tuple[2]}
end