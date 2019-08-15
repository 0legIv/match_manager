use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :match_manager, MatchManagerWeb.Endpoint,
  http: [port: 4002],
  server: false

config :match_manager, :data_file, "data.csv"

# Print only warnings and errors during test
config :logger, level: :warn
