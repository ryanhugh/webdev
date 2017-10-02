# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Microblog.Repo.insert!(%Microblog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Microblog.Repo
alias Microblog.Blog.User
alias Microblog.Blog.Post
alias Microblog.Blog.Follow

Repo.delete_all(Follow)
Repo.delete_all(Post)
Repo.delete_all(User)

ryan = Repo.insert!(%User{name: "Ryan Hughes", passwordHash: "fdjfhasiuf", email: "ryanhughes624@gmail.com", username: "ryanhughes624"})
Repo.insert!(%Post{postid: 2, title: "Hello World", content: "Body here", user_id: ryan.id })

Repo.insert!(%Follow{follower_user_id: ryan.id, following_user_id: ryan.id})
