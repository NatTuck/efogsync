defmodule Efserv.User do
  use Efserv.Web, :model

  schema "users" do
    field :email, :string
    field :hash, :string
    field :fingerprint, :string
    field :keys, :string

    timestamps
  end

  @required_fields ~w(email hash)
  @optional_fields ~w(fingerprint keys)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    if params != :empty && Map.has_key?(params, "password") do
      params = Map.put(params, "hash", Aeacus.hashpwsalt(params["password"]))
    end

    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
