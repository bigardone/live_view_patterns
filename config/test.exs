import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :live_view_patterns, LiveViewPatternsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "wfhdibXT6nHp0i6M2a4AW/IvRCA5y1zYcvERf3Kb6cMw+3EDVwUU/hIq/TTxW5jr",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
