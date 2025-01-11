module Entities
  class Platform < Hoard::Entity
    collidable

    script Scripts::PlatformScript.new
    script Hoard::Scripts::AnimationScript.new(:default, {
      path: "sprites/monochrome_tilemap_packed.png",
      x: 4 * 16,
      y: 6 * 16,
      frames: 1,
    })
  end
end
