defmodule LiveViewPatterns.Repo.Seeder do
  alias LiveViewPatterns.{
    Repo,
    Schemas.User,
    Schemas.User.Stats
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
    for _ <- 1..15 do
      first_name = Faker.Person.first_name()
      last_name = Faker.Person.last_name()

      email =
        [first_name, last_name]
        |> Enum.join(".")
        |> String.downcase()
        |> then(&(&1 <> "@" <> Faker.Internet.free_email_service()))

      user =
        %{
          first_name: first_name,
          last_name: last_name,
          email: email,
          avatar_url: Faker.Avatar.image_url()
        }
        |> User.changeset()
        |> Repo.insert!()

      for _ <- 5..15 do
        %{
          user_id: user.id,
          finished_tasks: Enum.random(5..20),
          tracked_time: Enum.random(60..6_000)
        }
        |> Stats.changeset()
        |> Repo.insert!()
      end
    end
  end
end
