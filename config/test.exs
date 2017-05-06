use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :broccoli, Broccoli.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :broccoli, Broccoli.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "broccoli_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :guardian, Guardian,
  allowed_algos: ["HS256"],
  verify_module: Guardian.JWT,
  issuer: "broccoli.nalexandre.test",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: false,
  secret_key: "qwerty123456",
  serializer: Broccoli.GuardianSerializer
