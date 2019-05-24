defmodule ShortmanAPI.LinkView do
  use ShortmanAPI, :view
  alias ShortmanAPI.LinkView
  alias Shortman.Records.Hashid

  def render("index.json", %{links: links}) do
    %{data: render_many(links, LinkView, "link.json")}
  end

  def render("show.json", %{link: link}) do
    %{data: render_one(link, LinkView, "link.json")}
  end

  def render("link.json", %{link: link}) do
    hashid = Hashid.encode(link.id)

    %{
      id: link.id,
      url: link.url,
      hashid: hashid,
      hits: link.hits,
      short_url: "#{ShortmanWeb.Endpoint.url()}/#{hashid}"
    }
  end
end
