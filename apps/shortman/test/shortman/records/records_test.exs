defmodule Shortman.RecordsTest do
  use Shortman.DataCase

  alias Shortman.Records

  describe "links" do
    alias Shortman.Records.Link

    @valid_attrs %{url: "https://themondays.ca"}
    @update_attrs %{url: "https://github.com/themondays"}
    @invalid_attrs %{url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Records.create_link()

      link
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Records.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Records.create_link(@valid_attrs)
      assert link.url == "https://themondays.ca"
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Records.change_link(link)
    end
  end
end
