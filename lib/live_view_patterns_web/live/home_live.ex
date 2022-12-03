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
      <div class="max-w-screen-xl lg:py-16 lg:px-12 px-4 py-8 mx-auto text-center">
        <h1 class="md:text-5xl lg:text-6xl mb-6 text-4xl font-extrabold leading-none tracking-tight text-gray-900">
          LiveView Patterns
        </h1>
        <p class="lg:text-2xl sm:px-16 xl:px-48 mb-8 text-lg font-normal text-gray-500">
          Common patterns and practices using Phoenix LiveView.
        </p>
      </div>
    </section>

    <section class="bg-white">
      <div class="max-w-screen-xl lg:py-16 lg:px-12 px-4 py-8 mx-auto">
        <h2 class="md:text-4xl mb-16 text-2xl font-extrabold text-center text-gray-900">
          Latest patterns
        </h2>
        <div class="grid">
          <.link
            navigate={~p"/async-requests-union-types-skeletons"}
            class="hover:bg-gray-100 transition-colors block max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow-md"
          >
            <h5 class="lg:text-xl mb-2 text-lg font-bold tracking-tight text-gray-900">
              Async requests, union types, and skeletons
            </h5>
            <p class="font-normal text-gray-700">
              A helpful pattern that renders some visual feedback while loading data asynchronously.
            </p>
          </.link>
        </div>
      </div>
    </section>
    """
  end
end
