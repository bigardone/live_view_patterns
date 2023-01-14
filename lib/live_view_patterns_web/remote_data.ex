defmodule LiveViewPatternsWeb.RemoteData do
  import ExUnion

  defunion(not_requested | requesting(ref) | success(data) | error(reason))
end
