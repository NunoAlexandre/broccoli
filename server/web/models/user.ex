defmodule Server.User do
  use Server.Web, :model

  schema "user" do
    field :name, :string
    field :email, :string
    field :hashed_password, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :hashed_password])
    |> validate_required([:name, :email, :hashed_password])
    |> unique_constraint(:email)
  end
end
