defmodule LiveViewPatternsWeb.DataLoading.AsyncRequestsLive.UserComponent do
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
      <div class="w-7/12">
        <div class="font-bold"><%= User.full_name(@user) %></div>
        <div class="flex items-end text-sm leading-none text-gray-600">
          <Heroicons.envelope class="h-[11px] text-gray-300 mr-1" solid /> <%= @user.email %>
        </div>
      </div>
      <div class="grid grid-cols-2 gap-x-6 w-4/12">
        <.stats text="Num. tasks" value={@user.stats.finished_tasks} />
        <.stats text="Time" value={"#{Float.round(@user.stats.tracked_time / 3600, 1)}h"} />
      </div>
    </div>
    """
  end

  attr :text, :string, required: true
  attr :value, :string, required: true

  defp stats(assigns) do
    ~H"""
    <div>
      <div class="text-xs text-gray-400"><%= @text %></div>
      <div class="text-2xl font-bold"><%= @value %></div>
    </div>
    """
  end
end
