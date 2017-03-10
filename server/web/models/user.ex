defmodule Server.User do
  use Server.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :crypted_password, :string
    field :birth_date, Ecto.Date

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :crypted_password, :birth_date])
    |> validate_required([:name, :email, :crypted_password, :birth_date])
    |> unique_constraint(:email)
  end
end
