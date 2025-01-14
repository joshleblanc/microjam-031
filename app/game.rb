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

  def boss
    @boss ||= Entities::Boss.new(parent: Game.s)
  end

  def start_level(level)
    super(level)
    if level.entity("Player") && !player.spawned?
      spawn = level.entity("Player")
      player.set_pos_case(spawn.grid[0], spawn.grid[1])
      player.send_to_scripts("ldtk_entity=", spawn)
    end

    if level.entity("Boss")
      boss_spawn = level.entity("Boss")
      boss.set_pos_case(boss_spawn.grid[0], boss_spawn.grid[1])
      boss.send_to_scripts("ldtk_entity=", boss_spawn)
    end

    level.layer("Entities").entity_instances.each do |entity|
      he = Hoard::Entity.resolve(entity.identifier)

      next if he == Entities::Player
      next if he == Entities::Boss

      next unless he

      he.new(
        cx: entity.grid[0], cy: entity.grid[1], anchor_x: entity.pivot[0], anchor_y: entity.pivot[1],
        parent: self, w: entity.width, h: entity.height,
      ).tap do |m|
        m.send_to_scripts("ldtk_entity=", entity)

        entity.field_instances.each do |field|
          m.send_to_scripts("#{field.identifier}=", field.value)
          m.args = $args
        end
      end
    end
  end

  # def render
  #   super
  #   Debug.render_grid(outputs[:scene])
  # end
end
