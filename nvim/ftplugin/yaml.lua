local filename = vim.fn.expand("%:t")

local possible_filenames = { "docker-compose.yml", "docker-compose.yaml" }

for _, v in pairs(possible_filenames) do
	if filename == v then
		vim.bo.filetype = "yaml.docker-compose"
	end
end
