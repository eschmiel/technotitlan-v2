systems.ui.unitDetailsBottomBar = {
    sprites = {
        hp = 211,
        physicalAttack = 224,
        physicalDefence = 225,
        magicAttack = 226,
        magicDefence = 229
    }
}

function systems.ui.unitDetailsBottomBar:draw(unit, pixelX, pixelY)
    local textBox = systems.ui.textBox:create(pixelX, pixelY, 3, 16)

    textBox:draw()
    spr(self.sprites.hp, textBox:getColumnX(2)+3, textBox:getRowY(1))
    spr(self.sprites.physicalAttack, textBox:getColumnX(5)+3, textBox:getRowY(1))
    spr(self.sprites.magicAttack, textBox:getColumnX(7)+3, textBox:getRowY(1))
    spr(self.sprites.physicalDefence, textBox:getColumnX(9)+3, textBox:getRowY(1))
    spr(self.sprites.magicDefence, textBox:getColumnX(11)+3, textBox:getRowY(1))

    print(unit.type, textBox.leftPadding, textBox:getRowYWithTextPadding(0), colorEnum.white)
    print(unit.hp..'/'..unit.maxHP, textBox.leftPadding, textBox:getRowYWithTextPadding(1), colorEnum.white)
    print(unit.physicalAttack, textBox:getColumnXWithTextPadding(6), textBox:getRowYWithTextPadding(1), colorEnum.white)
    print(unit.magicAttack, textBox:getColumnXWithTextPadding(8), textBox:getRowYWithTextPadding(1), colorEnum.white)
    print(unit.physicalDefence, textBox:getColumnXWithTextPadding(10), textBox:getRowYWithTextPadding(1), colorEnum.white)
    print(unit.magicDefence, textBox:getColumnXWithTextPadding(12), textBox:getRowYWithTextPadding(1), colorEnum.white)
end