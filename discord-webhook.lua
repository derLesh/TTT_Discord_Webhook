AddCSLuaFile()

require "json"
local j = json


webhookURL = "https://discordapp.com/api/webhooks/468473397668741128/EV96GaLdWZ6o1Bl0voC7pSlhkXj47WCQG6Fev-VApBnGS4609QvxZRX0c1qc8qX-pieg"
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
    msg = j.encode( {
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
        content = DiscordWebhook:BuildMessage(ply, msg),
        username = "TTT-Log",
    }
    http.Post(webhookURL, t_post)
    print( "Sucsess" )
end )
