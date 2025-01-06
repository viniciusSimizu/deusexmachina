local filename = vim.fn.expand("%:t")

if string.len(filename) >= 2 and string.sub(filename, -2, -1) == ".h" then
	vim.bo.filetype = "h"
end
