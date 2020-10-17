Gui = LibStub("AceGUI-3.0")
Grid = LibStub("ScrollingTable")

AntiSpam_Gui = {};

local tabs={
      "IGNORE_BY_KEYWORD",
      "IGNORE_BY_NAME"
    };

local widgetList = {tabGroup = {}};

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

      -- Add Word  textBox
      editBox:SetLabel("Insert Keyword to Add:");
      editBox:SetRelativeWidth(0.4);
      editBox:SetCallback("OnEnterPressed", function()
            AddFunctionality(AntiSpam_Database.locale.ingoredPlayers,editBox,GridDataIgnoreByName);
            GridComponent:SetData(GridDataIgnoreByName, true);
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
      

      -- Add Word  textBox
      editBox:SetLabel("Insert Name to Add:");
      editBox:SetRelativeWidth(0.4);
      editBox:SetCallback("OnEnterPressed", function()
            AddFunctionality(AntiSpam_Database.locale.ingoredPlayers,editBox,GridDataIgnoreByName);
            GridComponent:SetData(GridDataIgnoreByName, true);
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

local function OnTabClick(container,event,group)
      widgetList.tabGroup:ReleaseChildren();
      
      if group == "IGNORE_BY_NAME" then
            IgnoreByName();
      elseif group == "IGNORE_BY_KEYWORD" then
            IgnoreByWordTabUI();
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
      
      --Init Tabs
      local tabs = {{value = "IGNORE_BY_KEYWORD", text = "Ignore by keyword"},{value = "IGNORE_BY_NAME", text = "Ignore by character name"}};

      --Frame
       frame:SetCallback("OnClose",
       function(widget) 
            Gui:Release(widget)
            IsUiOpened = false;
       end)
       frame:SetTitle("AntiSpam");
       frame:SetStatusText("AntiSpam-1.2");
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


