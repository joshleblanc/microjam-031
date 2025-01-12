module Entities
  class Boss < Hoard::Entity
    script Hoard::Scripts::LdtkEntityScript.new
    script Scripts::BossScript.new
    script Scripts::BossAttack1Script.new
    script Scripts::BossAttack2Script.new
    script Hoard::Scripts::HealthScript.new(health: 100)
  end
end
