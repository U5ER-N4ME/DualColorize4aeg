# DualColorize4aeg

## How to use

1.  Download "dualcolorize.lua"

    下载“dualcolorize.lua”

2.  Copy it to your aegisub automation menu 

    把它复制到aegisub自动化目录
    
        C:\\ProgramsFiles(x86)\Aegisub\automation\autoload for windows
        
        /Applications/Aegisub.app/Contents/SharedSupport/automation/autoload for mac
        
    Alternatively, in aegisub, click automation -> automation.. -> add, select the file
    
    也可以在aegisub中点击自动化->自动化..->添加，然后选择该文件
    
3.  In aegisub, select rows and click automation -> Dual Colorize
    
    在aegisub中选定行，点击自动化->Dual Colorize
    
4.  If you want to change colors, modify lines 68 and 71

    如果想要更改颜色，请修改第68行和第71行

## Notes

Support brace pairs determination now, but problems occur when single brace appear

目前已支持成对大括号判定，但单个大括号会导致问题

Todo: slash determination (\h, \n, \N)

Todo：斜杠判定（\h、\n、\N）

## BUGs?

Send pull requests, please. Thanks. If you just tell me there's a BUG, I may fail to solve because my Google Oriented Programming. Frankly speaking, I don't know lua at all :(

请发pull requests，毕竟《面向谷歌编程》，我也不懂lua
