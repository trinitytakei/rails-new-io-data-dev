def create_tailwind_authentication_form_builder(directory, file_name)
  empty_directory directory

  create_file "#{directory}/#{file_name}", <<1>>
end