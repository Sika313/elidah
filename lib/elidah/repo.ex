defmodule Elidah.Repo do
  use Ecto.Repo,
    otp_app: :elidah,
    adapter: Ecto.Adapters.Postgres
end
