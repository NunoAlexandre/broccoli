defmodule Server.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :crypted_password, :string
      add :birth_date, :date

      timestamps()
    end
    create unique_index(:users, [:email])

  end
end
