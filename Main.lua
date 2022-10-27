AntiSpam = LibStub("AceAddon-3.0"):NewAddon("AntiSpam", "AceConsole-3.0", "AceEvent-3.0")


local defaults = {
  global = {
      bannedWords = {},
      Options ={
        bannedWordsHasInitData
      }
  },
  char = {
    ingoredPlayers = {},
    Options = {
      hasInitData,
      replyMessageIsActivated,
      replyMessage,
      messageToSendWhenIgnorePlayerIsActivated,
      messageToSendWhenIgnorePlayer,
      replyMessageWithAddonAdvertise = {},
      selectedChatsForFiltering = {}, 
      selectedChannelsForFiltering = {}
      
    }
  }
};

IsUiOpened = false;

GridInitialized = false;
GridDataIgnoreByKeyWord = {};
GridDataIgnoreByName = {};
GridComponent = {}

local function tableContains(table, element)
  for index,value in ipairs(table)do
    if  value == element then
      return true;
    end
  end
  return false;
end

local function InitData()
    if not tableContains(AntiSpam_Database.char.Options.selectedChannelsForFiltering, "Trade")then
     table.insert(AntiSpam_Database.char.Options.selectedChannelsForFiltering, "Trade");
     table.insert(AntiSpam_Database.char.Options.selectedChannelsForFiltering, "Services");
    end
    if not tableContains(AntiSpam_Database.char.Options.selectedChatsForFiltering, "CHAT_MSG_CHANNEL")then
     table.insert(AntiSpam_Database.char.Options.selectedChatsForFiltering, "CHAT_MSG_CHANNEL");
    end
    if not tableContains(AntiSpam_Database.char.Options.selectedChatsForFiltering,"CHAT_MSG_WHISPER")then
      table.insert(AntiSpam_Database.char.Options.selectedChatsForFiltering, "CHAT_MSG_WHISPER");
    end
     AntiSpam_Database.char.Options.replyMessageIsActivated = true;
     AntiSpam_Database.char.Options.replyMessage = "You are ignored don't bother to send messages.";
     AntiSpam_Database.char.Options.messageToSendWhenIgnorePlayer = "You have been ignored with Anti_Spam Addon!!";
     AntiSpam_Database.char.Options.messageToSendWhenIgnorePlayerIsActivated = true;
end

local function BannedWordsInitData()
  if(#AntiSpam_Database.global.bannedWords == 0) then
    table.insert(AntiSpam_Database.global.bannedWords, "WTS M+");
    table.insert(AntiSpam_Database.global.bannedWords, "Guild Wts");
    table.insert(AntiSpam_Database.global.bannedWords, "Guild Group");
    table.insert(AntiSpam_Database.global.bannedWords, "Wts All Glory");
    table.insert(AntiSpam_Database.global.bannedWords, "WR 41 ");
    table.insert(AntiSpam_Database.global.bannedWords, "TOP Eu Guild");
    table.insert(AntiSpam_Database.global.bannedWords, "Selling M+");
    table.insert(AntiSpam_Database.global.bannedWords, "Guild Selling");
    table.insert(AntiSpam_Database.global.bannedWords, "(Guild) Selling");
    table.insert(AntiSpam_Database.global.bannedWords, "(Only Gold)");
    table.insert(AntiSpam_Database.global.bannedWords, "Armor Stack For Free");
    table.insert(AntiSpam_Database.global.bannedWords, "<WTS>");
    table.insert(AntiSpam_Database.global.bannedWords, "<<WTS>>");
    table.insert(AntiSpam_Database.global.bannedWords, "WTS Full HC Runs");
    table.insert(AntiSpam_Database.global.bannedWords, "< World 60 Guild >");
    table.insert(AntiSpam_Database.global.bannedWords, "< Guild Offering >");
  end
end

function AntiSpam:OnInitialize()
  AntiSpam_Database = LibStub("AceDB-3.0"):New("AntiSpamDB",defaults, true);
  AntiSpam:RegisterChatCommand("antispam", "AntiSpamCommand");
  AntiSpam:Print("Hello and thanks for using AntiSpam addon. If you have any suggestion don't hesitate to write it in the comments")
  AntiSpam:Print("for UI type /antispam")

  if AntiSpam_Database.char.Options.hasInitData == nil then
    InitData();
    AntiSpam_Database.char.Options.hasInitData = true;
  end
  if(AntiSpam_Database.global.Options.bannedWordsHasInitData == nil) then 
    BannedWordsInitData();
    AntiSpam_Database.global.Options.bannedWordsHasInitData = true;
  end

  for index, value in ipairs (AntiSpam_Database.char.Options.selectedChatsForFiltering) do
    if value == "CHAT_MSG_CHANNEL"then
      ChatFrame_AddMessageEventFilter(value, ChannelFilter)  
    elseif value == "CHAT_MSG_WHISPER" then
      ChatFrame_AddMessageEventFilter(value, WhisperFilter)
    else
      ChatFrame_AddMessageEventFilter(value, MyChatFilter)
    end
  end
end

function AntiSpam:AntiSpamCommand(input)
  if not IsUiOpened then
    AntiSpam_Gui:ShowGui();
    IsUiOpened = true;
  end
end

