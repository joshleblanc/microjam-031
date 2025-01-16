module Entities
  class FireHazard < Hoard::Entity
    script Scripts::FireHazardScript.new
    script Hoard::Scripts::AnimationScript.new(
      :fire,
      files: [
        "sprites/particles/flame_01.png",
        "sprites/particles/flame_02.png",
        "sprites/particles/flame_03.png",
        "sprites/particles/flame_04.png",
      ],
      tile_w: 512,
      tile_h: 512,
    )

    def initialize(...)
      super

      send_to_scripts(:play_animation, :fire, true)
    end
  end
end
