function createUnit(options)
    local unit = {
        type = 'tez',
        position = options.position or {x=4, y=5},
        sprite = 13,

        active = true,
        maxHP = 10,
        movement = 3,

        physicalAttack = 5,
        magicAttack = 2,

        physicalDefence = 2,
        magicDefence = 3,

        physicalAttackRange = 1,
        magicAttackRange = 3,

        actions = {
            'move',
            'attack',
            'wait',
            'cancel'
        }
   }

    unit.hp = unit.maxHP

    function unit:draw()
        if(not self.active) pal(colorEnum.black, colorEnum.grey)
        local pixelCoordinates = convertPositionToPixelCoordinates(self.position)

        spr(self.sprite, pixelCoordinates.originX, pixelCoordinates.originY)
        pal()
        palt(colorEnum.black, false)
    end

    return unit
end

