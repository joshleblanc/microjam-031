module Entities
  class Phase1PlatformSpawn < Hoard::Entity
    def init
      self.visible = false
      Game.s.broadcast_to_scripts("register_platform_spawn", self)
    end
  end
end
