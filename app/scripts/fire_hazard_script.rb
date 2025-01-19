module Scripts
  class FireHazardScript < Hoard::Script
    def init
      @active = false
    end

    def on_collision(from)
      return unless from.is_a? Entities::Player
      return unless @active
      return unless @damage_enabled

      p "Applying damage to #{from}, from #{entity}"

      from.apply_damage(1, entity)
    end

    def preactivate!
      entity.send_to_scripts(:play_animation, :pre_fire, false)
      @active = true
      @damage_enabled = false
    end

    def activate!
      @damage_enabled = true
      entity.send_to_scripts(:play_animation, :fire, false) do
        @damage_enabled = false
      end
    end

    def deactivate!
      @damage_enabled = false
    end
  end
end
