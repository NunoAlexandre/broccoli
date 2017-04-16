defmodule Server.UserDayController do
  use Server.Web, :controller

  alias Server.UserDay

  plug :scrub_params, "user_day" when action in [:create, :update]

  def index(conn, _params) do
    user_day = Repo.all(UserDay)
    render(conn, "index.html", user_day: user_day)
  end

  def new(conn, _params) do
    changeset = UserDay.changeset(%UserDay{user_id: 0})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_day" => user_day_params}) do
    # user: Repo.get!(Server.User, 1)
    changeset = UserDay.changeset(%UserDay{}, user_day_params)
    case Repo.insert(changeset) do
      {:ok, _user_day} ->
        conn
        |> put_status(:created)
      {:error, changeset} ->
        render(conn, changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_day = Repo.get!(UserDay, id)
    render(conn, "show.html", user_day: user_day)
  end

  def edit(conn, %{"id" => id}) do
    user_day = Repo.get!(UserDay, id)
    changeset = UserDay.changeset(user_day)
    render(conn, "edit.html", user_day: user_day, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_day" => user_day_params}) do
    user_day = Repo.get!(UserDay, id)
    changeset = UserDay.changeset(user_day, user_day_params)

    case Repo.update(changeset) do
      {:ok, user_day} ->
        conn
        |> put_flash(:info, "User day updated successfully.")
        |> redirect(to: user_day_path(conn, :show, user_day))
      {:error, changeset} ->
        render(conn, "edit.html", user_day: user_day, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_day = Repo.get!(UserDay, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_day)

    conn
    |> put_flash(:info, "User day deleted successfully.")
    |> redirect(to: user_day_path(conn, :index))
  end
end
