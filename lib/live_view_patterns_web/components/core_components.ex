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
  attr(:lines, :integer, default: 10)

  def list_skeleton(assigns) do
    ~H"""
    <div role="status" class="divide-y divide-gray-200 animate-pulse max-w-full">
      <div
        :for={_ <- 1..@lines}
        class="first-of-type:bt-gray-200 first-of-type:border-t flex items-center justify-between px-2 py-4"
      >
        <div class="w-1/12">
          <div class="w-10 h-10 bg-gray-300 rounded-full" />
        </div>
        <div class="w-10/12">
          <div class="mb-3.5 w-24 h-3 bg-gray-300 rounded-full"></div>
          <div class="h-2.5 w-32 bg-gray-200 rounded-full"></div>
        </div>
        <div class="w-1/12">
          <div class="h-2.5 w-12 ml-auto bg-gray-300 rounded-full"></div>
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
        "hover:bg-gray-100 group flex items-center p-2 text-sm font-normal text-gray-900 rounded-lg",
        @active && "font-bold"
      ]}
    >
      <%= render_slot(@inner_block) %>
    </.link>
    """
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
end
