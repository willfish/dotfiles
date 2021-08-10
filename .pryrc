Pry.commands.alias_command "c", "continue"
Pry.commands.alias_command "s", "step"
Pry.commands.alias_command "n", "next"
Pry.commands.alias_command "f", "finish"

Pry::Commands.command(/^$/, "repeat last command") do
  pry_instance.run_command Pry.history.to_a.last
end

if Object.const_defined?("Rails")
  ## allows: routes.recognize_path "/station/index/42.html"
  ## and:    routes.generate :controller => :station, :action=> :index, :id=>42
  routes = Rails.application.routes
end

Pry.config.color = true
Pry.config.theme = "solarized"
Pry.config.ls.separator = "\n" # new lines between methods
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black
