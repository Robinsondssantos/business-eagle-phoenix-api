defmodule ApiWeb.RevenueView do
  use ApiWeb, :view
  alias ApiWeb.RevenueView

  def render("index.json", %{revenues: revenues}) do
    %{data: render_many(revenues, RevenueView, "revenue.json")}
  end

  def render("show.json", %{revenue: revenue}) do
    %{data: render_one(revenue, RevenueView, "revenue.json")}
  end

  def render("revenue.json", %{revenue: revenue}) do
    %{
      id: revenue.id,
      description: revenue.description,
      client: revenue.client,
      category: revenue.category,
      payday: revenue.payday,
      value: revenue.value,
      status: revenue.status
    }
  end
end
