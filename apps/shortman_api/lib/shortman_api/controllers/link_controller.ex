defmodule ShortmanAPI.LinkController do
  use ShortmanAPI, :controller

  alias Shortman.Records

  alias Shortman.Records.Link

  action_fallback ShortmanAPI.FallbackController

  def index(conn, _params) do
    links = Records.list_links()
    render(conn, "index.json", links: links)
  end

  def submit(conn, %{"link" => link_params}) do
    process =
      spawn(fn ->
        Records.create_link(link_params)
      end)

    send_resp(conn, 200, Jason.encode!(%{success: true, pid: inspect(process)}))
  end

  def create(conn, %{"link" => link_params}) do
    result = Records.create_link(link_params)

    {:ok, %Link{} = link} = result

    conn
    |> put_status(:created)
    |> put_resp_header("location", Routes.link_path(conn, :show, link))
    |> render("show.json", link: link)
  end

  def show(conn, %{"id" => id}) do
    link = Records.get_link_by_hashid!(id)
    render(conn, "show.json", link: link)
  end
end
