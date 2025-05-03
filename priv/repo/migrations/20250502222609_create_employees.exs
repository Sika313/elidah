defmodule Elidah.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :fname, :string
      add :lname, :string
      add :gender, :string
      add :phone, :string
      add :password, :string
      
      add :role_id, references(:roles, column: :id, on_delete: :nothing)
      timestamps(type: :utc_datetime)
    end
  end
end
