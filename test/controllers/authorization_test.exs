defmodule Broccoli.AuthorizationTest do
  use Broccoli.ConnCase

  @valid_auth0_token "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJicm9jY29saS5uYWxleGFuZHJlLnRlc3QiLCJpYXQiOjE0OTQxMDQzOTIsImV4cCI6MzMwODI1NDkxOTIsImF1ZCI6InRlc3QiLCJzdWIiOiJhdXRoMHw1OTA4ZTQ3MThmY2I2MW5wMzg3ZTIzZjIifQ.urFUtu9x6dHH2A4UDAAefIgGZSk_2eTWGE-c1DYTEfs"
  @invalid_auth0_token "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE0OTQxMDQ3MjMsImV4cCI6MTUyNTY0MDcyMywiYXVkIjoid3d3LmV4YW1wbGUuY29tIiwic3ViIjoianJvY2tldEBleGFtcGxlLmNvbSIsIkdpdmVuTmFtZSI6IkpvaG5ueSIsIlN1cm5hbWUiOiJSb2NrZXQiLCJFbWFpbCI6Impyb2NrZXRAZXhhbXBsZS5jb20iLCJSb2xlIjpbIk1hbmFnZXIiLCJQcm9qZWN0IEFkbWluaXN0cmF0b3IiXX0.u_amUvZYIxeVRi5VSZm2CLkt1EdYT6FpZpYJcvMcxF0"

  setup %{conn: conn} do
     conn = conn
        |> put_req_header("accept", "application/json")
        |> put_req_header("authorization",  "Bearer " <> @valid_auth0_token)
     {:ok, conn: conn}
   end

  test "Response is 200 with valiid token", %{conn: conn} do
    conn = conn |> put_req_header("authorization",  "Bearer " <> @valid_auth0_token)
    conn = get conn, user_day_path(conn, :index)
    assert json_response(conn, 200)
  end

  test "Response is 401 with invalid token", %{conn: conn} do
    conn = conn |> put_req_header("authorization",  "Bearer " <> @invalid_auth0_token)
    conn = get conn, user_day_path(conn, :index)
    assert json_response(conn, 401)
  end

end
