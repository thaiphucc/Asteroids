local love=require "love"
--[[
    PARAMETERS:
    -> text: string - text to be displayed (required)
    -> x: number - x position of text (required)
    -> y: number - y position of text (required)
    -> font_size: string (optional)
        default: "p"
        options: "h1"-"h6", "p"
    -> fade_in: boolean - Should text fade in (optional)
        default: false
    -> fade_out: boolean - Should text fade in (optional)
        default: false
    -> wrap_width: number - Whe should text break (optional)
        default: love.graphics.getWidth() [window width]
    -> align: string - Align text to location (optional)
    -> opacity: number (optional)
        default: 1
        options: 0.1 - 1
        NB: Setting fade_in = true will overwrite this to 0.1
 ]]
function Text(text,x,y,fontSize,fadeIn,fadeOut,wrapWidth,align,opacity)
    fontSize=fontSize or "p"
    fadeIn=fadeIn or false
    fadeOut=fadeOut or false
    wrapWidth=wrapWidth or love.graphics.getWidth()
    align=align or "left"
    opacity=opacity or 1
    local FADE_DUR=5
    local fonts=
    {
        h1=love.graphics.newFont(60),
        h2=love.graphics.newFont(50),
        h3=love.graphics.newFont(40),
        h4=love.graphics.newFont(30),
        h5=love.graphics.newFont(20),
        h6=love.graphics.newFont(10),
        p=love.graphics.newFont(16)
    }
    if fadeIn then
        opacity = 0.1 -- if should fade in, then start at low opacity
    end
    
    return 
    {
        colors = {
            r = 1,
            g = 1,
            b = 1
        },
        text=text,
        x=x,
        y=y,
        opacity=opacity,
        setColor=function(self,red,green,blue)
            self.colors.b=blue--what if i just do colors.b without self?
            --the answer is, if i got a global variable elsewhere in my code, it will refer to that global one, not the local,
            --but using colors.b in this circumstances still be correct
            self.colors.r=red
            self.colors.g=green
            
        end,
        draw=function(self,tbl_text,index)
            if self.opacity >0 then
                love.graphics.setColor(self.colors.r,self.colors.g,self.colors.b,self.opacity)
                love.graphics.setFont(fonts[fontSize])
                love.graphics.printf(self.text,self.x,self.y,wrapWidth,align)--printf allows us to modify more. Thus, it is more powerful than print (maybe?)
                love.graphics.setFont(fonts["p"])
            else 
                table.remove(tbl_text,index)
                return false --there's nothing left to draw
            end
            return true
        end
        }
end
return Text