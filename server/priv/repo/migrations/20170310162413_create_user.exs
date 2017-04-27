defmodule Server.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :hashed_password, :string, null: false

      timestamps()
    end
    create unique_index(:user, [:email])

  end
end
