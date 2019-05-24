defmodule ShortmanAPI.LinkControllerTest do
  use ShortmanAPI.ConnCase

  alias Shortman.Records
  alias Shortman.Records.Link

  @create_attrs %{
    hits: 42,
    url: "https://google.com"
  }
  @update_attrs %{
    hits: 43,
    url: "https://github.com/themondays"
  }
  @invalid_attrs %{hits: nil, url: nil}

  def fixture(:link) do
    {:ok, link} = Records.create_link(@create_attrs)
    link
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create link" do
    test "renders link when data is valid", %{conn: conn} do
      conn = post(conn, Routes.link_path(conn, :create), link: @create_attrs)
      assert %{"id" => id, "short_url" => short_url} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.link_path(conn, :show, id))

      assert %{
               "id" => id,
               "hits" => 42,
               "short_url" => short_url,
               "url" => "https://google.com"
             } = json_response(conn, 200)["data"]
    end
  end

  defp create_link(_) do
    link = fixture(:link)
    {:ok, link: link}
  end
end
