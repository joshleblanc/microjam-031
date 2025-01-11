class Game < Hoard::Game
  attr :root, :player

  def initialize
    super
    @root = Hoard::Ldtk::Root.import($gtk.parse_json_file("data/map.ldtk"))
  end

  def user
    @user ||= Entities::User.new("Local")
  end

  def player
    @player ||= user.spawn_player(Entities::Player)
  end

  def start_level(level)
    super(level)
    if level.entity("Player") && !player.spawned?
      spawn = level.entity("Player")
      player.set_pos_case(spawn.grid[0], spawn.grid[1])
      player.send_to_scripts("ldtk_entity=", spawn)
    end

    level.layer("Entities").entity_instances.each do |entity|
      he = Hoard::Entity.resolve(entity.identifier)

      next if he == Entities::Player

      next unless he

      he.new(entity.grid[0], entity.grid[1], self).tap do |m|
        m.send_to_scripts("ldtk_entity=", entity)
        entity.field_instances.each do |field|
          m.send_to_scripts("#{field.identifier}=", field.value)
          m.args = $args
        end
      end
    end
  end
end
