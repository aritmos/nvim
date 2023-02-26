require("competitest").setup({
	compile_command = {
		rust = { exec = "cargo", args = { "build", "-q", "--example", "$(FNOEXT)" } },
	},
	run_command = {
		rust = { exec = "cargo", args = { "run", "-q", "--example", "$(FNOEXT)" } },
	},
	testcases_directory = "/../tests/",
})
