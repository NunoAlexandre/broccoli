defmodule Broccoli.Router do
  use Broccoli.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Doorman.Login.Session
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end

  scope "/", Broccoli do
    pipe_through :browser

    get "/", PageController, :index

  end

  scope "/api", Broccoli do
    pipe_through :api

    resources "/days", UserDayController, except: [:new, :edit]
    post "/authenticate", AuthenticationController, :index

  end
end
