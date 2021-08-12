defmodule EmployeeRewardAppWeb.Workers.MonthlyDigestWorker do
  use Oban.Worker,
  queue: :events,
  priority: 3,
  max_attempts: 3,
  tags: ["business"],
  unique: [period: 30]

  alias EmployeeRewardApp.Points
  alias EmployeeRewardApp.Points.Pool

  @impl Oban.Worker
  def perform(_job) do
    EmployeeRewardApp.Points.reset_pools()
    :ok
  end
end
