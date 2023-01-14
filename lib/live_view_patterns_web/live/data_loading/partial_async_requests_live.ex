defmodule LiveViewPatternsWeb.DataLoading.PartialAsyncRequestsLive do
  use LiveViewPatternsWeb, :live_view

  import __MODULE__.UserComponent

  @impl LiveView
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(page_title: "Async requests and partial loading")
      |> assign(page_name: __MODULE__)
      |> assign(data: LiveViewPatterns.all_users())

    {:ok, socket, layout: {LiveViewPatternsWeb.Layouts, :sidebar}}
  end
end
