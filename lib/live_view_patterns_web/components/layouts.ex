defmodule LiveViewPatternsWeb.Layouts do
  use LiveViewPatternsWeb, :html

  embed_templates "layouts/*"

  def footer(assigns) do
    ~H"""
    <footer class="md:flex md:items-center md:justify-between flex items-center py-10 mt-24 bg-white border-t">
      <span class="sm:text-center text-sm text-gray-500">
        © <%= DateTime.utc_now().year %> LiveView Patterns.
        Crafted with <span class="text-pink-600">♥</span>
        by <a href="https://bigardone.dev" class="underline" target="_blank">bigardone</a>.
      </span>
      <ul class="flex flex-wrap items-center text-sm text-gray-500">
        <li>
          <a href="https://github.com/bigardone/live_view_patterns" class="underline" target="_blank">
            Source code
          </a>
        </li>
      </ul>
    </footer>
    """
  end
end
