defmodule LiveViewPatternsWeb.AsyncRequestsLive.UnionTypesAndSkeletonsLive do
  use LiveViewPatternsWeb, :live_view

  import LiveViewPatternsWeb.AsyncRequestsLive.PersonComponent

  alias LiveViewPatternsWeb.RemoteData
  alias Phoenix.LiveView.JS

  @impl LiveView
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(page_title: "Async requests, union types, and skeletons")
      |> assign(page_name: __MODULE__)
      |> assign(force_error: false)

    {:ok, socket, layout: {LiveViewPatternsWeb.Layouts, :sidebar}}
  end

  @impl LiveView
  def handle_params(_unsigned_params, _uri, socket) do
    data =
      if connected?(socket) do
        ref = fetch_data()
        RemoteData.requesting(ref)
      else
        RemoteData.not_requested()
      end

    {:noreply, assign(socket, data: data)}
  end

  @impl LiveView
  def handle_event("force_error", _params, socket) do
    ref = fetch_data(true)
    {:noreply, assign(socket, data: RemoteData.requesting(ref))}
  end

  @impl LiveView
  def handle_info(
        {ref, {:ok, data}},
        %{assigns: %{data: %RemoteData.Requesting{ref: ref}}} = socket
      ) do
    {:noreply, assign(socket, data: RemoteData.success(data))}
  end

  def handle_info(
        {ref, {:error, _}},
        %{assigns: %{data: %RemoteData.Requesting{ref: ref}}} = socket
      ) do
    {:noreply, assign(socket, data: RemoteData.error("Internal error"))}
  end

  def handle_info(_, socket) do
    {:noreply, socket}
  end

  defp fetch_data(force_error \\ false) do
    LiveViewPatterns.TaskSupervisor.async(fn ->
      Process.sleep(500)

      if force_error do
        {:error, :timeout}
      else
        {:ok, LiveViewPatterns.all_people()}
      end
    end)
  end
end
