--[[

Licence by WTFPL

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                   Version 2, December 2004

Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO.

]]

-- 照葫芦画瓢，出什么BUG都不意外
-- copy & paste makes BUG contributor

local tr = aegisub.gettext -- idk the meaning, just copy...

-- just simply modified. see: https://aegi.vmoe.info/docs/3.2/Automation/Lua/Registration/
script_name = tr"Dual Colorize"
script_description = tr"Dual colorize subtitles"
script_author = "U5ER-N4ME"
script_version = "0.2"

-- use aegisub.unicode. see: https://aegi.vmoe.info/docs/3.2/Automation/Lua/Modules/unicode/
unicode = require 'aegisub.unicode'

--[[
	function
	@name: dual_colarizes
	@note: copied & modified from macro-1-edgeblur.lua
]]
function dual_colorize(subtitles, selected_lines, active_line)

	for z, i in ipairs(selected_lines) do
		-- idk why, just copy & modify till works
		local l = subtitles[i]
		local m = subtitles[i]
		m.text = ""

		local colorFlag = 0 -- mark for colors
		local braceFlag = 0 -- mark for braces: 1 when within brace 
							-- (since only one pair of brace can be accepted in aegisub, nested condition is not considered)

		--[[
			Procedure: 
			within brace ? 
			 - No(0):	Is this a brace ? 
						 - No:  do! 
						 - Yes: flag... and keep it
			 - Yes(1): 	keep it, and do nothing until find its ending
				
		]]
		for char in unicode.chars(l.text) do -- aegisub.unicode, for each character
			if braceFlag == 0 then
				-- not within a pair of brace
				if char ~= '{' then
					-- do!
					-- if bg required, add \\4cH954F4D for background
					if colorFlag == 0 then
						m.text = m.text .. "{\\c&HD6C7F3&}" .. char -- pink
						colorFlag = 1
					else
						m.text = m.text .. "{\\c&HFBE0D3&}" .. char -- blue
						colorFlag = 0
					end -- end if colorFlag == 0
				else
					m.text = m.text .. char
					braceFlag = 1
				end -- end if char ~= '{'
			else
				-- within a pair of brace
				m.text = m.text .. char
				if char == '}' then
					braceFlag = 0
				end -- end if char == '}'
			end -- end if braceFlag == 0
		end -- end for
		subtitles[i] = m -- return to subtitles
	end -- end for
	aegisub.set_undo_point(script_name) -- allow undo (I guess...)
end -- end func

-- reg macro to aegisub
aegisub.register_macro(script_name, script_description, dual_colorize)