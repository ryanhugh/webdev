use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nu_mart, NuMartWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :nu_mart, NuMart.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "nu_mart",
  password: "oochooyuC5",
  database: "nu_mart_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
