local M = {}

---@param repo string `owner/name`
function M.gh(repo) return 'https://github.com/' .. repo end

return M
