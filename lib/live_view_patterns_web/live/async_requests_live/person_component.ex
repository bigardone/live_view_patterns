defmodule LiveViewPatternsWeb.AsyncRequestsLive.PersonComponent do
  use Phoenix.Component

  alias LiveViewPatterns.Schemas.Person

  def person(assigns) do
    ~H"""
    <div
      id={"person_#{@person.id}"}
      class="first-of-type:bt-gray-200 first-of-type:border-t gap-x-4 flex items-center justify-between px-2 py-4"
    >
      <div class="w-1/12">
        <img class="w-10 h-10 rounded-full" src={@person.avatar_url} alt="Rounded avatar" />
      </div>
      <div class="w-7/12">
        <div class="font-bold"><%= Person.full_name(@person) %></div>
        <div class="gap-x-1 flex items-end text-sm leading-none text-gray-600">
          <Heroicons.envelope class="h-[11px] text-gray-300" solid /><%= @person.email %>
        </div>
      </div>
      <div class="w-4/12 text-right">
        <span class="px-2.5 py-0.5 gap-x-1 inline-flex items-center text-sm font-semibold text-gray-800 bg-gray-100 rounded">
          <Heroicons.phone solid={true} class="h-[11px] text-gray-400" /> <%= @person.phone_number %>
        </span>
      </div>
    </div>
    """
  end
end
