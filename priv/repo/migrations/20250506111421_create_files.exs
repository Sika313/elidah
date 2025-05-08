defmodule Elidah.Repo.Migrations.CreateFiles do
  use Ecto.Migration

  def change do
    create table(:files) do
      add :name, :string
      add :file_path, :string

      add :employee_id, references(:employees, column: :id, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end
  end
end
