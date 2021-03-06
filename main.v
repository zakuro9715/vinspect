module main

import cli { Command }
import os
import v.vmod

fn new_app() Command {
	mod := vmod.decode(@VMOD_FILE) or { panic(err) }

	mut app := Command{
		name: mod.name
		description: mod.description
		version: mod.version
		sort_flags: false
		sort_commands: false
		commands: commands
	}
	app.setup()
	return app
}

fn main() {
	mut app := new_app()
	app.parse(os.args)
}
