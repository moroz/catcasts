use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :catcasts, CatcastsWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :catcasts, Catcasts.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "karol",
  password: "7R2h2djZ",
  database: "catcasts_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
