defmodule Microblog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Post


  schema "posts" do
    field :content, :string
    field :postId, :integer
    field :title, :string
    field :author, :id

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:postId, :title, :content])
    |> validate_required([:postId, :title, :content])
  end
end
