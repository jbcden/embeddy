import Config

config :embeddy, ecto_repos: [Embeddy.Repo]
import_config "#{config_env()}.exs"
