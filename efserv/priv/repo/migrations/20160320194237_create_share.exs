defmodule Efserv.Repo.Migrations.CreateShare do
  use Ecto.Migration

  def change do
    create table(:shares) do
      add :user_id, :integer
      add :name, :string

      timestamps
    end

  end
end
