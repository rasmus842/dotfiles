vim.filetype.add({
	extension = { jenkinsfile = "groovy" },
	pattern = { [".*/Jenkinsfile%.[%w_.-]+"] = "groovy" },
})
