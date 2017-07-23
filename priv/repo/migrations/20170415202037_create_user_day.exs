defmodule Broccoli.Repo.Migrations.CreateUserDay do
  use Ecto.Migration

  def change do
    create table(:user_day) do
      add :day, :date, null: false
      add :level, :integer, null: false
      add :note, :string, null: false, size: 700, default: ""
      add :uid, :string, null: false


      timestamps()
    end

    create index(:user_day, [:level])
    create unique_index(:user_day, [:uid, :day], name: :single_user_day)
  end

  def down do
      drop table(:user_day)
  end
end
