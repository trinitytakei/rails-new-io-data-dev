create_file "tailwind_authentication.rb", <<~SNIPPET_1
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
SNIPPET_1
