defmodule Server.User do
  use Server.Web, :model
  import Doorman.Auth.Bcrypt, only: [hash_password: 1]

  schema "users" do
    field :name, :string
    field :email, :string
    field :hashed_password, :string
    field :birth_date, Ecto.Date
    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password, :birth_date])
    |> validate_required([:name, :email, :password, :birth_date])
    |> unique_constraint(:email)
    |> hash_password
  end

end
