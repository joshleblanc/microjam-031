module Entities
  class Phase1PlatformSpawn < Hoard::Entity
    hidden

    def init
      Game.s.broadcast_to_scripts("register_platform_spawn", self)
    end
  end
end
