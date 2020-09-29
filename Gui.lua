Gui = LibStub("AceGUI-3.0")

AntiSpam_Gui = {}

function AntiSpam_Gui:ShowGui()
      --Init Widggets
      local frame = Gui:Create("Frame")
      local FirstGroup = Gui:Create("SimpleGroup")
      local editBox = Gui:Create("EditBox")
      local emptyBox2 = Gui:Create("SimpleGroup")
      local removeWordEditBox = Gui:Create("EditBox")
      local multiLineEditBox = Gui:Create("MultiLineEditBox")
      local addButton = Gui:Create("Button")
      local emptyBox3 = Gui:Create("SimpleGroup")
      local removeButton = Gui:Create("Button")
      local removeAllButton = Gui:Create("Button")
      --InitWidgets

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
       frame:SetLayout("Flow")
       frame:EnableResize(false)

      -- FirstGroup
      FirstGroup:SetRelativeWidth(1)
      FirstGroup:SetHeight(700)
      FirstGroup:SetLayout("Flow")
      frame:AddChild(FirstGroup)

       -- Add Word  textBox
      editBox:SetLabel("Insert Word To Add:")
      editBox:SetRelativeWidth(0.4)
      editBox:DisableButton(true)
      FirstGroup:AddChild(editBox)

      
       emptyBox2:SetRelativeWidth(0.1)
       emptyBox2:SetLayout("Flow")
       FirstGroup:AddChild(emptyBox2)

      -- Remove Word TextBox
      removeWordEditBox:SetLabel("Insert Word To Remove:")
      removeWordEditBox:SetRelativeWidth(0.4)
      removeWordEditBox:DisableButton(true)
      FirstGroup:AddChild(removeWordEditBox)
      
       
       emptyBox3:SetRelativeWidth(0.1)
       FirstGroup:AddChild(emptyBox3)

       -- Add button
       addButton:SetRelativeWidth(0.3)
       addButton:SetText("Add")
       addButton:SetCallback("OnClick", 
       function()
            AddWordFunctionality(editBox, multiLineEditBox)
            editBox:SetText("")
       end)
       FirstGroup:AddChild(addButton) 

       local emptyBox4 = Gui:Create("SimpleGroup")
       emptyBox4:SetRelativeWidth(0.2)
       emptyBox4:SetLayout("Flow")
       FirstGroup:AddChild(emptyBox4)

       -- Remove button
       removeButton:SetRelativeWidth(0.2)
       removeButton:SetText("Remove")
       removeButton:SetCallback("OnClick", 
       function() 
            RemoveWordFunctionality(removeWordEditBox, multiLineEditBox)
       end)
       FirstGroup:AddChild(removeButton) 

      --  local emptyBox5 = Gui:Create("SimpleGroup")
      --  emptyBox5:SetRelativeWidth(0.05)
      --  FirstGroup:AddChild(emptyBox5)

       removeAllButton:SetRelativeWidth(0.2)
       removeAllButton:SetText("Remove All")
       removeAllButton:SetCallback("OnClick", function ()
            RemoveAllFunctionality(multiLineEditBox)
       end)
       FirstGroup:AddChild(removeAllButton)

       -- List of words
       multiLineEditBox:SetLabel("Banned Words")
       multiLineEditBox:SetFullWidth(true)
       multiLineEditBox:SetNumLines(20)
       multiLineEditBox:DisableButton(true)
       multiLineEditBox:SetDisabled(true)
       multiLineEditBox:SetText(table.concat(AntiSpam_Database.global.bannedWords, ','))
       FirstGroup:AddChild(multiLineEditBox)

 end
 
function AddWordFunctionality(editBox, multiLineEditBox)
      local tableLength = table.getn(AntiSpam_Database.global.bannedWords)
      if editBox:GetText() ~= nil and (editBox:GetText() ~= "" and tableLength > 0)then
                        
            local insertNewRow = true

            for index, value in ipairs(AntiSpam_Database.global.bannedWords) do
                  if value:lower() == editBox:GetText():lower() then
                        insertNewRow = false
                        return
                  end 
            end

            if insertNewRow then
                  local bannedWord = editBox:GetText()
                  table.insert(AntiSpam_Database.global.bannedWords, bannedWord)
                  multiLineEditBox:SetText(table.concat(AntiSpam_Database.global.bannedWords, ','))
                  editBox:SetText("")
            end
      else  
            table.insert(AntiSpam_Database.global.bannedWords, 1, editBox:GetText())
            multiLineEditBox:SetText(table.concat(AntiSpam_Database.global.bannedWords, ','))
      end
 end

 function RemoveWordFunctionality(widget, multiLineEditBox)

      local tableLength = table.getn(AntiSpam_Database.global.bannedWords)

      if widget:GetText() ~= nil and (widget:GetText() ~= "" and tableLength > 0) then

            for i=1, tableLength do
                  if AntiSpam_Database.global.bannedWords[i]:lower() == widget:GetText():lower() then
                        table.remove(AntiSpam_Database.global.bannedWords, i)
                        break
                  end 
            end

            multiLineEditBox:SetText(table.concat(AntiSpam_Database.global.bannedWords, ','))
            widget:SetText("")
            
            MessageRemove = widget:GetText():lower()
      end
 end

function RemoveAllFunctionality(multiLineEditBox)
      if table.getn(AntiSpam_Database.global.bannedWords) > 0 then
            AntiSpam_Database.global.bannedWords = {}
            multiLineEditBox:SetText(table.concat(AntiSpam_Database.global.bannedWords, ','))
      end
end