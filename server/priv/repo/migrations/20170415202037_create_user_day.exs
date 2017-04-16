defmodule Server.Repo.Migrations.CreateUserDay do
  use Ecto.Migration

  def change do
    Level.create_type
    create table(:user_day) do
      add :note, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :level, :level

      timestamps()
    end
    create index(:user_day, [:user_id])
    create index(:user_day, [:level])
    create unique_index(:user_day, [:user_id, :inserted_at])
  end

  def down do
      drop table(:user_day)
      Level.drop_type
  end
end
