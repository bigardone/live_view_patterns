defmodule LiveViewPatternsWeb.AsyncRequestsLive do
  use LiveViewPatternsWeb, :live_view

  import __MODULE__.PersonComponent

  alias LiveViewPatternsWeb.RemoteData

  @impl LiveView
  def mount(_params, _session, socket) do
    if connected?(socket) do
      fetch_data()
    end

    socket =
      socket
      |> assign(page_title: "Async requests")
      |> assign(page_name: __MODULE__)
      |> assign(data: RemoteData.requesting())

    {:ok, socket, layout: {LiveViewPatternsWeb.Layouts, :sidebar}}
  end

  @impl LiveView
  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  @impl LiveView
  def handle_info({:fetch_data_result, data}, socket) do
    {:noreply, assign(socket, data: RemoteData.success(data))}
  end

  @impl LiveView
  def render(assigns) do
    ~H"""
    <div>
      <header class="mb-6">
        <h3 class="md:text-xl lg:text-2xl mb-4 text-2xl font-extrabold leading-none tracking-tight text-gray-900">
          Async requests, union types, and skeletons
        </h3>
      </header>

      <section class="gap-x-16 flex bg-white">
        <div class="w-4/6">
          <%= case @data do %>
            <% %RemoteData.Requesting{} -> %>
              <.list_skeleton />
            <% %RemoteData.Success{value: data} -> %>
              <div class="divide-y divide-gray-200 max-w-full">
                <.person :for={person <- data} person={person} />
              </div>
          <% end %>
        </div>
        <div class="w-2/6">
          <div class="sticky top-0 mb-6">
            <p class="text-sm text-gray-500">
              Phoenix is fast. However, sometimes we need data from an external source, and we can't
              control how much time we will spend between requesting the data and rendering it to the user.
            </p>
          </div>
        </div>
      </section>
    </div>
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
