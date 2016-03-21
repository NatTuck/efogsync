defmodule Efserv.FileControllerTest do
  use Efserv.ConnCase

  alias Efserv.File
  @valid_attrs %{name: "some content", share_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, file_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    file = Repo.insert! %File{}
    conn = get conn, file_path(conn, :show, file)
    assert json_response(conn, 200)["data"] == %{"id" => file.id,
      "share_id" => file.share_id,
      "name" => file.name}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, file_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, file_path(conn, :create), file: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(File, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, file_path(conn, :create), file: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    file = Repo.insert! %File{}
    conn = put conn, file_path(conn, :update, file), file: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(File, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    file = Repo.insert! %File{}
    conn = put conn, file_path(conn, :update, file), file: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    file = Repo.insert! %File{}
    conn = delete conn, file_path(conn, :delete, file)
    assert response(conn, 204)
    refute Repo.get(File, file.id)
  end
end
