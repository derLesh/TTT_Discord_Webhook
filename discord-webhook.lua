AddCSLuaFile()

j = require("json")

webhookURL = "https://discordapp.com/api/webhooks/XXX"
local DiscordWebhook = DiscordWebhook or {}

local addonName = "[Discord-Webhook]"

if SERVER then
    print(addonName .. " loaded")
end

hook.Add( "FirstTime", "Init", function()
    CreateConVar("sv_webhook", "0", FCVAR_PROTECTED, "Get your Discord channel webhook link and set the link as value")
end )

function DiscordWebhook:CheckRole( ply )
    if ply:IsRole(ROLE_TRAITOR) then
        role = "Traitor > "
        elseif ply:IsRole(ROLE_DETECTIVE) then
            role = "Detective > "
        else 
            role = ""
    end
end

function DiscordWebhook:BuildMessage( ply, text )
    msg = util:TableToJSON( {
        embeds = { 
            description = text, 
            author = { 
                name = ply:Nick()
            }, 
        }, 
    } )
    return msg
end

hook.Add( "PlayerSay", "SendMsg", function( ply, msg )
    fMsg = {
        content = BuildMessage:msg(ply, msg),
        username = "TTT-Log",
    }
    http.Post(webhookURL, t_post)
    print( "Sucsess" )
end )
