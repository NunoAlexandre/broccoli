defmodule Server.UserDay do
  use Server.Web, :model

  @derive {Poison.Encoder, only: [:user_id, :note, :level]}

  schema "user_day" do
    field :note, :string
    field :level, Level
    belongs_to :user, Server.User


    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:note, :level, :user_id])
    |> cast_assoc(:user)
    |> validate_required([:user_id, :level, :note])
  end
end
