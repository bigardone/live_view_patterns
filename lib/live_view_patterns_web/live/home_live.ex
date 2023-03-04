defmodule LiveViewPatternsWeb.HomeLive do
  use LiveViewPatternsWeb, :live_view

  @impl LiveView
  def mount(_params, _session, socket) do
    socket = assign(socket, page_title: "Home")

    {:ok, socket}
  end

  @impl LiveView
  def render(assigns) do
    ~H"""
    <section class="bg-white">
      <div class="lg:py-16 lg:px-12 px-4 py-8 mx-auto text-center">
        <h1 class="md:text-5xl lg:text-6xl mb-6 text-4xl font-black leading-none tracking-tight text-purple-700">
          LiveView Patterns
        </h1>
        <p class="lg:text-2xl sm:px-16 xl:px-48 mb-8 text-lg font-semibold">
          Common patterns and practices using Phoenix LiveView.
        </p>
      </div>
    </section>

    <section class="bg-white">
      <div class="lg:py-16 lg:px-12 px-4 py-8 mx-auto">
        <h2 class="md:text-3xl mb-16 text-3xl font-bold text-center text-gray-900">
          Latest patterns
        </h2>
        <div class="grid grid-cols-2 lg:grid-cols-3 gap-6">
          <.link
            navigate={~p"/data-loading/async-requests"}
            class="hover:shadow-xl hover:scale-105 transition-all block max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow-md"
          >
            <h4 class="mb-1 text-sm font-semibold text-purple-700">Data loading</h4>
            <h3 class="md:text-lg mb-2 text-lg font-bold tracking-tight text-gray-900">
              Async requests
            </h3>
            <p class="font-normal text-gray-600">
              A helpful pattern that renders some visual feedback while loading data asynchronously.
            </p>
          </.link>
          <.link
            navigate={~p"/data-loading/partial-async-requests"}
            class="hover:shadow-xl hover:scale-105 transition-all block max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow-md"
          >
            <h4 class="mb-1 text-sm font-semibold text-purple-700">Data loading</h4>
            <h3 class="md:text-lg mb-2 text-lg font-bold tracking-tight text-gray-900">
              Partial async requests
            </h3>
            <p class="font-normal text-gray-600">
              A helpful pattern that renders some visual feedback while loading data asynchronously.
            </p>
          </.link>
        </div>
      </div>
    </section>
    """
  end
end
