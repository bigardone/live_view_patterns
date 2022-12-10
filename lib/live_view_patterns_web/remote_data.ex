defmodule LiveViewPatternsWeb.RemoteData do
  import ExUnion

  defunion(not_requested | requesting(ref) | success(value) | error(reason))
end
