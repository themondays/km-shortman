defmodule Shortman.Records.Link do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shortman.Records.Hashid

  schema "links" do
    field :hits, :integer, default: 0
    field :url, :string
    field :hashid, :string, virtual: true, null: true, default: nil
    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :hits])
    |> validate_required([:url, :hits])
  end

  @doc """
  Public ID
  """
  defp put_hashid(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{id: id}} ->
        put_change(changeset, :hashid, Hashid.encode(id))

      _ ->
        changeset
    end
  end
end
