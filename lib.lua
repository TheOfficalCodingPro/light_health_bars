local lib = {}
function lib:init()
    Utils.hook(World, "showHealthBars", function (orig, self)
        if Game.light then
            if self.healthbar then
                self.healthbar:transitionIn()
            else
                self.healthbar = LightHealthBar()
                self.healthbar.layer = WORLD_LAYERS["ui"]
                self:addChild(self.healthbar)
            end
            return
        end

        if self.healthbar then
            self.healthbar:transitionIn()
        else
            self.healthbar = HealthBar()
            self.healthbar.layer = WORLD_LAYERS["ui"]
            self:addChild(self.healthbar)
        end
    end)
    
    Utils.hook(World, "update", function (orig, self)
        orig(self)
        if self:inBattle() then
            self:showHealthBars()
        end
    end)
end

return lib