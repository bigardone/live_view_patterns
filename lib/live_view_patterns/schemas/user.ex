defmodule LiveViewPatterns.Schemas.User do
  use LiveViewPatterns, :schema

  alias __MODULE__
  alias __MODULE__.Stats

  schema "users" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:avatar_url, :string)

    has_one(:stats, Stats)
  end

  @fields ~w(
    first_name
    last_name
    email
    avatar_url
  )a

  def changeset(person \\ %User{}, params) do
    person
    |> cast(params, @fields)
    |> validate_required(@fields)
  end

  def full_name(%User{first_name: first_name, last_name: last_name}) do
    Enum.join([first_name, last_name], " ")
  end
end
