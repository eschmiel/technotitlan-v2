systems.ui.textBox = {}

function systems.ui.textBox:create(pixelX, pixelY, widthInSprites, lengthInSprites)
    -- These defaults are for the unit details bottom bar
    local textBox = {
        leftPadding = pixelX + spriteSideSizeInPixels,
        topPadding = pixelY + 3,
        textLeftPadding = 4,
        textTopPadding = 2,
        rowHeight = spriteSideSizeInPixels,
        rowTopMargin = 1,
        columnWidth = spriteSideSizeInPixels,
        columnMargin = 1
    }
    
    function textBox:getRowY(rowNumber)
        return self.topPadding + ((self.rowHeight +  self.rowTopMargin) * rowNumber)
    end

    function textBox:getColumnX(columnNumber)
       return self.leftPadding + ((self.columnWidth + self.columnMargin) * columnNumber) 
    end

    function textBox:getRowYWithTextPadding(rowNumber)
        return self:getRowY(rowNumber) + self.textTopPadding
    end

    function textBox:getColumnXWithTextPadding(columnNumber)
        return self:getColumnX(columnNumber) + self.textLeftPadding
    end

    function textBox:draw()
        systems.ui.snakeBox:draw(pixelX, pixelY, widthInSprites, lengthInSprites)
    end

    return textBox
end