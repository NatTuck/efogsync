defmodule Efserv.Router do
  use Efserv.Web, :router

  def fetch_user(conn, _opts) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = Efserv.Repo.get(Efserv.User, user_id)
    else
      user = nil
    end
    assign(conn, :user, user)
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Efserv do
    pipe_through :browser 

    get "/", PageController, :index

    post "/session", SessionController, :login
    delete "/session", SessionController, :logout

    resources "/users", UserController
  end

  scope "/api_v1", Efserv do
    pipe_through :api

    resources "/shares", ShareController, except: [:new, :edit]
    resources "/files", FileController, except: [:new, :edit]
  end
end
