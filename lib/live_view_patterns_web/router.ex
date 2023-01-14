defmodule LiveViewPatternsWeb.Router do
  use LiveViewPatternsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LiveViewPatternsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", LiveViewPatternsWeb do
    pipe_through :browser

    live_session :default do
      live "/", HomeLive

      scope "/data-loading", DataLoading do
        live "/async-requests", AsyncRequestsLive
        live "/partial-async-requests", PartialAsyncRequestsLive
      end
    end
  end
end
