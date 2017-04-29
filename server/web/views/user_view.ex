defmodule Server.UserView do
  use Server.Web, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Server.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email}
  end
end
