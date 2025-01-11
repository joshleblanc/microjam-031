module Scripts
  class BossAttack1Script < Hoard::Script
    def init
      @platform_spawns ||= []
    end

    def activate
      @platform_spawns.each do |platform_spawn|
        Entities::Platform.new(
          cx: platform_spawn.cx,
          cy: platform_spawn.cy,
          parent: self.entity,
          tile_w: 48,
          w: 48,
        )
      end
    end

    def register_platform_spawn(platform_spawn)
      @platform_spawns ||= []
      @platform_spawns << platform_spawn
    end
  end
end
