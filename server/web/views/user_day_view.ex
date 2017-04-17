defmodule Server.UserDayView do
  use Server.Web, :view

  def render("index.json", %{user_day: user_day}) do
    %{data: render_many(user_day, Server.UserDayView, "user_day.json")}
  end

  def render("show.json", %{user_day: user_day}) do
    %{data: render_one(user_day, Server.UserDayView, "user_day.json")}
  end

  def render("user_day.json", %{user_day: user_day}) do
    %{id: user_day.id,
      user_id: user_day.user_id,
      day: user_day.day,
      level: user_day.level,
      note: user_day.note}
  end
end
