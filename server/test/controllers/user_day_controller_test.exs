defmodule Server.UserDayControllerTest do
  use Server.ConnCase

  alias Server.UserDay
  @valid_attrs %{note: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_day_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing user day"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_day_path(conn, :new)
    assert html_response(conn, 200) =~ "New user day"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, user_day_path(conn, :create), user_day: @valid_attrs
    assert redirected_to(conn) == user_day_path(conn, :index)
    assert Repo.get_by(UserDay, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_day_path(conn, :create), user_day: @invalid_attrs
    assert html_response(conn, 200) =~ "New user day"
  end

  test "shows chosen resource", %{conn: conn} do
    user_day = Repo.insert! %UserDay{}
    conn = get conn, user_day_path(conn, :show, user_day)
    assert html_response(conn, 200) =~ "Show user day"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_day_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    user_day = Repo.insert! %UserDay{}
    conn = get conn, user_day_path(conn, :edit, user_day)
    assert html_response(conn, 200) =~ "Edit user day"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    user_day = Repo.insert! %UserDay{}
    conn = put conn, user_day_path(conn, :update, user_day), user_day: @valid_attrs
    assert redirected_to(conn) == user_day_path(conn, :show, user_day)
    assert Repo.get_by(UserDay, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_day = Repo.insert! %UserDay{}
    conn = put conn, user_day_path(conn, :update, user_day), user_day: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user day"
  end

  test "deletes chosen resource", %{conn: conn} do
    user_day = Repo.insert! %UserDay{}
    conn = delete conn, user_day_path(conn, :delete, user_day)
    assert redirected_to(conn) == user_day_path(conn, :index)
    refute Repo.get(UserDay, user_day.id)
  end
end
