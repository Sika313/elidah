defmodule Elidah.FILES.File do
  use Ecto.Schema
  import Ecto.Changeset

  schema "files" do
    belongs_to :employee, Employee, foreign_key: :employee_id, type: :id 
    field :file_path, :string
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(file, attrs) do
    file
    |> cast(attrs, [:name, :file_path, :employee_id])
    |> validate_required([:name, :file_path, :employee_id])
  end
end
