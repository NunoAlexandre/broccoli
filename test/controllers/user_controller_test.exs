defmodule Broccoli.UserControllerTest do
  use Broccoli.ConnCase

  alias Broccoli.User
  @valid_attrs_create %{email: "some content", password: "some content", name: "some content"}
  @valid_attrs %{email: "some content", name: "some content"}
  @invalid_attrs %{email: nil}

  setup %{conn: conn} do
     conn = conn
        |> put_req_header("accept", "application/json")
        |> put_req_header("authorization",  "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJicm9jY29saS5uYWxleGFuZHJlLnRlc3QiLCJpYXQiOjE0OTQwOTU2NTEsImV4cCI6MzMwODI1NDA0NTEsImF1ZCI6InRlc3QiLCJzdWIiOiJ0ZXN0In0.JRwyymlxlWdybR91vmo1keQtmcaQiZIZEQ2MoFXdrCE")
     {:ok, conn: conn}
   end



  test "shows chosen resource", %{conn: conn} do
    user = inserted_user()
    conn = get conn, user_path(conn, :show, user)
    assert json_response(conn, 200)["data"] == %{"id" => user.id,
      "name" => user.name,
      "email" => user.email}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs_create
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user = inserted_user()
    conn = put conn, user_path(conn, :update, user), user: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user = inserted_user()
    conn = put conn, user_path(conn, :update, %User{id: user.id}), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user = inserted_user()
    conn = delete conn, user_path(conn, :delete, user)
    assert response(conn, 204)
    refute Repo.get(User, user.id)
  end


  defp inserted_user do
    Repo.insert! Broccoli.User.create_changeset(%User{}, @valid_attrs_create)
  end
end
