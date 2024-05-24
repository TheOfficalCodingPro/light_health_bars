---@class LightOverworldActionBox : Object
---@overload fun(...) : LightOverworldActionBox
local LightOverworldActionBox, super = Class(Object)

function LightOverworldActionBox:init(x, y, index, chara)
    super.init(self, x, y)
    self.style = Kristal.getLibConfig("light_health_bars", "light_health_bar_style")
    if self.style == ((not "deltatraveler") or (not "tsunderswap")) then
        self.style = "deltatraveler"
    end

    self.index = index
    self.chara = chara

    self.main_font = Assets.getFont("small")

    self.selected = false
end

function LightOverworldActionBox:update()
    super.update(self)
end

function LightOverworldActionBox:draw()
    if self.style == "deltatraveler" then
        self.offset = -40
        self.name_offset = -40
        self.text_offset = -12
        self.healthbar_x = self.offset + 108
        self.healthbar_y = 20

        Draw.setColor(self.chara:getColor())
        love.graphics.rectangle("fill", 0, 0, 180, 50)

        Draw.setColor(PALETTE["world_fill"])
        love.graphics.rectangle("fill", 5, 5, 170, 40)

        Draw.setColor(COLORS["red"])
        love.graphics.rectangle("fill", self.healthbar_x, self.healthbar_y, 40, 9)

        local health = (self.chara:getHealth() / self.chara:getStat("health")) * 40

        if health > 0 then
            Draw.setColor(COLORS["yellow"])
            love.graphics.rectangle("fill", self.healthbar_x, self.healthbar_y, math.ceil(health), 9)
        end

        local color = PALETTE["action_health_text"]
        if health <= 0 then
            color = PALETTE["action_health_text_down"]
        elseif (self.chara:getHealth() <= (self.chara:getStat("health") / 4)) then
            color = PALETTE["action_health_text_low"]
        else
            color = PALETTE["action_health_text"]
        end

        local health_offset = 0
        health_offset = (#tostring(self.chara:getHealth()) - 1) * 8

        Draw.setColor(color)
        love.graphics.setFont(self.main_font)
        love.graphics.print(self.chara:getHealth(), self.text_offset + 132 - health_offset, 20)
        Draw.setColor(PALETTE["action_health_text"])
        love.graphics.print("/", self.text_offset + 151, 20)
        local string_width = self.main_font:getWidth(tostring(self.chara:getStat("health")))
        Draw.setColor(color)
        love.graphics.print(self.chara:getStat("health"), self.text_offset + 185 - string_width, 20)

        local font = self.main_font
        love.graphics.setFont(font)
        Draw.setColor(1, 1, 1, 1)

        local name = self.chara:getName():upper()
        local spacing = 5 - name:len()

        local off = 0
        for i = 1, name:len() do
            local letter = name:sub(i, i)
            love.graphics.print(letter, self.name_offset + 51 + off, 20)
            off = off + font:getWidth(letter) + spacing
        end
    elseif self.style == "tsunderswap" then
        self.offset = -40
        self.name_offset = -25
        self.text_offset = 0
        self.healthbar_x = self.offset + 65
        self.healthbar_y = 50

        Draw.setColor(0, 0, 0, .6)
        love.graphics.rectangle("fill", 20, 5, 105, 60)

        Draw.setColor(COLORS["red"])
        love.graphics.rectangle("fill", self.healthbar_x, self.healthbar_y, 95, 9)

        local health = (self.chara:getHealth() / self.chara:getStat("health")) * 95

        if health > 0 then
            Draw.setColor(0, 255, 0)
            love.graphics.rectangle("fill", self.healthbar_x, self.healthbar_y, math.ceil(health), 9)
        end

        local color = PALETTE["action_health_text"]
        if health <= 0 then
            color = PALETTE["action_health_text_down"]
        elseif (self.chara:getHealth() <= (self.chara:getStat("health") / 4)) then
            color = PALETTE["action_health_text_low"]
        else
            color = PALETTE["action_health_text"]
        end

        love.graphics.setFont(self.main_font)
        Draw.setColor(PALETTE["action_health_text"])
        love.graphics.print("HP", self.text_offset + 25, 30)

        local health_offset = 0
        health_offset = (#tostring(self.chara:getHealth()) - 1) * 8

        Draw.setColor(color)
        love.graphics.setFont(self.main_font)
        love.graphics.print(self.chara:getHealth(), self.text_offset + 72 - health_offset, 30)
        Draw.setColor(PALETTE["action_health_text"])
        love.graphics.print("/", self.text_offset + 86, 30)
        local string_width = self.main_font:getWidth(tostring(self.chara:getStat("health")))
        Draw.setColor(color)
        love.graphics.print(self.chara:getStat("health"), self.text_offset + 120 - string_width, 30)

        local font = self.main_font
        love.graphics.setFont(font)
        Draw.setColor(1, 1, 1, 1)

        local name = self.chara:getName():upper()
        local spacing = 5 - name:len()

        local off = 0
        for i = 1, name:len() do
            local letter = name:sub(i, i)
            love.graphics.print(letter, self.name_offset + 51 + off, 15)
            off = off + font:getWidth(letter) + spacing
        end
    end



    super.draw(self)
end

return LightOverworldActionBox