defmodule Broccoli.AuthenticationController do
  use Broccoli.Web, :controller


  def index(conn, %{"credentials" => %{"email" => email, "password" => password}}) do
    authentication_response(conn, Doorman.authenticate(email, password))
  end

  def authentication_response(conn, nil), do: send_resp(conn, :not_found, "")
  def authentication_response(conn, _user), do: send_resp(conn, :ok, "")

end
