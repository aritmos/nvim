local setup, code_runner = pcall(require, "code_runner")
if not setup then
	print("CodeRunner not installed")
	return
end

code_runner.setup({
	-- put here the commands by filetype
	filetype = {
		python = "python3 -u",
		-- rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
		rust = "cargo run",
	},
	mode = "float",
	float = {
		-- Window border (see ':h nvim_open_win')
		border = "rounded",
	},
})
