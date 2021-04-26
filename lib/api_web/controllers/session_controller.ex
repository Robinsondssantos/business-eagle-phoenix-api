defmodule ApiWeb.SessionController do
  use ApiWeb, :controller

  def create(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("create.json", message: "hello")
  end
end
