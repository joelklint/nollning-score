defmodule NollningScore.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :hashed_password, :string, null: false

      timestamps()
    end

    create unique_index(:users, :username)

  end
end
