# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :employee_reward_app,
  ecto_repos: [EmployeeRewardApp.Repo]

# Configures the endpoint
config :employee_reward_app, EmployeeRewardAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YM7QxQ61n2AqjsoezKowpEhSKD2msMF+me/F/Xvo0x/h/Uo426mKeXYxwCWE8h7R",
  render_errors: [view: EmployeeRewardAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: EmployeeRewardApp.PubSub,
  live_view: [signing_salt: "YPqqsIiX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Use comeonin/bcrypt for password hashing
config :comeonin, bcrypt_log_rounds: 4

# Configures Oban
config :employee_reward_app, Oban,
  repo: EmployeeRewardApp.Repo,
  queues: [default: 10, mailers: 20, events: 50, low: 5],
  plugins: [Oban.Plugins.Pruner,
  {Oban.Plugins.Cron,
  crontab: [
    {"0 0 1 * *", EmployeeRewardAppWeb.Workers.MonthlyDigestWorker}
  ]}
]
