defmodule Efserv.ShareController do
  use Efserv.Web, :controller

  alias Efserv.Share

  plug :scrub_params, "share" when action in [:create, :update]

  def index(conn, _params) do
    shares = Repo.all(Share)
    render(conn, "index.json", shares: shares)
  end

  def create(conn, %{"share" => share_params}) do
    changeset = Share.changeset(%Share{}, share_params)

    case Repo.insert(changeset) do
      {:ok, share} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", share_path(conn, :show, share))
        |> render("show.json", share: share)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Efserv.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    share = Repo.get!(Share, id)
    render(conn, "show.json", share: share)
  end

  def update(conn, %{"id" => id, "share" => share_params}) do
    share = Repo.get!(Share, id)
    changeset = Share.changeset(share, share_params)

    case Repo.update(changeset) do
      {:ok, share} ->
        render(conn, "show.json", share: share)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Efserv.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    share = Repo.get!(Share, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(share)

    send_resp(conn, :no_content, "")
  end
end
