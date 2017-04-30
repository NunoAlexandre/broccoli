defmodule Broccoli.PageController do
  use Broccoli.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
