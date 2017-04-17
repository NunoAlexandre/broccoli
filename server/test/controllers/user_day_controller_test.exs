defmodule Server.UserDayControllerTest do
  use Server.ConnCase

  alias Server.UserDay
  @invalid_attrs %{day: %{day: 17, month: 4, year: 2010}, level: :seven, note: "some content"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_day_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user_day = Repo.insert! %UserDay{}
    conn = get conn, user_day_path(conn, :show, user_day)
    assert json_response(conn, 200)["data"] == %{"id" => user_day.id,
      "user_id" => user_day.user_id,
      "day" => user_day.day,
      "level" => user_day.level,
      "note" => user_day.note}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_day_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    {:ok, user} = Repo.insert Server.User.create_changeset(%Server.User{}, %{email: "an email", password: "some content", name: "some content"})
    valid_attrs = %{user_id: user.id, day: %{day: 17, month: 4, year: 2010}, level: :eight, note: "some content"}
    conn = post conn, user_day_path(conn, :create), user_day: valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(UserDay, valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_day_path(conn, :create), user_day: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_day = Repo.insert! %UserDay{}
    conn = put conn, user_day_path(conn, :update, user_day), user_day: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_day = Repo.insert! %UserDay{}
    conn = delete conn, user_day_path(conn, :delete, user_day)
    assert response(conn, 204)
    refute Repo.get(UserDay, user_day.id)
  end
end
