defmodule Microblog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :passwordHash, :string
      add :email, :string
      add :username, :string

      timestamps()
    end

  end
end