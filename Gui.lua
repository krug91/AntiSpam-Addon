Gui = LibStub("AceGUI-3.0")

AntiSpam_Gui = {}

local tabs={
      "IGNORE_BY_KEYWORD",
      "IGNORE_BY_NAME"
    }

local widgetList = {tabGroup = {}}

local function IgnoreByWordTabUI()
      local editBox = Gui:Create("EditBox")
      local emptyBox1 = Gui:Create("SimpleGroup")
      local removeWordEditBox = Gui:Create("EditBox")
      local multiLineEditBox = Gui:Create("MultiLineEditBox")
      local addButton = Gui:Create("Button")
      local removeButton = Gui:Create("Button")
      local removeAllButton = Gui:Create("Button")
      local emptyBox2 = Gui:Create("SimpleGroup")

      -- Add Word  textBox
      editBox:SetLabel("Insert Word To Add:")
      editBox:SetRelativeWidth(0.4)
      editBox:DisableButton(true)
      widgetList.tabGroup:AddChild(editBox)

      
       emptyBox1:SetRelativeWidth(0.1)
       emptyBox1:SetLayout("Flow")
       widgetList.tabGroup:AddChild(emptyBox1)

      -- Remove Word TextBox
      removeWordEditBox:SetLabel("Insert Word To Remove:")
      removeWordEditBox:SetRelativeWidth(0.4)
      removeWordEditBox:DisableButton(true)
      widgetList.tabGroup:AddChild(removeWordEditBox)

       -- Add button
       addButton:SetRelativeWidth(0.3)
       addButton:SetText("Add")
       addButton:SetCallback("OnClick", 
       function()
            AddFunctionality(AntiSpam_Database.global.bannedWords,editBox, multiLineEditBox)
            editBox:SetText("")
       end)
       widgetList.tabGroup:AddChild(addButton) 

       
       emptyBox2:SetRelativeWidth(0.2)
       emptyBox2:SetLayout("Flow")
       widgetList.tabGroup:AddChild(emptyBox2)

       -- Remove button
       removeButton:SetRelativeWidth(0.2)
       removeButton:SetText("Remove")
       removeButton:SetCallback("OnClick", 
       function() 
            RemoveFunctionality(AntiSpam_Database.global.bannedWords,removeWordEditBox, multiLineEditBox)
       end)
       widgetList.tabGroup:AddChild(removeButton) 

       removeAllButton:SetRelativeWidth(0.2)
       removeAllButton:SetText("Remove All")
       removeAllButton:SetCallback("OnClick", function ()
            RemoveAllFunctionality(AntiSpam_Database.global.bannedWords,multiLineEditBox)
       end)
       widgetList.tabGroup:AddChild(removeAllButton)

       -- List of words
       multiLineEditBox:SetLabel("Banned Words")
       multiLineEditBox:SetFullWidth(true)
       multiLineEditBox:SetNumLines(20)
       multiLineEditBox:DisableButton(true)
       multiLineEditBox:SetDisabled(true)
       multiLineEditBox:SetText(table.concat(AntiSpam_Database.global.bannedWords, ','))
       widgetList.tabGroup:AddChild(multiLineEditBox)
end

local function IgnoreByName()
      local editBox = Gui:Create("EditBox")
      local emptyBox1 = Gui:Create("SimpleGroup")
      local removeWordEditBox = Gui:Create("EditBox")
      local multiLineEditBox = Gui:Create("MultiLineEditBox")
      local addButton = Gui:Create("Button")
      local removeButton = Gui:Create("Button")
      local removeAllButton = Gui:Create("Button")
      local emptyBox2 = Gui:Create("SimpleGroup")

      -- Add Word  textBox
      editBox:SetLabel("Insert Name to Add:")
      editBox:SetRelativeWidth(0.4)
      editBox:DisableButton(true)
      widgetList.tabGroup:AddChild(editBox)

      
       emptyBox1:SetRelativeWidth(0.1)
       emptyBox1:SetLayout("Flow")
       widgetList.tabGroup:AddChild(emptyBox1)

      -- Remove Word TextBox
      removeWordEditBox:SetLabel("Insert Name To Remove:")
      removeWordEditBox:SetRelativeWidth(0.4)
      removeWordEditBox:DisableButton(true)
      widgetList.tabGroup:AddChild(removeWordEditBox)

       -- Add button
       addButton:SetRelativeWidth(0.3)
       addButton:SetText("Add")
       addButton:SetCallback("OnClick", 
       function()
            AddFunctionality(AntiSpam_Database.locale.ingoredPlayers,editBox, multiLineEditBox)
            editBox:SetText("")
       end)
       widgetList.tabGroup:AddChild(addButton) 

       
       emptyBox2:SetRelativeWidth(0.2)
       emptyBox2:SetLayout("Flow")
       widgetList.tabGroup:AddChild(emptyBox2)

       -- Remove button
       removeButton:SetRelativeWidth(0.2)
       removeButton:SetText("Remove")
       removeButton:SetCallback("OnClick", 
       function() 
            RemoveFunctionality(AntiSpam_Database.locale.ingoredPlayers, removeWordEditBox, multiLineEditBox)
       end)
       widgetList.tabGroup:AddChild(removeButton) 

       removeAllButton:SetRelativeWidth(0.2)
       removeAllButton:SetText("Remove All")
       removeAllButton:SetCallback("OnClick", function ()
            RemoveAllFunctionality(AntiSpam_Database.locale.ingoredPlayers,multiLineEditBox)
       end)
       widgetList.tabGroup:AddChild(removeAllButton)

       -- List of words
       multiLineEditBox:SetLabel("Ignore List")
       multiLineEditBox:SetFullWidth(true)
       multiLineEditBox:SetNumLines(20)
       multiLineEditBox:DisableButton(true)
       multiLineEditBox:SetDisabled(true)
       multiLineEditBox:SetText(table.concat(AntiSpam_Database.locale.ingoredPlayers, ','))
       widgetList.tabGroup:AddChild(multiLineEditBox)
end

local function OnTabClick(container,event,group)
      widgetList.tabGroup:ReleaseChildren()
      
      if group == "IGNORE_BY_NAME" then
            IgnoreByName()
      elseif group == "IGNORE_BY_KEYWORD" then
            IgnoreByWordTabUI()
      end
end
     
function AntiSpam_Gui:ShowGui()
      --Init Widggets
      local frame = Gui:Create("Frame")
      local tabGroup = Gui:Create("TabGroup")
      widgetList.tabGroup = tabGroup
      --InitWidgets
      local tabs = {{value = "IGNORE_BY_KEYWORD", text = "Ignore by keyword"},{value = "IGNORE_BY_NAME", text = "Ignore by character name"}}

      --Frame

       frame:SetCallback("OnClose",
       function(widget) 
            -- frame:ReleaseChildren()
            Gui:Release(widget)
            IsUiOpened = false
       end)
       frame:SetTitle("AntiSpam")
       frame:SetStatusText("AntiSpam-0.1")
       frame:SetWidth(550)
       frame:SetHeight(530)
       frame:SetLayout("Flow")
       frame:EnableResize(false)

       tabGroup:SetTabs(tabs)
       tabGroup:SelectTab("IGNORE_BY_KEYWORD")
       tabGroup:SetLayout("Flow")
       tabGroup:SetWidth(550)
       tabGroup:SetHeight(200)
       tabGroup:SetCallback("OnGroupSelected",OnTabClick)
       frame:AddChild(tabGroup)
      
       IgnoreByWordTabUI(tabGroup)
      
 end
 
function AddFunctionality(dbTable, editBox, multiLineEditBox)
      local tableLength = table.getn(dbTable)
      if editBox:GetText() ~= nil and editBox:GetText() ~= "" then
         if tableLength > 0 then
            local insertNewRow = true

            for index, value in ipairs(dbTable) do
                  if value:lower() == editBox:GetText():lower() then
                        insertNewRow = false
                        return
                  end 
            end

            if insertNewRow then
                  local bannedWord = editBox:GetText()
                  table.insert(dbTable,bannedWord)
                  multiLineEditBox:SetText(table.concat(dbTable, ','))
                  editBox:SetText("")
            end
         else
            table.insert(dbTable, 1, editBox:GetText())
            multiLineEditBox:SetText(table.concat(dbTable, ','))
         end 
      
      end
      
 end

 function RemoveFunctionality(dbTable,widget, multiLineEditBox)
      local tableLength = table.getn(dbTable)
      if widget:GetText() ~= nil and (widget:GetText() ~= "" and tableLength > 0) then
            for i=1, tableLength do
                  if dbTable[i]:lower() == widget:GetText():lower() then
                        table.remove(dbTable, i)
                        break
                  end 
            end

            multiLineEditBox:SetText(table.concat(dbTable, ','))
            widget:SetText("")
      end
 end

function RemoveAllFunctionality(dbTable,multiLineEditBox)
      if table.getn(dbTable) > 0 then
            for index,value in ipairs(dbTable) do
                  table.remove(dbTable,index)
            end
            multiLineEditBox:SetText(table.concat(dbTable, ','))
      end
end

