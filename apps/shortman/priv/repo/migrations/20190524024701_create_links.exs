defmodule Shortman.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add(:url, :text)
      add(:hits, :integer, default: 0)
    end

    create(unique_index(:links, [:url]))
  end
end
