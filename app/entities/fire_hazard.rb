module Entities
  class FireHazard < Hoard::Entity
    script Scripts::FireHazardScript.new
    script Hoard::Scripts::AnimationScript.new(
      :fire,
      frames: 9,
      path: "sprites/smoke-effects/smoke2.png",
      tile_w: 64,
      tile_h: 64,
      x: 0,
      y: 9 * 64,
    )

    def initialize(...)
      super

      add_script Hoard::Scripts::AnimationScript.new(
        :pre_fire,
        frames: 9,
        path: "sprites/smoke-effects/smoke3.png",
        tile_w: 64,
        tile_h: 64,
        offset_y: (rh / 2) - 2,
        speed: 0.9,
        x: 0,
        y: 1 * 64,
      )
    end
  end
end
