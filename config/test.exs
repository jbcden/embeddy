import Config

config :embeddy, Embeddy.Repo,
username: "postgres",
password: "postgres",
hostname: "localhost",
show_sensitive_data_on_connection_error: true,
database: "embeddy_test#{System.get_env("MIX_TEST_PARTITION")}",
pool: Ecto.Adapters.SQL.Sandbox,
pool_size: 10
