IRP.Commands = IRP.Commands or {}
IRP.Commands.Registered = IRP.Commands.Registered or {}

AddEventHandler("np-fw:exportsReady", function()
    addModule("Commands", IRP.Commands)
end)
