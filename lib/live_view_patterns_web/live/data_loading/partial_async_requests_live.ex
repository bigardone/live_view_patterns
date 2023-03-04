defmodule LiveViewPatternsWeb.DataLoading.PartialAsyncRequestsLive do
  use LiveViewPatternsWeb, :live_view

  import __MODULE__.UserComponent

  @impl LiveView
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(page_title: "Async requests and partial loading")
      |> assign(page_name: __MODULE__)

    {:ok, socket, layout: {LiveViewPatternsWeb.Layouts, :sidebar}}
  end

  @impl LiveView
  def handle_params(params, _uri, socket) do
    force_error = Map.get(params, "force_error", false)
    users = LiveViewPatterns.all_users()

    if connected?(socket) do
      fetch_users(force_error)
    end

    {:noreply, stream(socket, :users, users)}
  end

  @impl LiveView
  def handle_info({:fetch_users, {:ok, users}}, socket) do
    socket =
      Enum.reduce(users, socket, fn user, acc ->
        stream_insert(acc, :users, user)
      end)

    {:noreply, socket}
  end

  def handle_info({:fetch_users, {:error, _}}, socket) do
    {:noreply, socket}
  end

  defp fetch_users(force_error) do
    pid = self()

    Task.Supervisor.start_child(LiveViewPatterns.TaskSupervisor, fn ->
      Process.sleep(500)

      result =
        if force_error do
          {:error, :timeout}
        else
          {:ok, LiveViewPatterns.all_users(with_stats: true)}
        end

      send(pid, {:fetch_users, result})
    end)
  end
end
