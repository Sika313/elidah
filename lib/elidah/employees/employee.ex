defmodule Elidah.EMPLOYEES.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    belongs_to :role, Role, foreign_key: :role_id, type: :id
    field :fname, :string
    field :gender, :string
    field :lname, :string
    field :password, :string
    field :phone, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:fname, :lname, :gender, :phone, :password, :role_id])
    |> validate_required([:fname, :lname, :gender, :phone, :password, :role_id])
  end
end
