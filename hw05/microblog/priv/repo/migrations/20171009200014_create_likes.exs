defmodule Microblog.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :liked, :string
      add :user, :string

      timestamps()
    end

  end
end
