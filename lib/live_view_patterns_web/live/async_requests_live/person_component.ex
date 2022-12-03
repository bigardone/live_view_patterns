defmodule LiveViewPatternsWeb.AsyncRequestsLive.PersonComponent do
  use Phoenix.Component

  alias LiveViewPatterns.Schemas.Person

  def person(assigns) do
    ~H"""
    <div
      id={"person_#{@person.id}"}
      class="first-of-type:bt-gray-200 first-of-type:border-t flex items-center justify-between px-2 py-4"
    >
      <div class="w-1/12">
        <img class="w-10 h-10 rounded-full" src={@person.avatar_url} alt="Rounded avatar" />
      </div>
      <div class="w-10/12">
        <div class="font-bold"><%= Person.full_name(@person) %></div>
        <div class="text-sm text-gray-600"><%= @person.email %></div>
      </div>
      <div class="w-2/12 text-right">
        <span class="px-2.5 py-0.5 inline-flex items-center text-xs font-medium text-gray-800 bg-gray-100 rounded">
          <svg
            aria-hidden="true"
            class="w-3 h-3 mr-1"
            fill="currentColor"
            viewBox="0 0 20 20"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              fill-rule="evenodd"
              d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z"
              clip-rule="evenodd"
            >
            </path>
          </svg>
          3 days ago
        </span>
      </div>
    </div>
    """
  end
end
