defmodule ApiWeb.SessionView do
  use ApiWeb, :view

  def render("create.json", %{message: message}) do
    %{
      message: message
    }
  end
end
