local chatEvents = {
    "CHAT_MSG_GUILD",
    "CHAT_MSG_OFFICER",
    "CHAT_MSG_PARTY",
    "CHAT_MSG_PARTY_LEADER",
    "CHAT_MSG_RAID",
    "CHAT_MSG_RAID_LEADER",
    "CHAT_MSG_SAY",
    "CHAT_MSG_WHISPER",
    "CHAT_MSG_YELL",
    "CHAT_MSG_CHANNEL"
}


local function MyChatFilter(self,event,msg,author)
    for index, value in ipairs(AntiSpam_Database.global.bannedWords) do
        if string.find(msg:lower(), value:lower()) then
            return true
        end 
    end
    return false
  end
  
  for index, value in ipairs (chatEvents) do
    ChatFrame_AddMessageEventFilter(value, MyChatFilter)
  end
  