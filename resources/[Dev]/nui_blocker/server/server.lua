local webhook = "https://discordapp.com/api/webhooks/977521642416787486/pjzg_vRKuf34fBgzXYuFHuOgSBzdqnUv6R16A-q5Awh2Hmt461gpxSYdEEZxam0yMPHv"

RegisterServerEvent("cooltrigger")
AddEventHandler("cooltrigger", function()
    src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local rank = user:getVar("rank")
    if rank == 'user' then
        print('detekted ' .. GetPlayerName(source))
        sendToDiscord("Asshole Logged", GetPlayerName(source).." tried to use nui_devtools at "..os.time())
        DropPlayer(source, 'Hmm, what you wanna do in this inspector?')
    end
end)

function sendToDiscord(name, args, color)
    local connect = {
          {
              ["color"] = 16711680,
              ["title"] = "".. name .."",
              ["description"] = args,
              ["footer"] = {
                  ["text"] = "Made by iciest ",
              },
          }
      }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Asshole Log", embeds = connect, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end