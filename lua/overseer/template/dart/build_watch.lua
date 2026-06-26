return {
	name = "Build watch",
	builder = function(params)
		return {
			cmd = { "dart" },
			args = { "run", "build_runner", "watch" },
		}
	end,
	priority = 10,
	condition = {
		filetype = { "dart" },
	},
}
