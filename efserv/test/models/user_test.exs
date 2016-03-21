defmodule Efserv.UserTest do
  use Efserv.ModelCase

  alias Efserv.User

  @valid_attrs %{email: "some content", fingerprint: "some content", keys: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
