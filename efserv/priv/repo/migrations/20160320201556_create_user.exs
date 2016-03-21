defmodule Efserv.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :hash, :string, null: false
      add :fingerprint, :string
      add :keys, :text

      timestamps
    end

    create index(:users, [:email])
    create index(:users, [:fingerprint])
  end
end
