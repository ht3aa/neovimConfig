local function generateRandomString(length)
  local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  local randomString = ""
  for _ = 1, length do
    local randIndex = math.random(1, #chars)
    randomString = randomString .. string.sub(chars, randIndex, randIndex)
  end
  return randomString
end
local function is_dir(path)
  local f = io.open(path, "r")
  local ok, err, code = f:read(1)
  f:close()
  return code == 21
end

local function exists(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

local function copyLibFilesContent(content, path, entries, folderIgnoreList, fileLanguagesList, index, libCall)
  if index > #entries then
    return
  end


  local item = entries[index]
  local parts = vim.split(item, "%.")
  local fileLanguage = parts[#parts]

  if not vim.tbl_contains(folderIgnoreList, item) then
    if is_dir(path .. item) then
      local newPath = path .. item .. "/"
      local subEntries = vim.fn.readdir(newPath)


      copyLibFilesContent(content, newPath, subEntries, folderIgnoreList, fileLanguagesList, 1, false)
    elseif vim.tbl_contains(fileLanguagesList, fileLanguage) then
      if not exists('~/.config/lvim/lua/extra/myCode/' .. fileLanguage .. '/') then
        pcall(os.execute, 'mkdir -p ~/.config/lvim/lua/extra/myCode/' .. fileLanguage .. '/')
      end

      local randomString = generateRandomString(10)

      -- copy file
      os.execute('cp "' ..
        path ..
        item .. '" ~/.config/lvim/lua/extra/myCode/' .. fileLanguage .. '/' .. randomString .. '.' .. fileLanguage)
    end
  end


  copyLibFilesContent(content, path, entries, folderIgnoreList, fileLanguagesList, index + 1, libCall)
end

local path = "/mnt/hasanweb/programming/";

local entries = vim.fn.readdir(path);

local folderIgnoreList = {
  ".git",
  "node_modules",
  "vendor",
  "pkg",
  ".gitignore",
  "hackthon-frontend",
  "repos",
  "ssh",
  "important_notes",
};
local fileLanguagesList = { "js", "ts", "tsx", "jsx", "go", "php" };

function StartcopyLibFilesContent()
  os.execute('rm -rf ~/.config/lvim/lua/extra/myCode/')
  os.execute('mkdir ~/.config/lvim/lua/extra/myCode/')
  copyLibFilesContent({}, path, entries, folderIgnoreList, fileLanguagesList, 1, false)
end


