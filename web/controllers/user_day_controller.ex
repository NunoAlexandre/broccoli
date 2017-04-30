defmodule Broccoli.UserDayController do
  use Broccoli.Web, :controller

  alias Broccoli.UserDay

  def index(conn, _params) do
    user_day = Repo.all(UserDay)
    render(conn, "index.json", user_day: user_day)
  end

  def create(conn, %{"user_day" => user_day_params}) do
    changeset = UserDay.changeset(%UserDay{}, user_day_params)

    case Repo.insert(changeset) do
      {:ok, user_day} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_day_path(conn, :show, user_day))
        |> render("show.json", user_day: user_day)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Broccoli.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_day = Repo.get!(UserDay, id)
    render(conn, "show.json", user_day: user_day)
  end

  def update(conn, %{"id" => id, "user_day" => user_day_params}) do
    user_day = Repo.get!(UserDay, id)
    changeset = UserDay.changeset(user_day, user_day_params)

    case Repo.update(changeset) do
      {:ok, user_day} ->
        render(conn, "show.json", user_day: user_day)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Broccoli.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_day = Repo.get!(UserDay, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_day)

    send_resp(conn, :no_content, "")
  end
end
