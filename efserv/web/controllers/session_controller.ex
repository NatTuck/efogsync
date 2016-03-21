defmodule Efserv.SessionController do
  use Efserv.Web, :controller

  def login(conn, params) do
    email = params["email"] || ""
    pass  = params["password"] || ""

    case Aeacus.authenticate %{identity: email, password: pass} do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Logged in as #{user.email}")
        |> put_session(:user_id, user.id)
        |> redirect(to: "/")
      {:error, message} ->
        conn 
        |> put_flash(:error, message)
        |> redirect(to: "/")
    end
  end

  def logout(conn, params) do
    conn 
    |> put_flash(:info, "Logged out")
    |> put_session(:user_id, nil)
    |> redirect(to: "/")
  end
end
