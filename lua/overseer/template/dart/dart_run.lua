return {
	name = "dart build runner",
	builder = function(params)
		return {
			cmd = { "dart" },
			args = { "run", "build_runner", "build" },
		}
	end,
	priority = 9,
	condition = {
		filetype = { "dart" },
	},
}
