defmodule Efserv.Repo.Migrations.CreateFile do
  use Ecto.Migration

  def change do
    create table(:files) do
      add :share_id, :integer
      add :name, :string

      timestamps
    end

  end
end
