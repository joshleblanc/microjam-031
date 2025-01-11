module Scripts
  class PlatformScript < Hoard::Script
    def init
      entity.send_to_scripts :play_animation, :default, true
    end
  end
end
