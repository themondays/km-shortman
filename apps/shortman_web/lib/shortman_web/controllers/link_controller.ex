defmodule ShortmanWeb.LinkController do
  use ShortmanWeb, :controller

  alias Shortman.Records
  alias Shortman.Records.Link
  alias Shortman.Records.Cache

  action_fallback(ShortmanWeb.FallbackController)

  def create(conn, %{"link" => link_params}) do
    with {:ok, %Link{} = link} <- Records.create_link(link_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.link_path(conn, :show, link))
      |> render("show.json", link: link)
    end
  end

  def show(conn, %{"hashid" => hashid}) do
    if link =
         Cache.fetch(hashid, fn ->
           Records.get_link_by_hashid!(hashid)
         end) do
      conn |> redirect(external: link.url) |> halt()
    else
      conn
      |> put_status(:not_found)
      |> put_view(ShortmanWeb.ErrorView)
      |> render(:"404")
    end
  end
end
