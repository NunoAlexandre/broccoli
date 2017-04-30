defmodule Broccoli.SessionController do
  use Broccoli.Web, :controller
  import Doorman.Login.Session, only: [login: 2]

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    if user = Doorman.authenticate(email, password) do
      conn
      |> login(user) # Sets :user_id on conn's session
      |> put_flash(:notice, "Successfully logged in")
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:error, "No user found with the provided credentials")
      |> render("new.html")
    end
  end
end
