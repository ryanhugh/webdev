defmodule Microblog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Post


  schema "posts" do
    field :author, :string
    field :content, :string
    field :postId, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:postId, :title, :content, :author])
    |> validate_required([:postId, :title, :content, :author])
  end
end
