Gui = LibStub("AceGUI-3.0")
Grid = LibStub("ScrollingTable")

AntiSpam_Gui = {};

local gridIsHided = false;

local widgetList = {tabGroup = {}};

local chatList = {
    ["CHAT_MSG_GUILD"] = "Guild",
    ["CHAT_MSG_OFFICER"] = "Officer",
    ["CHAT_MSG_PARTY"] = "Party",
    ["CHAT_MSG_PARTY_LEADER"] = "Party Leader",
    ["CHAT_MSG_RAID"] = "Raid",
    ["CHAT_MSG_RAID_LEADER"] = "Raid Leader",
    ["CHAT_MSG_SAY"] = "Say",
    ["CHAT_MSG_YELL"] = "Yell" ,
    ["CHAT_MSG_CHANNEL"] = "Channel"
}

local channelsList = {};

local tabs = {
      {value = "IGNORE_BY_KEYWORD", text = "Ignore by keyword"},
      {value = "IGNORE_BY_NAME", text = "Ignore by character name"},
      {value = "OPTIONS", text = "Options"}
};

local ignoreByNameCols = {
      {["name"] = "Name", ["width"] = 200},
      { ["name"] = "", ["width"] = 70},
      { ["name"] = "", ["width"] = 70},
      { ["name"] = "", ["width"] = 70},
      { ["name"] = "", ["width"] = 50},
      { ["name"] = "", ["width"] = 0}
 };

 local ignoreByKeywordCols = {
      {["name"] = "KeyWord", ["width"] = 200},
      { ["name"] = "", ["width"] = 70},
      { ["name"] = "", ["width"] = 70},
      { ["name"] = "", ["width"] = 70},
      { ["name"] = "", ["width"] = 50},
      { ["name"] = "", ["width"] = 0}
 };

local function IgnoreByWordTabUI()
      local editBox = Gui:Create("EditBox");
      local emptyBox1 = Gui:Create("SimpleGroup");
      local emptyBox2 = Gui:Create("SimpleGroup");
      local emptyBox3 = Gui:Create("SimpleGroup");
      local emptyBox4 = Gui:Create("SimpleGroup");
      local emptyBox5 = Gui:Create("SimpleGroup");
      local emptyBox6 = Gui:Create("SimpleGroup");
      local emptyBox7 = Gui:Create("SimpleGroup");
      local addButton = Gui:Create("Button");
      local removeButton = Gui:Create("Button");
      local removeAllButton = Gui:Create("Button");

      if gridIsHided then
            GridComponent:Show();
      end

      -- Add Word  textBox
      editBox:SetLabel("Insert Keyword to Add:");
      editBox:SetRelativeWidth(0.4);
      editBox:SetCallback("OnEnterPressed", function()
            AddFunctionality(AntiSpam_Database.global.bannedWords,editBox, GridDataIgnoreByKeyWord);
            GridComponent:SetData(GridDataIgnoreByKeyWord, true);
            editBox:SetText("");
      end
      )
      editBox:DisableButton(true);
      widgetList.tabGroup:AddChild(editBox);

      
       emptyBox1:SetRelativeWidth(0.1);
       emptyBox1:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox1);

      emptyBox3:SetRelativeWidth(0.4);
      emptyBox3:SetLayout("Flow");
      widgetList.tabGroup:AddChild(emptyBox3);

       -- Add button
       addButton:SetRelativeWidth(0.2);
       addButton:SetText("Add");
       addButton:SetCallback("OnClick", 
       function()
            AddFunctionality(AntiSpam_Database.global.bannedWords,editBox,GridDataIgnoreByKeyWord);
            GridComponent:SetData(GridDataIgnoreByKeyWord, true);
            editBox:SetText("");
       end);
       widgetList.tabGroup:AddChild(addButton) ;

       
       emptyBox2:SetRelativeWidth(0.8);
       emptyBox2:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox2);
       
       emptyBox4:SetFullWidth(true);
       emptyBox4:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox4);

       emptyBox5:SetFullWidth(true);
       emptyBox5:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox5);
       
       emptyBox6:SetFullWidth(true);
       emptyBox6:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox6);

       
       emptyBox7:SetRelativeWidth(0.6);
       emptyBox7:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox7);


       -- Remove button
       removeButton:SetRelativeWidth(0.2);
       removeButton:SetText("Remove");
       removeButton:SetCallback("OnClick", 
       function()
            local selectedRow = GridComponent:GetSelection();
            if selectedRow ~= nil then
                  table.remove(GridDataIgnoreByKeyWord, GridComponent:GetSelection());
                  table.remove(AntiSpam_Database.global.bannedWords, GridComponent:GetSelection());
                  GridComponent:SetData(GridDataIgnoreByKeyWord, true);
                  GridComponent:ClearSelection();
            end
       end);
       widgetList.tabGroup:AddChild(removeButton);

       removeAllButton:SetRelativeWidth(0.2);
       removeAllButton:SetText("Remove All");
       removeAllButton:SetCallback("OnClick", function ()
            GridDataIgnoreByKeyWord = {}
            AntiSpam_Database.global.bannedWords = {}
            GridComponent:SetData(GridDataIgnoreByKeyWord, true)
       end);
       widgetList.tabGroup:AddChild(removeAllButton);

      GridComponent:SetData(GridDataIgnoreByKeyWord, true);
      GridComponent:SetDisplayCols(ignoreByKeywordCols)
      
end

local function IgnoreByName()
      local editBox = Gui:Create("EditBox");
      local emptyBox1 = Gui:Create("SimpleGroup");
      local emptyBox2 = Gui:Create("SimpleGroup");
      local emptyBox3 = Gui:Create("SimpleGroup");
      local emptyBox4 = Gui:Create("SimpleGroup");
      local emptyBox5 = Gui:Create("SimpleGroup");
      local emptyBox6 = Gui:Create("SimpleGroup");
      local emptyBox7 = Gui:Create("SimpleGroup");
      local addButton = Gui:Create("Button");
      local removeButton = Gui:Create("Button");
      local removeAllButton = Gui:Create("Button");
      
      if gridIsHided then
            GridComponent:Show();
      end

      -- Add Word  textBox
      editBox:SetLabel("Insert Name to Add:");
      editBox:SetRelativeWidth(0.4);
      editBox:SetCallback("OnEnterPressed", function()
            AddFunctionality(AntiSpam_Database.locale.ingoredPlayers,editBox,GridDataIgnoreByName);
            GridComponent:SetData(GridDataIgnoreByName, true);
            if AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayerIsActivated then
                  SendChatMessage(AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayer, "WHISPER", "Common", editBox:GetText())
            end
            editBox:SetText("");
      end
      )
      widgetList.tabGroup:AddChild(editBox);

      
       emptyBox1:SetRelativeWidth(0.1);
       emptyBox1:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox1);

      emptyBox3:SetRelativeWidth(0.4);
      emptyBox3:SetLayout("Flow");
      widgetList.tabGroup:AddChild(emptyBox3);

       -- Add button
       addButton:SetRelativeWidth(0.2);
       addButton:SetText("Add");
       addButton:SetCallback("OnClick",
       function(event,text)
            AddFunctionality(AntiSpam_Database.locale.ingoredPlayers,editBox,GridDataIgnoreByName);
            GridComponent:SetData(GridDataIgnoreByName, true);
            if AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayerIsActivated then
                  SendChatMessage(AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayer, "WHISPER", "Common", editBox:GetText())
            end
            editBox:SetText("");
       end);
       widgetList.tabGroup:AddChild(addButton) ;

       
       emptyBox2:SetRelativeWidth(0.8);
       emptyBox2:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox2);
       
       emptyBox4:SetFullWidth(true);
       emptyBox4:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox4);

       emptyBox5:SetFullWidth(true);
       emptyBox5:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox5);
       
       emptyBox6:SetFullWidth(true);
       emptyBox6:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox6);

       
       emptyBox7:SetRelativeWidth(0.6);
       emptyBox7:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox7);


       -- Remove button
       removeButton:SetRelativeWidth(0.2);
       removeButton:SetText("Remove");
       removeButton:SetCallback("OnClick", 
       function()
              local selectedRow = GridComponent:GetSelection();
              if selectedRow ~= nil then
                  table.remove(GridDataIgnoreByName, selectedRow);
                  table.remove(AntiSpam_Database.locale.ingoredPlayers, GridComponent:GetSelection());
                  GridComponent:SetData(GridDataIgnoreByName, true);
                  GridComponent:ClearSelection();
              end
       end);
       widgetList.tabGroup:AddChild(removeButton);

       removeAllButton:SetRelativeWidth(0.2);
       removeAllButton:SetText("Remove All");
       removeAllButton:SetCallback("OnClick", function ()
            GridDataIgnoreByName = {}
            AntiSpam_Database.locale.ingoredPlayers = {}
            GridComponent:SetData(GridDataIgnoreByName, true)
       end);
       widgetList.tabGroup:AddChild(removeAllButton);

       GridComponent:SetData(GridDataIgnoreByName, true);
       GridComponent:SetDisplayCols(ignoreByNameCols)

end

local function Options()
      gridIsHided = true;
      GridComponent:Hide();

      --GetAllChannels 
      local channels = { }
      local chanList = { GetChannelList() }
      for i=1, #chanList, 3 do
        table.insert(channels, {
            id = chanList[i],
            name = chanList[i+1]
        })
      end

      for index,value in ipairs(channels) do
            channelsList[value.name] = value.name;
      end
      

      --Init  Widgets 
       local replyMessageEditBox = Gui:Create("EditBox");
       local replyMessageOptionIsEnabled = Gui:Create("CheckBox");
       local messageToSendWhenIgnorePlayer = Gui:Create("EditBox");
       local messageToSendWhenIgnorePlayerIsActivated = Gui:Create("CheckBox");
       local emptyBox1 = Gui:Create("SimpleGroup");
       local emptyRow = Gui:Create("SimpleGroup");
       local emptyRow2 = Gui:Create("SimpleGroup");
       local emptyRow3 = Gui:Create("SimpleGroup");
       local emptyRow4 = Gui:Create("SimpleGroup");
       local emptyRow5 = Gui:Create("SimpleGroup");
       local emptyRow6 = Gui:Create("SimpleGroup");
       local chatSelectDropDown = Gui:Create("Dropdown");
       local channelSelectDropDown = Gui:Create("Dropdown");
       local disableChannelDropDown = true;

      --replyMessageEditBox
      replyMessageEditBox:SetLabel("Set the reply message.");
      replyMessageEditBox:SetDisabled(not AntiSpam_Database.locale.Options.replyMessageIsActivated);
      if not AntiSpam_Database.locale.Options.replyMessageIsActivated then
            replyMessageEditBox:SetText("Disabled");
      else
            replyMessageEditBox:SetText(AntiSpam_Database.locale.Options.replyMessage);
      end
      
      replyMessageEditBox:SetCallback("OnEnterPressed", function()
            AntiSpam_Database.locale.Options.replyMessage = replyMessageEditBox:GetText();
      end)
      widgetList.tabGroup:AddChild(replyMessageEditBox);

      --replyMessageCheckBox
      replyMessageOptionIsEnabled:SetValue(AntiSpam_Database.locale.Options.replyMessageIsActivated);
      replyMessageOptionIsEnabled:SetType("checkbox");
      replyMessageOptionIsEnabled:SetLabel("Reply message");
      replyMessageOptionIsEnabled:SetCallback("OnEnter", function() 
            replyMessageOptionIsEnabled:SetDescription("Reply message for ignored players");
      end)
      replyMessageOptionIsEnabled:SetCallback("OnLeave", function() 
            replyMessageOptionIsEnabled:SetDescription("");
      end)
      replyMessageOptionIsEnabled:SetCallback("OnValueChanged", function()
            AntiSpam_Database.locale.Options.replyMessageIsActivated = replyMessageOptionIsEnabled:GetValue();
            if AntiSpam_Database.locale.Options.replyMessageIsActivated then
                  replyMessageEditBox:SetText(AntiSpam_Database.locale.Options.replyMessage);
            else
                  replyMessageEditBox:SetText("Disabled");
            end
            replyMessageEditBox:SetDisabled(not AntiSpam_Database.locale.Options.replyMessageIsActivated);
      end)
      widgetList.tabGroup:AddChild(replyMessageOptionIsEnabled);

      --emptyBox
      emptyBox1:SetRelativeWidth(0.1);
       emptyBox1:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyBox1);

      --messageToSendWhenIgnorePlayer
      messageToSendWhenIgnorePlayer:SetLabel("Set message.");
      messageToSendWhenIgnorePlayer:SetDisabled(not AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayerIsActivated);
      if not AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayerIsActivated then
            messageToSendWhenIgnorePlayer:SetText("Disabled");
      else
            messageToSendWhenIgnorePlayer:SetText(AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayer);
      end
      
      messageToSendWhenIgnorePlayer:SetCallback("OnEnterPressed", function()
            AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayer = messageToSendWhenIgnorePlayer:GetText();
      end)
      widgetList.tabGroup:AddChild(messageToSendWhenIgnorePlayer);



      --messageToSendWhenIgnorePlayerIsActivated CheckBox
      messageToSendWhenIgnorePlayerIsActivated:SetValue(AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayerIsActivated);
      messageToSendWhenIgnorePlayerIsActivated:SetType("checkbox");
      messageToSendWhenIgnorePlayerIsActivated:SetLabel("Send message at ignore");
      messageToSendWhenIgnorePlayerIsActivated:SetCallback("OnEnter", function() 
            messageToSendWhenIgnorePlayerIsActivated:SetDescription("When you insert a player on ignore list send automaticaly a message");
      end)
      messageToSendWhenIgnorePlayerIsActivated:SetCallback("OnLeave", function() 
            messageToSendWhenIgnorePlayerIsActivated:SetDescription("");
      end)
      messageToSendWhenIgnorePlayerIsActivated:SetCallback("OnValueChanged", function()
            AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayerIsActivated = messageToSendWhenIgnorePlayerIsActivated:GetValue();
            if AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayerIsActivated then
                  messageToSendWhenIgnorePlayer:SetText(AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayer);
            else
                  messageToSendWhenIgnorePlayer:SetText("Disabled");
            end
            messageToSendWhenIgnorePlayer:SetDisabled(not AntiSpam_Database.locale.Options.messageToSendWhenIgnorePlayerIsActivated);
      end)
      widgetList.tabGroup:AddChild(messageToSendWhenIgnorePlayerIsActivated);

      emptyRow2:SetRelativeWidth(1.0)
       emptyRow2:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyRow2);

       emptyRow3:SetRelativeWidth(1.0)
       emptyRow3:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyRow3);

       emptyRow:SetRelativeWidth(1.0)
       emptyRow:SetLayout("Flow");
       widgetList.tabGroup:AddChild(emptyRow);


       --Chat select DropDown
       chatSelectDropDown:SetList(chatList);
       chatSelectDropDown:SetMultiselect(true);
       chatSelectDropDown:SetLabel("Chat types");
       --Set selected items
       if table.getn(AntiSpam_Database.locale.Options.selectedChatsForFiltering) > 0 then
            for index,value in ipairs(AntiSpam_Database.locale.Options.selectedChatsForFiltering) do
                  if value == "CHAT_MSG_CHANNEL" then
                        disableChannelDropDown = false;
                  end
                  chatSelectDropDown:SetItemValue(value, true);
            end
       end
       chatSelectDropDown:SetCallback("OnValueChanged", function(self, event,key, checked)

            if checked then
                  local setTextForChannelSelect;
                  if key == "CHAT_MSG_CHANNEL" then
                        channelSelectDropDown:SetDisabled(false);
                        for index,value in ipairs(AntiSpam_Database.locale.Options.selectedChannelsForFiltering) do
                              if index == 1 then
                                    setTextForChannelSelect = value;
                              else
                                    setTextForChannelSelect = setTextForChannelSelect ..", " .. value;
                              end
                        end

                        channelSelectDropDown:SetText(setTextForChannelSelect);
                  end
                  table.insert(AntiSpam_Database.locale.Options.selectedChatsForFiltering, key);
            else
                  if key == "CHAT_MSG_CHANNEL"  then
                        channelSelectDropDown:SetDisabled(true);
                        channelSelectDropDown:SetText("Disabled");
                  end
                  for index,value in ipairs(AntiSpam_Database.locale.Options.selectedChatsForFiltering) do
                        if value == key then
                              table.remove(AntiSpam_Database.locale.Options.selectedChatsForFiltering, index);
                        end
                  end
            end
       end)
       widgetList.tabGroup:AddChild(chatSelectDropDown);

       --channels list
       channelSelectDropDown:SetList(channelsList)
       channelSelectDropDown:SetMultiselect(true);
       channelSelectDropDown:SetLabel("Channels");
       channelSelectDropDown:SetDisabled(disableChannelDropDown);
       -- set selected items
       if table.getn(AntiSpam_Database.locale.Options.selectedChannelsForFiltering) > 0 then
            for index,value in ipairs(AntiSpam_Database.locale.Options.selectedChannelsForFiltering) do
                  channelSelectDropDown:SetItemValue(value, true);
            end
       end
       channelSelectDropDown:SetCallback("OnValueChanged", function(self, event,key, checked)
            if checked then
                  table.insert(AntiSpam_Database.locale.Options.selectedChannelsForFiltering, key);
            else
                  for index,value in ipairs(AntiSpam_Database.locale.Options.selectedChannelsForFiltering) do
                        if value == key then
                              table.remove(AntiSpam_Database.locale.Options.selectedChannelsForFiltering, index);
                        end
                  end
            end
       end)
       if disableChannelDropDown then
            channelSelectDropDown:SetText("Disabled");
       end
       widgetList.tabGroup:AddChild(channelSelectDropDown);
end

local function OnTabClick(container,event,group)
      widgetList.tabGroup:ReleaseChildren();

      if group == "IGNORE_BY_NAME" then
            IgnoreByName();
      elseif group == "IGNORE_BY_KEYWORD" then
            IgnoreByWordTabUI();
      elseif group == "OPTIONS" then
            Options();
      end
end   

function AntiSpam_Gui:ShowGui()
      --Init Widggets
      local frame = Gui:Create("Frame");
      local tabGroup = Gui:Create("TabGroup");
      if not GridInitialized then
            local ignoreGrid = Grid:CreateST(ignoreByKeywordCols, nil, nil, nil, tabGroup.frame);
            GridComponent = ignoreGrid;
            for index,value in ipairs(AntiSpam_Database.global.bannedWords) do
                  table.insert(GridDataIgnoreByKeyWord,{value});
            end
            for index,value in ipairs(AntiSpam_Database.locale.ingoredPlayers) do
                  table.insert(GridDataIgnoreByName,{value});
            end

            GridInitialized = true;
      end
      
      GridInitialized = true;
      widgetList.tabGroup = tabGroup;
      GridComponent = GridComponent;
      
      --Frame
       frame:SetCallback("OnClose",
       function(widget) 
            Gui:Release(widget)
            IsUiOpened = false;
       end)
       frame:SetTitle("AntiSpam");
       frame:SetStatusText("AntiSpam-1.3");
       frame:SetWidth(550);
       frame:SetHeight(530);
       frame:SetLayout("Flow");
       frame:EnableResize(false);

       tabGroup:SetTabs(tabs);
       tabGroup:SelectTab("IGNORE_BY_KEYWORD");
       tabGroup:SetLayout("Flow");
       tabGroup:SetWidth(550);
       tabGroup:SetFullHeight(true);
       tabGroup:SetCallback("OnGroupSelected",OnTabClick);
       frame:AddChild(tabGroup);

       GridComponent:EnableSelection(true);
       
       IgnoreByWordTabUI();
 end
 
function AddFunctionality(dbTable, editBox, gridData)
      local tableLength = table.getn(dbTable);
      if editBox:GetText() ~= nil and editBox:GetText() ~= "" then
         if tableLength > 0 then
            local insertNewRow = true;

            for index, value in ipairs(dbTable) do
                  if value:lower() == editBox:GetText():lower() then
                        insertNewRow = false;
                        return
                  end 
            end

            if insertNewRow then
                  local bannedWord = editBox:GetText();
                  table.insert(dbTable,bannedWord);
                  table.insert(gridData, {bannedWord});
            end
         else
            table.insert(dbTable, 1, editBox:GetText());
            table.insert(gridData, 1, {editBox:GetText()});
         end 
      end
      
 end


