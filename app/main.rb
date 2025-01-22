$gtk.disable_controller_config

require "lib/dragonborn/dragonborn"
require "lib/hoard/hoard"
require "lib/dr-particles/app/particles"
require "lib/hoard/ldtk/root"
require "lib/dragonjson/json"

Dragonborn.configure do
  root "app"
  ignore "app/repl"
end

Hoard::Process.server = true
Hoard::Process.client = true

def measure_allocations(*args, &blk)
  before, after = {}, {}
  ObjectSpace.count_objects(before)
  result = blk.call(*args)
  ObjectSpace.count_objects(after)

  after.merge(before) { |k, v1, v2| v1 - v2 }.each do |k, v|
    $args.outputs.debug << "#{k}: #{v}"
  end

  return result
end

def tick(args)
  measure_allocations do
    Game.s.args = args
    Game.s.tick

    args.outputs.debug << "#{args.gtk.current_framerate} fps"
    args.outputs.debug << "#{args.gtk.current_framerate_calc} fps simulation"
    args.outputs.debug << "#{args.gtk.current_framerate_render} fps render"
    args.outputs.background_color = [0, 0, 0]

    if args.state.tick_count == 1
      args.audio[:bg_music] = { input: "sounds/boss.ogg", looping: true, gain: 0.175 }
      Game.s.start_level(Game.s.root.levels.first)
    end
  end
end
