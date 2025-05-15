# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join("node_modules/bootstrap-icons/font")
Rails.application.config.assets.paths << Rails.root.join("node_modules/bootstrap/dist/js")
Rails.application.config.assets.precompile << "bootstrap.bundle.min.js"

# Adicione a pasta 'custom' aos caminhos de busca do Asset Pipeline
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "custom")

# Adicione seus arquivos à lista de precompilação
Rails.application.config.assets.precompile += %w(
   custom/main.js
   custom/utils.js
   custom/browser.min.js
   custom/breakpoints.min.js
)
