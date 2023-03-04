defmodule LiveViewPatterns.Users do
  import Ecto.Query

  alias LiveViewPatterns.{
    Repo,
    Schemas.User
  }

  @spec all(with_stats: boolean()) :: [User.t()]
  def all(opts \\ []) do
    with_stats = Keyword.get(opts, :with_stats, false)

    from(u in User)
    |> preload_stats(with_stats)
    |> Repo.all()
  end

  defp preload_stats(q, false), do: q
  defp preload_stats(q, true), do: preload(q, [:stats])
end
