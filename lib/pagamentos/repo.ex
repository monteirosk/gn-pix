defmodule Pagamentos.Repo do
  use Ecto.Repo,
    otp_app: :pagamentos,
    adapter: Ecto.Adapters.Postgres
end
