defmodule Eblog.Repo.Migrations.CreateGit do
  use Ecto.Migration

  def change do
    create table(:add) do
      add :., :string

      timestamps()
    end

  end
end
