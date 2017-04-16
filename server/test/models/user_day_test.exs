defmodule Server.UserDayTest do
  use Server.ModelCase

  alias Server.UserDay

  @valid_attrs %{note: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserDay.changeset(%UserDay{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserDay.changeset(%UserDay{}, @invalid_attrs)
    refute changeset.valid?
  end
end
