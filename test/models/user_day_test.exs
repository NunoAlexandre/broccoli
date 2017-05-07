defmodule Broccoli.UserDayTest do
  use Broccoli.ModelCase

  alias Broccoli.UserDay

  @empty_attrs %{}
  @valid_attrs %{user_id: "1jkehfgrjdvb", day: %{day: 17, month: 4, year: 2010}, level: :eight, note: "some content"}
  @invalid_attrs %{user_id: 837438792, day: %{day: 17, month: 4, year: 2010}, level: :seven, note: "some content"}

  test "changeset with valid attributes" do
    changeset = UserDay.changeset(%UserDay{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with empty attributes" do
    changeset = UserDay.changeset(%UserDay{}, @empty_attrs)
    refute changeset.valid?
  end

  test "changeset with incorrect user_id and invalid level" do
    changeset = UserDay.changeset(%UserDay{}, @invalid_attrs)
    refute changeset.valid?
  end
end
