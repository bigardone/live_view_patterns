defmodule LiveViewPatternsWeb.AsyncRequestsLive.PartialLoadingLive do
  use LiveViewPatternsWeb, :live_view
  alias LiveViewPatternsWeb.RemoteData
  import LiveViewPatternsWeb.AsyncRequestsLive.PersonComponent

  @impl LiveView
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(page_title: "Async requests and partial loading")
      |> assign(page_name: __MODULE__)
      |> assign(data: RemoteData.not_requested())

    {:ok, socket, layout: {LiveViewPatternsWeb.Layouts, :sidebar}}
  end

  @impl LiveView
  def render(assigns) do
    ~H"""
    <div class="gap-x-16 flex bg-white">
      <section class="gap-x-16 w-4/6">
        <header class="mb-8">
          <h2 class="mb-2 text-sm font-semibold text-purple-700">Async requests</h2>
          <h1 class="md:text-xl lg:text-2xl mb-4 text-2xl font-extrabold leading-none tracking-tight text-gray-900">
            Partial loading
          </h1>
        </header>

        <div class="">
          <h4 class="md:text-lg lg:text-xl mb-4 text-xl font-extrabold leading-none text-gray-900">
            Coming soon...
          </h4>
        </div>
        <.footer />
      </section>
      <div class="w-2/6">
        <div class="space-y-6 top-12 sticky text-sm text-gray-600">
          <div>
            <h5 class="md:text-xs lg:text-sm mb-3 text-sm font-bold leading-none text-gray-900 uppercase">
              Intro
            </h5>
            <p class="">
              Coming soon...
            </p>
          </div>
          <div>
            <h5 class="md:text-xs lg:text-sm mb-3 text-sm font-bold leading-none text-gray-900 uppercase">
              Implementation
            </h5>
            <p class="">
              Coming soon...
            </p>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
