defmodule Elidah.Repo.Migrations.CreateSalaries do
  use Ecto.Migration

  def change do
    create table(:salaries) do
      add :name, :string
      add :phone, :string
      add :total_income, :float
      add :paye, :float
      add :napsa, :float
      add :nhima, :float
      add :other, :float
      add :comment, :string

      timestamps(type: :utc_datetime)
    end
  end
end
