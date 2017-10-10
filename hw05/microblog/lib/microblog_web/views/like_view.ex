defmodule MicroblogWeb.LikeView do
  use MicroblogWeb, :view
  alias MicroblogWeb.LikeView

  def render("index.json", %{likes: likes}) do
    %{data: render_many(likes, LikeView, "like.json")}
  end

  def render("show.json", %{like: like}) do
    %{data: render_one(like, LikeView, "like.json")}
  end

  # def render("like.json", %{like: like}) do
  #   %{id: like.id}
  # end


  def render("like.json", %{like: like}) do
    data = %{
      id: like.id,
      post_id: like.post_id,
    }

    if Ecto.assoc_loaded?(like.user) do
      Map.put(data, :email, like.user.email)
    else
      data
    end
  end
end
