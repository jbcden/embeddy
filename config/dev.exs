import Config

config :embeddy, Embeddy.Repo,
username: "postgres",
password: "postgres",
hostname: "localhost",
show_sensitive_data_on_connection_error: true,
database: "embeddy_dev",
pool_size: 10
