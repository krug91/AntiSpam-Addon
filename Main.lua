AntiSpam = LibStub("AceAddon-3.0"):NewAddon("AntiSpam", "AceConsole-3.0", "AceEvent-3.0")


local defaults = {
  global = {
      bannedWords = {},
  },
  locale = {
    ingoredPlayers = {}
  }
};

IsUiOpened = false;

GridInitialized = false;
GridDataIgnoreByKeyWord = {};
GridDataIgnoreByName = {};
GridComponent = {}

function AntiSpam:OnInitialize()
  AntiSpam_Database = LibStub("AceDB-3.0"):New("AntiSpamDB",defaults, true);
  AntiSpam:RegisterChatCommand("antispam", "AntiSpamCommand");
  AntiSpam:Print("Hello and thanks for using AntiSpam addon. If you have any suggestion don't hesitate to write it in the comments")
  AntiSpam:Print("for UI type /antispam")
end

function AntiSpam:AntiSpamCommand(input)
  if not IsUiOpened then
    AntiSpam_Gui:ShowGui();
    IsUiOpened = true;
  end
end



