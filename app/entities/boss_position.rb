module Entities
  class BossPosition < Hoard::Entity
    script Hoard::Scripts::LdtkEntityScript.new
    script Scripts::BossPositionScript.new
  end
end
