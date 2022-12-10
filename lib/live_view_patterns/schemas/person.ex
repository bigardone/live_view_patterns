defmodule LiveViewPatterns.Schemas.Person do
  use LiveViewPatterns, :schema

  schema "people" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:avatar_url, :string)
    field(:phone_number, :string)
  end

  def changeset(person, params \\ %{}) do
    fields = __MODULE__.__schema__(:fields)

    person
    |> cast(params, fields)
    |> validate_required(fields)
  end

  def full_name(%Person{first_name: first_name, last_name: last_name}) do
    Enum.join([first_name, last_name], " ")
  end
end
