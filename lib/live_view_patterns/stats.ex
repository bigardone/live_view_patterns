defmodule LiveViewPatterns.Stats do
  import Ecto.Query

  alias Ecto.UUID

  alias LiveViewPatterns.{
    Repo,
    Schemas.User.Stats
  }

  @spec by_user_ids([UUID.t()]) :: [Stats.t()]
  def by_user_ids(user_ids) do
    Stats
    |> where([s], s.user_id in ^user_ids)
    |> Repo.all()
  end
end
