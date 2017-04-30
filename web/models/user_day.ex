defmodule Broccoli.UserDay do
  use Broccoli.Web, :model

  @derive {Poison.Encoder, only: [:user_id, :day, :note, :level]}

  schema "user_day" do
    field :day, Ecto.Date
    field :level, Level
    field :note, :string
    belongs_to :user, Broccoli.User


    timestamps()
  end


  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:note, :day, :level, :user_id])
    |> cast_assoc(:user)
    |> validate_required([:user_id, :day, :level])
    |> unique_constraint(:single_user_day, name: :single_user_day)
  end
end
