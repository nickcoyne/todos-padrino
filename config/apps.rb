##
# This file mounts each app in the Padrino project to a specified sub-uri.
# You can mount additional applications using any of these commands below:
#
#   Padrino.mount('blog').to('/blog')
#   Padrino.mount('blog', :app_class => 'BlogApp').to('/blog')
#   Padrino.mount('blog', :app_file =>  'path/to/blog/app.rb').to('/blog')
#
# You can also map apps to a specified host:
#
#   Padrino.mount('Admin').host('admin.example.org')
#   Padrino.mount('WebSite').host(/.*\.?example.org/)
#   Padrino.mount('Foo').to('/foo').host('bar.example.org')
#
# Note 1: Mounted apps (by default) should be placed into the project root at '/app_name'.
# Note 2: If you use the host matching remember to respect the order of the rules.
#
# By default, this file mounts the primary app which was generated with this project.
# However, the mounted app can be modified as needed:
#
#   Padrino.mount('AppName', :app_file => 'path/to/file', :app_class => 'BlogApp').to('/')
#

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  # enable :sessions
  set :session_secret,
      '3721ad50362e6d9d3bd17b00644413cf8b5e63274cbe4710d19893762c66301e'
  # set :protection, except: :path_traversal
  # # set :protect_from_csrf, except: %r{/__better_errors/\\w+/\\w+\\z} if
  # #   Padrino.env == :development
  # if Padrino.env == :development
  #   set :protect_from_csrf, true
  #   set :allow_disabled_csrf, true
  # end
  set :protect_from_csrf, false if Padrino.env == :development
end

# Mounts the core application for this project
Padrino.mount(
  'PadrinoTodos::Api', app_file: Padrino.root('api/app.rb')
).to('/api')
Padrino.mount(
  'PadrinoTodos::Admin', app_file: Padrino.root('admin/app.rb')
).to('/admin')
Padrino.mount('PadrinoTodos::App', app_file: Padrino.root('app/app.rb')).to('/')
