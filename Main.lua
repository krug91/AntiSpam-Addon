AntiSpam = LibStub("AceAddon-3.0"):NewAddon("AntiSpam", "AceConsole-3.0", "AceEvent-3.0")

local defaults = {
  global = {
      bannedWords = {},
  },
  locale = {
    ingoredPlayers = {}
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



