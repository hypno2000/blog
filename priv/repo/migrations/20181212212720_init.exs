defmodule Blog.Repo.Migrations.Init do
  use Ecto.Migration

  def change do
    create table(:sections) do
      add(:name, :string)
    end

    create table(:countries) do
      add(:name, :string)
    end

    create table(:languages) do
      add(:name, :string)
    end

    create table(:users) do
      add(:name, :string)
      add(:country_id, references(:countries, on_delete: :nothing))
      add(:language_id, references(:languages, on_delete: :nothing))
    end

    create table(:posts) do
      add(:name, :string)
      add(:section_id, references(:sections, on_delete: :nothing))
      add(:user_id, references(:users, on_delete: :nothing))
    end
  end
end
