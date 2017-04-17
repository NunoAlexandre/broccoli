defmodule Server.UserDayView do
  use Server.Web, :view

  def render("create.json", %{user_day: user_day}), do: user_day

end
