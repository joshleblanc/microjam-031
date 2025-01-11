module Scripts
  class PlayerAnimationsScript < Hoard::Script
    def init
      entity.add_script Scripts::PlayerAnimationScript.new(:idle, 0, 12, 1)
      entity.add_script Scripts::PlayerAnimationScript.new(:walk, 1, 12, 3)
      entity.add_script Scripts::PlayerAnimationScript.new(:standing_jump, 5, 12, 1, :jump)
      entity.add_script Scripts::PlayerAnimationScript.new(:moving_jump, 4, 12, 1, :jump)
      entity.add_script Scripts::PlayerAnimationScript.new(:landing, 0, 12, 1, :land)
    end
  end
end
