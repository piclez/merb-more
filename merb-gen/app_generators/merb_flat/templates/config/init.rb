Merb.push_path(:view, Merb.root / "views")
Merb::Router.prepare do |r|
  r.match('/').to(:controller => 'foo', :action =>'index')
  r.default_routes
end

require 'application'

<% require 'sha1' %>
Merb::Config.use { |c|
  c[:environment]         = 'production',
  c[:framework]           = {},
  c[:log_level]           = 'debug',
  c[:use_mutex]           = false,
  c[:session_store]       = 'cookie',
  c[:session_secret_key]  = '<%= SHA1.new(rand(100000000000).to_s).to_s %>',
  c[:exception_details]   = true,
  c[:reload_classes]      = true,
  c[:reload_time]         = 0.5
}