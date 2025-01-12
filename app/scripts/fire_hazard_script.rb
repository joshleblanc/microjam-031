module Scripts
  class FireHazardScript < Hoard::Script
    def init
      @active = false
    end

    def on_collision(from)
      return unless from.is_a? Entities::Player
      return unless @active
    end

    def preactivate!
      entity.show!
    end

    def activate!
      @active = true
    end

    def deactivate!
      @active = false
    end

    def post_update
      return unless entity.visible?

      args.outputs.solids << {
        x: entity.x,
        y: entity.y,
        w: entity.w,
        h: entity.h,
        r: 255, g: 0, b: 0,
      }
    end
  end
end
