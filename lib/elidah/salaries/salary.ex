defmodule Elidah.SALARIES.Salary do
  use Ecto.Schema
  import Ecto.Changeset

  schema "salaries" do
    field :comment, :string
    field :name, :string
    field :napsa, :float
    field :nhima, :float
    field :other, :float
    field :paye, :float
    field :phone, :string
    field :total_income, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(salary, attrs) do
    salary
    |> cast(attrs, [:name, :phone, :total_income, :paye, :napsa, :nhima, :other, :comment])
    |> validate_required([:name, :phone, :total_income, :paye, :napsa, :nhima, :other, :comment])
  end
end
