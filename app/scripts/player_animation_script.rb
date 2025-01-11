module Scripts
  class PlayerAnimationScript < Hoard::Scripts::AnimationScript
    def initialize(id, x, y, frames, animation_name = nil)
      opts = {
        offset_y: -16,
        offset_x: -16,
      }

      @frames = frames
      @animation_name = animation_name

      super(id, {
        frames: frames,
        path: "sprites/monochrome_tilemap_packed.png",
        x: x,
        y: y,

      })
    end
  end
end
