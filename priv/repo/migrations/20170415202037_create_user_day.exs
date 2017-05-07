defmodule Broccoli.Repo.Migrations.CreateUserDay do
  use Ecto.Migration

  def change do
    Level.create_type
    create table(:user_day) do
      add :day, :date, null: false
      add :level, :level, null: false
      add :note, :string, null: false, size: 700, default: ""
      add :user_id, :string, null: false


      timestamps()
    end

    create index(:user_day, [:level])
    create unique_index(:user_day, [:user_id, :day], name: :single_user_day)
  end

  def down do
      drop table(:user_day)
      Level.drop_type
  end
end
