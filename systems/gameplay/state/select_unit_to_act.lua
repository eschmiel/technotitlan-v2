systems.gameplay.state.createSelectUnitToActState = function(self, startingPosition)
    systems.messenger:sendMessage({
        type = messageTypesEnum.setNewController,
        value = {
            controller = controllersEnum.selector,
            setupData = startingPosition or {0,0}
        }
    })

    local state = {
        receiveMessage = function(self, message)
            if(message.type == messageTypesEnum.selectorPosition) self:runSelector(message.value)
        end,

        runSelector = function(self, selectorPosition)
            local selectorColor = colorEnum.brown

            for unit in all(game_objects.faction) do
                if(sequencesHaveTheSameValues(unit.mapPosition, selectorPosition)) then
                    systems.messenger:sendMessage({
                        type = messageTypesEnum.renderUI,
                        value = {
                            uiElement = uiElementsEnum.unitDetails,
                            unit = unit
                        }
                    })

                    selectorColor = colorEnum.pink
                    break
                end
            end

            systems.messenger:sendMessage({
                type = messageTypesEnum.renderUI,
                value = {
                    uiElement = uiElementsEnum.highlightPosition,
                    color = selectorColor,
                    position = selectorPosition
                }
            })
        end
    }

    return state
end