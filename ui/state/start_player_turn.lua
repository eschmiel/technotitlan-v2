function ui:createStartPlayerTurnState()
    
    local state = {}
    
    function state:update()
        if(btnp(controllerEnum.x) or btnp(controllerEnum.o)) then
            return ui:createSelectUnitToActState({x=5, y=5})
        end
    end

    function state:draw()
        ui:createNewTurnStartNotice()
    end

    return state
end