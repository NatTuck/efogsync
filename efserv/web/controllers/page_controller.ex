defmodule Efserv.PageController do
  use Efserv.Web, :controller
  alias Efserv.User

  def index(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "index.html", new_user: changeset
  end
end
