defmodule MasterKey.Repo do
  use Ecto.Repo,
    otp_app: :master_key,
    adapter: Ecto.Adapters.Postgres
end
