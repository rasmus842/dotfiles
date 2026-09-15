vim.filetype.add({
	extension = {
		jenkinsfile = "groovy",
		slim = "slim",
	},
	pattern = { [".*/Jenkinsfile%.[%w_.-]+"] = "groovy" },
})
