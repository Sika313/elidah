defmodule Elidah.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :grade, :string
      add :subject, :string
      add :teacher_id, :string

      timestamps(type: :utc_datetime)
    end
  end
end
