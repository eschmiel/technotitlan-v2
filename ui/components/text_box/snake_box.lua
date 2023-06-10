ui.snakeBox = {
    snakeBoxSprites = {
        head = 203,
        widthSide = 201,
        lengthSide = 218,
        corner = 202,
        tail = 219,
        headTongue = 200,
        tailTongue = 216
    }
}

-- length and width must be at least 3
function ui.snakeBox:draw(originXInPixels, originYInPixels, lengthInSprites, widthInSprites)
    local rightSideSpriteX = originXInPixels + (widthInSprites - 1) * spriteSideSizeInPixels
    local bottomSideSpriteY = originYInPixels + (lengthInSprites -1) * spriteSideSizeInPixels
    
    -- Box background
    rectfill(originXInPixels + 2, originYInPixels +2, (rightSideSpriteX + spriteSideSizeInPixels - 3), (bottomSideSpriteY + spriteSideSizeInPixels - 3), colorEnum.black)

    -- Top left corner
    spr(self.snakeBoxSprites.headTongue, originXInPixels, originYInPixels)

    -- Top side
    for sprite=1, widthInSprites-2 do
        local spriteX = originXInPixels + (sprite * spriteSideSizeInPixels)
        spr(self.snakeBoxSprites.widthSide, spriteX, originYInPixels)
    end

    -- Top right corner
    spr(self.snakeBoxSprites.corner, rightSideSpriteX, originYInPixels)

    -- Right side
    for sprite=1, lengthInSprites-2 do
        local spriteY = originYInPixels + (sprite * spriteSideSizeInPixels)
        spr(self.snakeBoxSprites.lengthSide, rightSideSpriteX, spriteY)
    end

    -- Bottom right corner
    spr(self.snakeBoxSprites.corner, rightSideSpriteX, bottomSideSpriteY, 1, 1, false, true)

    -- Bottom side
    for sprite=1, widthInSprites-2 do
        local spriteX = originXInPixels + (sprite * spriteSideSizeInPixels)
        spr(self.snakeBoxSprites.widthSide, spriteX, bottomSideSpriteY, 1, 1, false, true)
    end

    -- Bottom left cornerr
    spr(self.snakeBoxSprites.corner, originXInPixels, bottomSideSpriteY, 1, 1, true, true)

    -- Left side
    for sprite=2, lengthInSprites-2 do
        local spriteY = originYInPixels + (sprite * spriteSideSizeInPixels)
        spr(self.snakeBoxSprites.lengthSide, originXInPixels, spriteY, 1, 1, true)
    end

    -- tail
    spr(self.snakeBoxSprites.tailTongue, originXInPixels, originYInPixels + spriteSideSizeInPixels)
end