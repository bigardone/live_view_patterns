defmodule LiveViewPatternsWeb.CoreComponents do
  @moduledoc """
  Provides core UI components.

  The components in this module use Tailwind CSS, a utility-first CSS framework.
  See the [Tailwind CSS documentation](https://tailwindcss.com) to learn how to
  customize the generated components in this module.

  Icons are provided by [heroicons](https://heroicons.com), using the
  [heroicons_elixir](https://github.com/mveytsman/heroicons_elixir) project.
  """
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  @doc """
  Renders flash notices.

  ## Examples

      <.flash kind={:info} flash={@flash} />
      <.flash kind={:info} phx-mounted={show("#flash")}>Welcome Back!</.flash>
  """
  attr :id, :string, default: "flash", doc: "the optional id of flash container"
  attr :flash, :map, default: %{}, doc: "the map of flash messages to display"
  attr :title, :string, default: nil
  attr :kind, :atom, values: [:info, :error], doc: "used for styling and flash lookup"
  attr :autoshow, :boolean, default: true, doc: "whether to auto show the flash on mount"
  attr :close, :boolean, default: true, doc: "whether the flash can be closed"
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the flash container"

  slot :inner_block, doc: "the optional inner block that renders the flash message"

  def flash(assigns) do
    ~H"""
    <div
      :if={msg = render_slot(@inner_block) || Phoenix.Flash.get(@flash, @kind)}
      id={@id}
      phx-mounted={@autoshow && show("##{@id}")}
      phx-click={JS.push("lv:clear-flash", value: %{key: @kind}) |> hide("#flash")}
      role="alert"
      class={[
        "fixed hidden top-2 right-2 w-80 sm:w-96 z-50 rounded-lg p-3 shadow-md shadow-zinc-900/5 ring-1",
        @kind == :info && "bg-emerald-50 text-emerald-800 ring-emerald-500 fill-cyan-900",
        @kind == :error && "bg-rose-50 p-3 text-rose-900 shadow-md ring-rose-500 fill-rose-900"
      ]}
      {@rest}
    >
      <p :if={@title} class="flex items-center gap-1.5 text-[0.8125rem] font-semibold leading-6">
        <Heroicons.information_circle :if={@kind == :info} mini class="w-4 h-4" />
        <Heroicons.exclamation_circle :if={@kind == :error} mini class="w-4 h-4" />
        <%= @title %>
      </p>
      <p class="mt-2 text-[0.8125rem] leading-5"><%= msg %></p>
      <button :if={@close} type="button" class="group top-2 right-1 absolute p-2" aria-label="close">
        <Heroicons.x_mark solid class="opacity-40 group-hover:opacity-70 w-5 h-5 stroke-current" />
      </button>
    </div>
    """
  end

  @doc """
  Renders a list skeleton placeholder
  """
  attr(:lines, :integer, default: 15)

  def list_skeleton(assigns) do
    ~H"""
    <div role="status" class="divide-y divide-gray-200 animate-pulse max-w-full">
      <div
        :for={_ <- 1..@lines}
        class="first-of-type:bt-gray-200 first-of-type:border-t gap-x-4 flex items-center justify-between px-2 py-4"
      >
        <div class="w-1/12">
          <div class="w-10 h-10 bg-gray-200 rounded-full" />
        </div>
        <div class="w-5/12">
          <div class="mb-3.5 w-24 h-3 bg-gray-200 rounded-full"></div>
          <div class="h-2.5 w-32 bg-gray-200 rounded-full"></div>
        </div>
        <div class="grid grid-cols-2 gap-x-6 w-6/12">
          <div :for={_ <- 1..2}>
            <div class="w-14 h-2 mb-2 bg-gray-200 rounded-full" />
            <div class="rounded-md w-12 h-8 bg-gray-200" />
          </div>
        </div>
      </div>
      <span class="sr-only">Loading...</span>
    </div>
    """
  end

  @doc """
  Renders a navigation link
  """
  attr(:path, :string, required: true)
  attr(:active, :boolean, default: false)

  slot(:inner_block, required: true)

  def navigation_link(assigns) do
    ~H"""
    <.link
      navigate={@path}
      class={[
        "flex items-center pl-4 text-sm transition-colors",
        @active && "text-purple-700 font-semibold border-l border-purple-700",
        not @active &&
          "hover:text-gray-900 text-gray-600 border-l hover:border-gray-700 border-transparent"
      ]}
    >
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  attr(:id, :string, required: true)
  attr(:title, :string, required: true)
  attr(:close_patch, :string, required: true)

  slot(:inner_block, required: true)

  def drawer(assigns) do
    ~H"""
    <.link
      class="bg-opacity-0 transition-colors fixed inset-0 z-30 bg-gray-900"
      patch={@close_patch}
      phx-mounted={show_backdrop()}
      phx-remove={hide_backdrop()}
    >
    </.link>
    <div
      id={@id}
      class="transition-transform translate-x-full fixed top-0 right-0 z-40 w-2/5 h-screen overflow-y-auto bg-white"
      tabindex="-1"
      aria-labelledby="drawer-right-label"
      aria-hidden="true"
      phx-mounted={show_content()}
      phx-remove={hide_content()}
    >
      <header class="relative flex items-center p-4 mb-4 border-b">
        <h5 id="drawer-right-label" class="text-base font-semibold text-gray-800">
          <%= @title %>
        </h5>
        <.link
          class="hover:bg-gray-200 hover:text-gray-900 p-1.5 top-1/2 -translate-y-1/2 right-4 absolute items-center text-sm text-gray-400 bg-transparent rounded-full"
          patch={@close_patch}
        >
          <Heroicons.x_mark class="w-4 h-4" />
          <span class="sr-only">Close menu</span>
        </.link>
      </header>
      <div class="p-4">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  slot(:inner_block, required: true)

  def code(assigns) do
    ~H"""
    <span class="font-mono text-xs text-gray-700 bg-gray-200"><%= render_slot(@inner_block) %></span>
    """
  end

  attr(:patch, :string)
  attr(:click, JS)

  slot(:inner_block, required: true)

  def action_button(%{patch: _} = assigns) do
    ~H"""
    <.link patch={@patch} class={action_button_class()}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  def action_button(%{click: _} = assigns) do
    ~H"""
    <button class={action_button_class()} phx-click={@click}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  slot(:inner_block, required: true)

  def browser_window(assigns) do
    ~H"""
    <div class="rounded-md shadow-xl">
      <div class="rounded-t-md gap-x-2 bg-slate-700 flex items-center p-3">
        <div class="w-3 h-3 bg-red-500 rounded-full"></div>
        <div class="w-3 h-3 bg-yellow-500 rounded-full"></div>
        <div class="w-3 h-3 bg-green-500 rounded-full"></div>
        <div class="bg-slate-900 w-1/2 p-2 ml-4 rounded"></div>
      </div>
      <div class="rounded-b-md p-4 border">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp show_content do
    %JS{}
    |> JS.set_attribute({"role", "dialog"})
    |> JS.remove_class("translate-x-full")
  end

  defp hide_content do
    %JS{}
    |> JS.remove_attribute("role")
    |> JS.transition("translate-x-full", time: 200)
  end

  defp show_backdrop do
    %JS{}
    |> JS.add_class("bg-opacity-50")
    |> JS.remove_class("bg-opacity-0")
  end

  defp hide_backdrop do
    JS.transition("bg-opacity-0", time: 200)
  end

  ## JS Commands

  def show(js \\ %JS{}, selector) do
    JS.show(js,
      to: selector,
      transition:
        {"transition-all transform ease-out duration-300",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
         "opacity-100 translate-y-0 sm:scale-100"}
    )
  end

  def hide(js \\ %JS{}, selector) do
    JS.hide(js,
      to: selector,
      time: 200,
      transition:
        {"transition-all transform ease-in duration-200",
         "opacity-100 translate-y-0 sm:scale-100",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"}
    )
  end

  defp action_button_class do
    "bg-gray-100 hover:text-gray-900 hover:bg-gray-200 transition-colors inline-flex items-center gap-x-1 justify-center px-5 py-2 text-sm font-medium text-gray-600 rounded"
  end
end
