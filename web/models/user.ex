defmodule Server.User do
  use Server.Web, :model
  import Doorman.Auth.Bcrypt, only: [hash_password: 1]

  schema "user" do
    field :name, :string
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
    |> hash_password
  end
end
