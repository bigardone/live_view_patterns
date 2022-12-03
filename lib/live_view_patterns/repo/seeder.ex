defmodule LiveViewPatterns.Repo.Seeder do
  alias LiveViewPatterns.{
    Repo,
    Schemas.Person
  }

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def start_link(_opts) do
    run()

    :ignore
  end

  defp run do
    data =
      for _ <- 1..100 do
        first_name = Faker.Person.first_name()
        last_name = Faker.Person.last_name()

        email =
          [first_name, last_name]
          |> Enum.join(".")
          |> String.downcase()
          |> then(&(&1 <> "@" <> Faker.Internet.free_email_service()))

        %{
          first_name: first_name,
          last_name: last_name,
          email: email,
          avatar_url: Faker.Avatar.image_url()
        }
      end

    Repo.insert_all(Person, data)
  end
end
