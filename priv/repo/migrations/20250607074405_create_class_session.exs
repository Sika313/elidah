defmodule Elidah.Repo.Migrations.CreateClassSession do
  use Ecto.Migration

  def change do
    create table(:class_session) do
      add :grade, :string
      add :subject, :string

      timestamps(type: :utc_datetime)
    end
  end
end
