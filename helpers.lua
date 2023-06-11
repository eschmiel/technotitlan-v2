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

function samePosition(position1, position2)
    return position1.x == position2.x and position1.y == position2.y
end

function highlightPosition(position, color)
    local pixelCoordinates = convertPositionToPixelCoordinates(position)

    rect(pixelCoordinates.originX, pixelCoordinates.originY, pixelCoordinates.endX, pixelCoordinates.endY, color)
end

function createPositionObjectCopy(position)
    return {x = position.x, y=position.y}
end