local whisperSended = false;

local function checkIfPlayerIsOnIgnoreList(author)
    if author ~= nil then
        local indexOfDash = string.find(author,"-")
        local player = string.sub(author, 1 ,indexOfDash -1)
        for index, value in ipairs(AntiSpam_Database.char.ingoredPlayers) do
            if string.find(player:lower(), value:lower()) then
                return true
            end
        end
    end
end  

local function ChatTypeIsRegistered(event)
    for index,value in ipairs(AntiSpam_Database.char.Options.selectedChatsForFiltering) do
        if value == event then
            return true;
        end
    end

    return false;
end

local function ChannelIsRegistered(channel)
    for index,value in ipairs(AntiSpam_Database.char.Options.selectedChannelsForFiltering)do
        if value:lower() == channel:lower() then
            return true;
        elseif value:lower() == "services" and string.find(channel:lower(), "services") then
            return true;
        end
    end

    return false;
end

function MyChatFilter(self,event,msg,author,arg3, arg4,arg5,arg6,arg7,arg8,arg9)
    local indexOfDash = string.find(arg9,"-");
    local channel;
    if indexOfDash ~= nil then  
        channel = string.sub(arg9, 1 ,indexOfDash -2);
    else
        channel = arg9;
    end
    local playerFound = checkIfPlayerIsOnIgnoreList(author)
    local chatTypeRegistered = ChatTypeIsRegistered(event);
    if playerFound then
        return true;
    end
    if(chatTypeRegistered) then
        for index, value in ipairs(AntiSpam_Database.global.bannedWords) do
            if string.find(msg:lower(), value:lower()) then
                return true
            end 
        end
    end
  end

function ChannelFilter(self,event,msg,author,arg3, arg4,arg5,arg6,arg7,arg8,arg9)
    local indexOfDash = string.find(arg9,"-");
    local channel;
    local playerFound = checkIfPlayerIsOnIgnoreList(author);
    
    if indexOfDash ~= nil then  
        channel = string.sub(arg9, 1 ,indexOfDash -2);
    else
        channel = arg9;
    end
    if playerFound then
        return true;
    end

    if ChatTypeIsRegistered(event)then
        if ChannelIsRegistered(channel)then
            for index, value in ipairs(AntiSpam_Database.global.bannedWords) do
                if string.find(msg:lower(), value:lower()) then
                    return true
                end 
            end
        end
    end
    return false
end

function WhisperFilter(self,event,msg,author)
    local playerFound = checkIfPlayerIsOnIgnoreList(author);
    if playerFound then
        if AntiSpam_Database.char.Options.replyMessageIsActivated and (AntiSpam_Database.char.Options.replyMessage ~= "" and  AntiSpam_Database.char.Options.replyMessage ~= nil and not whisperSended)then
            SendChatMessage(AntiSpam_Database.char.Options.replyMessage, "WHISPER", "Common", author)
            whisperSended = true;
        end

        return true;
    end

    return false;
end