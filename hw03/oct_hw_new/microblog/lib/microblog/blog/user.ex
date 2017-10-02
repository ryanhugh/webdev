defmodule Microblog.Blog.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :passwordHash, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :passwordHash, :email, :username])
    |> validate_required([:name, :passwordHash, :email, :username])
  end
end
