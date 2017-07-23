defmodule Broccoli.UserDayTest do
  use Broccoli.ModelCase

  alias Broccoli.UserDay

  @empty_attrs %{}
  @valid_attrs %{uid: "1jkehfgrjdvb", day: %{day: 17, month: 4, year: 2010}, level: 7, note: "some content"}
  @invalid_attrs %{uid: 837438792, day: %{day: 17, month: 4, year: 2010}, level: 8, note: "some content"}

  test "changeset with level within range" do
    assert UserDay.changeset(%UserDay{}, user_day_with_level(1)).valid?
    assert UserDay.changeset(%UserDay{}, user_day_with_level(2)).valid?
    assert UserDay.changeset(%UserDay{}, user_day_with_level(3)).valid?
    assert UserDay.changeset(%UserDay{}, user_day_with_level(4)).valid?
    assert UserDay.changeset(%UserDay{}, user_day_with_level(5)).valid?
    assert UserDay.changeset(%UserDay{}, user_day_with_level(6)).valid?
    assert UserDay.changeset(%UserDay{}, user_day_with_level(6)).valid?
  end

  test "changeset with valid attributes" do
    changeset = UserDay.changeset(%UserDay{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with empty attributes" do
    changeset = UserDay.changeset(%UserDay{}, @empty_attrs)
    refute changeset.valid?
  end

  test "changeset with incorrect uid and invalid level" do
    changeset = UserDay.changeset(%UserDay{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with level smaller than 1" do
    refute UserDay.changeset(%UserDay{}, user_day_with_level(0)).valid?
    refute UserDay.changeset(%UserDay{}, user_day_with_level(-1)).valid?
    refute UserDay.changeset(%UserDay{}, user_day_with_level(-2)).valid?
    refute UserDay.changeset(%UserDay{}, user_day_with_level(-3)).valid?
  end

  test "changeset with level bigger than 7" do
    refute UserDay.changeset(%UserDay{}, user_day_with_level(8)).valid?
    refute UserDay.changeset(%UserDay{}, user_day_with_level(9)).valid?
    refute UserDay.changeset(%UserDay{}, user_day_with_level(10)).valid?
    refute UserDay.changeset(%UserDay{}, user_day_with_level(11)).valid?
  end

  def user_day_with_level(level) do
    %{uid: "1jkehfgrjdvb", day: %{day: 17, month: 4, year: 2010}, level: level, note: "some content"}
  end
end
