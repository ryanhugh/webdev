defmodule MicroblogWeb.PostController do
  import Plug.Conn
  use MicroblogWeb, :controller

  alias Microblog.Blog
  alias Microblog.Blog.Post

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Blog.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)

  end

  def create(conn, %{"post" => post_params}) do
    import Plug.Conn



    IO.puts 'HIIIIIIIII'
    IO.puts :username
    IO.puts :show
    user_id = get_session(conn, :user_id)
    # post_params[:user_id] = user_id
    
    # post_params = %{post_params | :user_id => user_id}


    IO.puts post_params["title"]
    IO.puts user_id

    # "content" => "f", "postid" => "2", "title" => "f"}. This 


    two = %{"content" => "content hererer", "postid" => post_params["postid"], "title" => post_params["title"], "user_id" => 10 }
    # two = %{""}
    
    # IO.puts two["fdafds"]
    # IO.puts post_params
    IO.puts 'HIIIIIIIII'



    # IO.puts 'hi'
    case Blog.create_post(two) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
