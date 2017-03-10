defmodule Server.UserTest do
  use Server.ModelCase

  alias Server.User

  @valid_attrs %{birth_date: %{day: 17, month: 4, year: 2010}, crypted_password: "some content", email: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
