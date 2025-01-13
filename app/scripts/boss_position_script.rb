module Scripts
  class BossPositionScript < Hoard::Script
    attr :phase

    def init
      Game.s.broadcast_to_scripts(:register_boss_position, entity)
    end
  end
end
