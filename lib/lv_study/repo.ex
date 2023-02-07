defmodule LvStudy.Repo do
  use Ecto.Repo,
    otp_app: :lv_study,
    adapter: Ecto.Adapters.Postgres
end
