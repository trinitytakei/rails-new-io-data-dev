def beef_up_sessions_new(file_path)
  prepend_to_file file_path, <<~HTML
  <div class="flex flex-col items-center justify-center h-full">
  <h1 class="bg-white py-px px-2 -mx-2 uppercase font-bold text-2xl">Sign in</h1>
  HTML

  gsub_file file_path, 
    '<%= form_with url: session_path do |form| %>', 
    '<%= form_with url: session_path, :builder => TailwindAuthentication do |form| %>'

  append_to_file file_path, "</div>\n"
end

def add_form_builder_views_to_tailwind_config(file_path)
  gsub_file file_path, 
    /content: \[(.*?)\s*\]/m, "content: [\\1,\n    './app/lib/form_builders/**/*.rb'\n  ]"
end

def create_tailwind_authentication_form_builder(directory, file_name)
  empty_directory directory

  create_file "#{directory}/#{file_name}", <<~FORM_BUILDER_CONTENT
    class TailwindAuthentication < ActionView::Helpers::FormBuilder
      FORM_STYLE = "mt-10 sm:mx-auto sm:w-full sm:max-w-sm space-y-4"
      TEXT_FIELD_STYLE = "w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
      SUBMIT_STYLE = "flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"

      def initialize(object_name, object, template, options)
        options[:html] = {}
        options[:html][:class] =  FORM_STYLE
        super
      end

      def email_field(method, options={})
        super(method, options.merge({class: TEXT_FIELD_STYLE}))
      end

      alias_method :password_field, :email_field

      def submit(value = nil, options = {})
        super(value, options.merge({class: SUBMIT_STYLE}))
      end
    end      
  FORM_BUILDER_CONTENT
end

beef_up_sessions_new('app/views/sessions/new.html.erb')
add_form_builder_views_to_tailwind_config('tailwind.config.js')
create_tailwind_authentication_form_builder('app/form_builders', 'tailwind_authentication.rb')