module main

import cli { Command }
import os { system, dir }
import v.vmod

const self_cmd = Command{
		name: 'self'
		description: 'self compilation'
		execute: fn (cmd Command) ? {
			println('Compiling vv...')
			exit(v(dir(@FILE)))
		}
	}

fn new_app() Command {
	mod := vmod.decode(@VMOD_FILE) or { panic(err) }
	mut commands := [self_cmd]
	commands << inspect_commands

	mut app := Command{
		name: mod.name
		description: mod.description
		version: mod.version
		disable_flags: true
		commands: commands
	}
	app.setup()
	return app
}

fn main() {
	mut app := new_app()
	app.parse(os.args)
}
