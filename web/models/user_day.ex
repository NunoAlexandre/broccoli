defmodule Broccoli.UserDay do
  use Broccoli.Web, :model
  alias Broccoli.UserDay
  @derive {Poison.Encoder, only: [:uid, :day, :note, :level]}

  schema "user_day" do
    field :day, Ecto.Date
    field :level, Level
    field :note, :string
    field :uid, :string


    timestamps()
  end


  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:note, :day, :level, :uid])
    |> validate_required([:uid, :day, :level])
    |> unique_constraint(:single_user_day, name: :single_user_day)
  end

  def by_uid(uid), do: from ud in UserDay, where: ud.uid == ^uid, order_by: [asc: ud.day]

end
