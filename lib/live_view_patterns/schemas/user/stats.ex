defmodule LiveViewPatterns.Schemas.User.Stats do
  use LiveViewPatterns, :schema

  alias __MODULE__
  alias LiveViewPatterns.Schemas.User

  schema "stats" do
    field(:finished_tasks, :integer)
    field(:tracked_time, :integer)

    belongs_to(:user, User)
  end

  @fields ~w(
    user_id
    finished_tasks
    tracked_time
  )a

  def changeset(stats \\ %Stats{}, params) do
    stats
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
