defmodule Microblog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :postId, :integer
      add :title, :string
      add :content, :string
      add :author, :string

      timestamps()
    end

  end
end
