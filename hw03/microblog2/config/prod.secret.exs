use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :microblog, MicroblogWeb.Endpoint,
  secret_key_base: "SH59UoEAq/6HfUzic2iELqwzZh7vsC6chTZ8T+X7g1oZgtfZ6qJFKnYjYIASmlHa"

# Configure your database
config :microblog, Microblog.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "microblog_prod",
  pool_size: 15
