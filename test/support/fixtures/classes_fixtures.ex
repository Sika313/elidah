defmodule Elidah.CLASSESFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Elidah.CLASSES` context.
  """

  @doc """
  Generate a class.
  """
  def class_fixture(attrs \\ %{}) do
    {:ok, class} =
      attrs
      |> Enum.into(%{
        grade: "some grade",
        subject: "some subject",
        teacher_id: "some teacher_id"
      })
      |> Elidah.CLASSES.create_class()

    class
  end
end
