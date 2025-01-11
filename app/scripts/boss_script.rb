module Scripts
  class BossScript < Hoard::Script
    def init
      entity.boss_attack_1_script.activate
    end
  end
end
