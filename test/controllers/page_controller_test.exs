defmodule Broccoli.PageControllerTest do
  use Broccoli.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Broccoli!"
  end
end
