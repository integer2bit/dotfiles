template = mp.get_property("screenshot-template")

function folder_screenshot()
	folder_filename = string.gsub(mp.get_property("filename"), "%s+$", "")
	named_dir = folder_filename .. "/" .. template
	mp.set_property("screenshot-template", named_dir)
end

mp.register_event("file-loaded", folder_screenshot)
