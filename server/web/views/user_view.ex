defmodule Server.UserView do
  use Server.Web, :view

  def render("index.json", %{user: user}) do
    %{data: render_many(user, Server.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Server.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      hashed_password: user.hashed_password}
  end
end
