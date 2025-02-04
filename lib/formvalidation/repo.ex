defmodule Formvalidation.Repo do
  use Ecto.Repo,
    otp_app: :formvalidation,
    adapter: Ecto.Adapters.Postgres
end
