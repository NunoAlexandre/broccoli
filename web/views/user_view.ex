defmodule Broccoli.UserView do
  use Broccoli.Web, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Broccoli.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email}
  end
end
