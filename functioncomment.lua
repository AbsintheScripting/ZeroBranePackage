local params = "-- @param "
local returns = "-- @return "

return {
  name = "Auto-insertion of function comments",
  description = [[Type --- to add a function comment with @params and @return]],
  author = "Migos",
  version = 0.1,

  onEditorCharAdded = function(self, editor, event)
    local keycode = event:GetKey()
    local char = string.char(keycode)
    local curpos = editor:GetCurrentPos()
    local line = editor:GetCurLine()
    local curline = editor:GetCurrentLine()
    if curline == editor:GetLineCount() then return; end; -- check if this is the last line
    local lineafter = editor:GetLine(curline+1)
    
    -- entered "---" and the line below is a function
    if char == '-' and line:match("%-%-%-") and lineafter:find("function") then
        -- build comment
        local comment = " "
        -- get name
        comment = comment .. lineafter:match("function (%w+)%s*%(") .. " \n-- \n"
        -- get params
        for p in string.gmatch(lineafter:match("%((.*)%)"), "%a+") do
            comment = comment .. params .. p .. "\n"
        end
        -- TODO: get return
        
        comment = comment .. returns
        editor:InsertText(-1, comment)
    end
  end,
}