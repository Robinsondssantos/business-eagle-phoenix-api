defmodule ApiWeb.RevenueController do
  use ApiWeb, :controller

  alias Api.Revenues
  alias Api.Revenues.Revenue

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    revenues = Revenues.list_revenues()
    render(conn, "index.json", revenues: revenues)
  end

  def create(conn, %{"revenue" => revenue_params}) do
    with {:ok, %Revenue{} = revenue} <- Revenues.create_revenue(revenue_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.revenue_path(conn, :show, revenue))
      |> render("show.json", revenue: revenue)
    end
  end

  def show(conn, %{"id" => id}) do
    revenue = Revenues.get_revenue!(id)
    render(conn, "show.json", revenue: revenue)
  end

  def update(conn, %{"id" => id, "revenue" => revenue_params}) do
    revenue = Revenues.get_revenue!(id)

    with {:ok, %Revenue{} = revenue} <- Revenues.update_revenue(revenue, revenue_params) do
      render(conn, "show.json", revenue: revenue)
    end
  end

  def delete(conn, %{"id" => id}) do
    revenue = Revenues.get_revenue!(id)

    with {:ok, %Revenue{}} <- Revenues.delete_revenue(revenue) do
      send_resp(conn, :no_content, "")
    end
  end
end
