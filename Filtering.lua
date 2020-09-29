
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", function(self,event,msg,author)
    return MyChatFilter(self,event,msg,author)
end)

ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", function(self,event,msg,author)
    return MyChatFilter(self,event,msg,author)
end)

ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", function(self,event,msg,author)
    return MyChatFilter(self,event,msg,author)
end)

ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", function(self,event,msg,author)
    return MyChatFilter(self,event,msg,author)
end)

ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", function(self,event,msg,author)
    return MyChatFilter(self,event,msg,author)
end)

ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", function(self,event,msg,author)
    return MyChatFilter(self,event,msg,author)
end)

ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", function(self,event,msg,author)
    return MyChatFilter(self,event,msg,author)
end)

ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", function(self,event,msg,author)
    return MyChatFilter(self,event,msg,author)
end)

ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", function(self,event,msg,author)
    return MyChatFilter(self,event,msg,author)
end)

ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", function(self,event,msg,author)
    return MyChatFilter(self,event,msg,author)
end)

--just a comment

function MyChatFilter(self,event,msg,author)
    for index, value in ipairs(AntiSpam_Database.global.bannedWords) do
        if string.find(msg:lower(), value:lower()) then
            return true
        end 
    end
    return false
end