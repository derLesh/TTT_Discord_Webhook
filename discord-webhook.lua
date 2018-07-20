AddCSLuaFile()

json = require("json")

webhookURL = "https://discordapp.com/api/webhooks/XXX"
local DiscordWebhook = DiscordWebhook or {}

hook.Add( "PlayerSay", "SendMsg", function( ply, text )
    t_post = {
        content = text,
        username = "TTT-Log",
    } 
    http.Post(webhookURL, t_post)
end )
