run "yarn add @tailwindcss/forms"

content = File.read("tailwind.config.js")

if content.include?("plugins:")
  unless content.include?("@tailwindcss/forms")
    gsub_file "tailwind.config.js", /plugins:\s*\[/, "plugins: [\n    require('@tailwindcss/forms'),"
  end
else
  gsub_file "tailwind.config.js", /module\.exports\s*=\s*\{/, <<~CONFIG
    module.exports = {
      plugins: [
        require('@tailwindcss/forms'),
      ],
  CONFIG
end