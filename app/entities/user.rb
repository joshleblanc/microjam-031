module Entities
  class User < Hoard::User
    script Hoard::Scripts::SaveDataScript.new
  end
end
