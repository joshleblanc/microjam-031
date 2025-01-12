module Entities
  class Phase2PillarSpawn < Hoard::Entity
    hidden

    def init
      Game.s.broadcast_to_scripts("register_pillar_spawn", self)
    end
  end
end
