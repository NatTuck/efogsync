defmodule Efserv.ShareTest do
  use Efserv.ModelCase

  alias Efserv.Share

  @valid_attrs %{name: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Share.changeset(%Share{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Share.changeset(%Share{}, @invalid_attrs)
    refute changeset.valid?
  end
end
