defmodule LiveViewPatternsWeb.RemoteData do
  import ExUnion

  defunion(not_requested | requesting | success(value) | error(reason))
end
