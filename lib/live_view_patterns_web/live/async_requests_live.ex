defmodule LiveViewPatternsWeb.AsyncRequestsLive do
  use LiveViewPatternsWeb, :live_view

  import __MODULE__.PersonComponent

  alias LiveViewPatternsWeb.RemoteData

  @impl LiveView
  def mount(_params, _session, socket) do
    data =
      if connected?(socket) do
        fetch_data()
        RemoteData.requesting()
      else
        RemoteData.not_requested()
      end

    socket =
      socket
      |> assign(page_title: "Async requests")
      |> assign(page_name: __MODULE__)
      |> assign(data: data)

    {:ok, socket, layout: {LiveViewPatternsWeb.Layouts, :sidebar}}
  end

  @impl LiveView
  def handle_info({:fetch_data_result, data}, socket) do
    {:noreply, assign(socket, data: %RemoteData.Success{value: data})}
  end

  @impl LiveView
  def render(assigns) do
    ~H"""
    <section class="bg-white">
      <header class="mb-8">
        <h3 class="md:text-xl lg:text-2xl text-2xl font-extrabold leading-none tracking-tight text-gray-900">
          Async requests, union types, and skeletons
        </h3>
      </header>

      <%= case @data do %>
        <% %RemoteData.NotRequested{} -> %>
        <% %RemoteData.Requesting{} -> %>
          <.list_skeleton />
        <% %RemoteData.Success{value: data} -> %>
          <div class="divide-y divide-gray-200 max-w-full">
            <.person :for={person <- data} person={person} />
          </div>
      <% end %>
    </section>
    """
  end

  defp fetch_data do
    pid = self()

    Task.Supervisor.start_child(LiveViewPatterns.TaskSupervisor, fn ->
      Process.sleep(500)
      send(pid, {:fetch_data_result, LiveViewPatterns.all_people()})
    end)
  end
end
