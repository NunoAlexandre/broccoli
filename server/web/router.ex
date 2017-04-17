defmodule Server.Router do
  use Server.Web, :router

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
  end

  scope "/", Server do
    pipe_through :browser

    get "/", PageController, :index

  end

  scope "/api", Server do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    resources "/days", UserDayController, except: [:new, :edit]
  end
end
