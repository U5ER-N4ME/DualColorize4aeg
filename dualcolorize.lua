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
		local input = subtitles[i]
		local output = subtitles[i]
		output.text = ""

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
		for character in unicode.chars(input.text) do -- aegisub.unicode, for each character
			if braceFlag == 0 then
				-- not within a pair of brace
				if character ~= '{' then
					-- do!
					-- if bg required, add \\4cH954F4D for background
					if colorFlag == 0 then
						output.text = output.text .. "{\\c&HD6C7F3&}" .. character -- pink
						colorFlag = 1
					else
						output.text = output.text .. "{\\c&HFBE0D3&}" .. character -- blue
						colorFlag = 0
					end -- end if colorFlag == 0
				else
					output.text = output.text .. character
					braceFlag = 1
				end -- end if character ~= '{'
			else
				-- within a pair of brace
				output.text = output.text .. character
				if character == '}' then
					braceFlag = 0
				end -- end if character == '}'
			end -- end if braceFlag == 0
		end -- end for
		subtitles[i] = output -- return to subtitles
	end -- end for
	aegisub.set_undo_point(script_name) -- allow undo (I guess...)
end -- end func

-- reg macro to aegisub
aegisub.register_macro(script_name, script_description, dual_colorize)