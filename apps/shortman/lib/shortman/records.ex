defmodule Shortman.Records do
  @moduledoc """
  The Records context.
  """

  import Ecto.Query, warn: false
  alias Shortman.Repo

  alias Shortman.Records.Link

  alias Shortman.Records.Hashid

  alias Shortman.Records.Cache

  alias Shortman.Records.QueryCache

  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """
  def list_links do
    Repo.all(Link)
  end

  @doc """
  Gets a single link.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link!(id), do: Repo.get!(Link, id)
  def get_link(id), do: Repo.get(Link, id)

  @doc """
  Gets a single link by hashid.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link_by_hashid!(hashid) do
    case Hashid.decode(hashid) do
      {:ok, data} ->
        Cache.fetch(hashid, fn ->
          case get_link(List.first(data)) do
            link ->
              link
          end
        end)

      _ ->
        nil
    end
  end

  @doc """
  Gets a single link by url.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link_by_url!(url) do
    link = Repo.get_by(Link, url: url)

    if link != nil do
      {:ok,
       %Link{
         id: link.id,
         hashid: link.hashid,
         url: link.url,
         hits: link.hits
       }}
    end

    # QueryCache.fetch(url, fn ->
    #   Repo.get_by!(Link, %{url: url})
    # end)
  end

  @doc """
  Find or create a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def find_or_create_link(attrs \\ %{}) do
    case get_link_by_url!(attrs["url"]) do
      {:ok, link} ->
        {:ok, link}

      _ ->
        %Link{}
        |> Link.changeset(attrs)
        |> Repo.insert()
    end
  end

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_link(attrs \\ %{}) do
    QueryCache.fetch(attrs["url"], fn ->
      %Link{}
      |> Link.changeset(attrs)
      |> Repo.insert()
    end)
  end

  @doc """
  Updates a link.

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{source: %Link{}}

  """
  def change_link(%Link{} = link) do
    Link.changeset(link, %{})
  end
end
