exports['progressbar']:progress({
        name = name:lower(),
        duration = duration,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        controlDisables = disableControls,
        animation = animation,
        prop = prop,
        propTwo = propTwo,
    }, function(cancelled)
    if not cancelled then
        if onFinish then
            onFinish()
        end
        else
            if onCancel then
                onCancel()
                end
            end
    end)
end