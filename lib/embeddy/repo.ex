defmodule Embeddy.Repo do
  use Ecto.Repo,
    otp_app: :embeddy,
    adapter: Ecto.Adapters.Postgres
end
