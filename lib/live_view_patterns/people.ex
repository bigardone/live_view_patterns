defmodule LiveViewPatterns.People do
  alias LiveViewPatterns.{Repo, Schemas.Person}

  def all do
    Repo.all(Person)
  end
end
