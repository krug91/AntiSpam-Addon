AntiSpam = LibStub("AceAddon-3.0"):NewAddon("AntiSpam", "AceConsole-3.0", "AceEvent-3.0")

local chatEvents = {
  --"CHAT_MSG_CHANNEL",
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

local defaults = {
  global = {
      bannedWords = {}  
  }
}

IsUiOpened = false

function AntiSpam:OnInitialize()
  AntiSpam_Database = LibStub("AceDB-3.0"):New("AntiSpamDB",defaults, true)
  AntiSpam:RegisterChatCommand("antispam", "AntiSpamCommand")
end

function AntiSpam:AntiSpamCommand(input)
  if not IsUiOpened then
    AntiSpam_Gui:ShowGui()
    IsUiOpened = true
  end
end



