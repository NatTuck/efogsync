defmodule Efserv.FileTest do
  use Efserv.ModelCase

  alias Efserv.File

  @valid_attrs %{name: "some content", share_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = File.changeset(%File{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = File.changeset(%File{}, @invalid_attrs)
    refute changeset.valid?
  end
end
