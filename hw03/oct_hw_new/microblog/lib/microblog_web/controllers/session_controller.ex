defmodule MicroblogWeb.SessionController do
  use MicroblogWeb, :controller

  alias Microblog.Accounts

  def login(conn, %{"email" => email}) do
    user = Accounts.get_user_by_email(email)

    if user do
#      post = conn.assigns[:current_post]
#      Microblog.Blog.update_post(post, %{user_id: user.id})

      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Logged in as #{user.email}")
      |> redirect(to: post_path(conn, :index))
    else
      conn
      |> put_session(:user_id, nil)
      |> put_flash(:error, "No such user")
      |> redirect(to: post_path(conn, :index))
    end
  end

  def logout(conn, _args) do
     conn
     |> put_session(:user_id, nil)
     |> put_flash(:info, "Logged out.")
     |> redirect(to: post_path(conn, :index))
  end
end
