defmodule LiveViewPatterns.TaskSupervisor do
  @spec async(fun()) :: reference()
  def async(fun) do
    __MODULE__
    |> Task.Supervisor.async(fun)
    |> Map.get(:ref)
  end
end
