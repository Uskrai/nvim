return {
	name = "flutter run",
	builder = function(params)
		return {
			cmd = { "flutter" },
			args = { "run" },
		}
	end,
	priority = 10,
	condition = {
		filetype = { "dart" },
	},
}
