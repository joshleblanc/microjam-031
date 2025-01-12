module Scripts
  class FireHazardScript < Hoard::Script
    ALPHA_INCREMENT = 10

    def init
      @active = false
      @alpha = 0
      @alpha_increment = ALPHA_INCREMENT
    end

    def on_collision(from)
      return unless from.is_a? Entities::Player
      return unless @active

      p "Applying damage to #{from}, from #{entity}"

      from.apply_damage(1, entity)
    end

    def preactivate!
      @active = true
      @alpha_increment = ALPHA_INCREMENT
    end

    def activate!
      @alpha_increment = 0
      @alpha = 255
    end

    def deactivate!
      @alpha_increment = -ALPHA_INCREMENT
      Hoard::Scheduler.schedule do |s, blk|
        if @alpha == 0
          @active = false
        else
          s.wait(1, &blk)
        end
      end
    end

    def update
      return unless @active
      next_alpha = @alpha + @alpha_increment
      if @alpha_increment > 0 && next_alpha < 125
        @alpha = next_alpha
      elsif @alpha_increment < 0 && next_alpha > 0
        @alpha = next_alpha
      end
    end

    def post_update
      args.outputs[:scene].primitives << {
        x: entity.rx,
        y: entity.ry,
        w: entity.rw,
        h: entity.rh,
        r: 255, g: 0, b: 0, a: @alpha,
        primitive_marker: :solid,
      }
    end
  end
end
