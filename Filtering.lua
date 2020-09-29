
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", function(self,event,msg,author)
    return MyChatFilter(self,event,msg,author)
end)

function MyChatFilter(self,event,msg,author)
    for index, value in ipairs(AntiSpam_Database.global.bannedWords) do
        if string.find(msg:lower(), value:lower()) then
            return true
        end 
    end
    return false
end