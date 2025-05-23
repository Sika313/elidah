defmodule Elidah.CLASSES.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :grade, :string
    field :subject, :string
    field :teacher_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:grade, :subject, :teacher_id])
    |> validate_required([:grade, :subject, :teacher_id])
  end
end
