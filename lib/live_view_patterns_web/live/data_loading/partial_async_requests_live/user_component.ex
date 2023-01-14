defmodule LiveViewPatternsWeb.DataLoading.PartialAsyncRequestsLive.UserComponent do
  use Phoenix.Component

  alias LiveViewPatterns.Schemas.User

  def user(assigns) do
    ~H"""
    <div
      id={"person_#{@user.id}"}
      class="first-of-type:bt-gray-200 first-of-type:border-t gap-x-4 flex items-center justify-between px-2 py-4"
    >
      <div class="w-1/12">
        <img class="w-10 h-10 rounded-full" src={@user.avatar_url} alt="Rounded avatar" />
      </div>
      <div class="w-5/12">
        <div class="font-bold"><%= User.full_name(@user) %></div>
        <div class="gap-x-1 flex items-end text-sm leading-none text-gray-600">
          <Heroicons.envelope class="h-[11px] text-gray-300" solid /><%= @user.email %>
        </div>
      </div>
      <div class="flex items-center justify-center w-6/12">
        <div class="animate-pulse h-2.5 w-12 ml-auto bg-gray-300 rounded-full"></div>
      </div>
    </div>
    """
  end
end
