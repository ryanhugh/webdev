defmodule Microblog.Blog.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Like


  schema "likes" do
    field :liked, :string
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(%Like{} = like, attrs) do
    like
    |> cast(attrs, [:liked, :user])
    |> validate_required([:liked, :user])
  end
end
