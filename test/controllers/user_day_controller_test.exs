defmodule Broccoli.UserDayControllerTest do
  use Broccoli.ConnCase

  alias Broccoli.UserDay

  @valid_attrs %{day: %{day: 7, month: 5, year: 2017}, level: :eight, note: "some content"}
  @invalid_attrs %{day: %{day: 17, month: 4, year: 2010}, level: :seven, note: "some content"}
  @valid_auth0_token "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJicm9jY29saS5uYWxleGFuZHJlLnRlc3QiLCJpYXQiOjE0OTQxMDQzOTIsImV4cCI6MzMwODI1NDkxOTIsImF1ZCI6InRlc3QiLCJzdWIiOiJhdXRoMHw1OTA4ZTQ3MThmY2I2MW5wMzg3ZTIzZjIifQ.urFUtu9x6dHH2A4UDAAefIgGZSk_2eTWGE-c1DYTEfs"

  setup %{conn: conn} do
     conn = conn
        |> put_req_header("accept", "application/json")
        |> put_req_header("authorization",  "Bearer " <> @valid_auth0_token)
     {:ok, conn: conn}
   end

  test "empty list when fetching all users entries", %{conn: conn} do
    conn = get conn, user_day_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "showing all user entries", %{conn: conn} do
    inserted_user_day("5908e47otheruserid7e23f2")
    user_day = inserted_user_day("5908e4718fcb61np387e23f2")
    conn = get conn, user_day_path(conn, :index)
    assert json_response(conn, 200)["data"] == [%{"id" => user_day.id,
                                                  "day" => to_string(user_day.day),
                                                  "level" => to_string(user_day.level),
                                                  "note" => user_day.note,
                                                  "uid" => user_day.uid}]
  end

  test "shows chosen resource", %{conn: conn} do
    user_day = inserted_user_day("5908e4718fcb61np387e23f2")
    conn = get conn, user_day_path(conn, :show, user_day)
    assert json_response(conn, 200)["data"] == %{ "id" => user_day.id,
                                                  "uid" => user_day.uid,
                                                  "day" => to_string(user_day.day),
                                                  "level" => to_string(user_day.level),
                                                  "note" => user_day.note }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_day_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_day_path(conn, :create), user_day: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(UserDay, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_day_path(conn, :create), user_day: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    conn = put conn, user_day_path(conn, :update, inserted_user_day("5908e4718fcb61np387e23f2")), user_day: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_day = inserted_user_day("5908e4718fcb61np387e23f2")
    conn = delete conn, user_day_path(conn, :delete, user_day)
    assert response(conn, 204)
    refute Repo.get(UserDay, user_day.id)
  end


  defp inserted_user_day(uid) do
    Repo.insert! UserDay.changeset(%UserDay{uid: uid}, @valid_attrs)
  end
end
