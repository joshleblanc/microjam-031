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

def tick(args)
  Game.s.args = args
  Game.s.tick

  args.outputs.primitives << args.gtk.framerate_diagnostics_primitives
  args.outputs.background_color = [0, 0, 0]

  if args.state.tick_count == 1
    args.audio[:bg_music] = { input: "sounds/boss.ogg", looping: true, gain: 0.175 }
    Game.s.start_level(Game.s.root.levels.first)
  end
end
