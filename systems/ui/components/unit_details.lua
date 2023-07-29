ui.unitDetails = {
    sprites = {
        hp = 211,
        physicalAttack = 224,
        physicalDefence = 225,
        magicAttack = 226,
        magicDefence = 227
    }
}

function systems.ui.unitDetails:draw(unit, pixelX, pixelY)
    local textBox = systems.ui.textBox:create(pixelX, pixelY, 7, 6)

    textBox.leftPadding = pixelX + spriteSideSizeInPixels
    textBox.topPadding = pixelY + 5
    textBox.textLeftPadding = 2
    textBox.textTopPadding = 1
    textBox.rowHeight = spriteSideSizeInPixels
    textBox.rowTopMargin = 4
    textBox.columnWidth = spriteSideSizeInPixels
    textBox.columnMargin = 1

    textBox:draw()
    spr(self.sprites.hp, textBox:getColumnX(2) + 4 , textBox:getRowY(1)-1)
    spr(self.sprites.physicalAttack, textBox.leftPadding, textBox:getRowY(2))
    spr(self.sprites.magicAttack, textBox:getColumnX(2), textBox:getRowY(2))
    spr(self.sprites.physicalDefence, textBox.leftPadding, textBox:getRowY(3))
    spr(self.sprites.magicDefence, textBox:getColumnX(2), textBox:getRowY(3))

    print(unit.type, textBox.leftPadding, textBox:getRowYWithTextPadding(0) + 1, colorEnum.white)
    print(unit.hp..'/'..unit.maxHP, textBox.leftPadding, textBox:getRowYWithTextPadding(1), colorEnum.white)
    print(unit.physicalAttack, textBox:getColumnXWithTextPadding(1), textBox:getRowYWithTextPadding(2), colorEnum.white)
    print(unit.magicAttack, textBox:getColumnXWithTextPadding(3), textBox:getRowYWithTextPadding(2), colorEnum.white)
    print(unit.physicalDefence, textBox:getColumnXWithTextPadding(1), textBox:getRowYWithTextPadding(3), colorEnum.white)
    print(unit.magicDefence, textBox:getColumnXWithTextPadding(3), textBox:getRowYWithTextPadding(3), colorEnum.white)
end