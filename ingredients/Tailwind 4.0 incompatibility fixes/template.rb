say "Replacing @tailwind directives with a single @import 'tailwindcss' statement."

gsub_file(
  "app/assets/stylesheets/application.tailwind.css",
  /@tailwind base;\s*@tailwind components;\s*@tailwind utilities;/m,
  '@import "tailwindcss";'
)

say "Done!"