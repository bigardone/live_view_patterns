defmodule LiveViewPatterns.Repo do
  use Ecto.Repo, otp_app: :live_view_patterns, adapter: Etso.Adapter

  use Scrivener, page_size: 10, max_page_size: 100
end
