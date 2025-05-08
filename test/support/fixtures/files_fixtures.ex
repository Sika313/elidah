defmodule Elidah.FILESFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Elidah.FILES` context.
  """

  @doc """
  Generate a file.
  """
  def file_fixture(attrs \\ %{}) do
    {:ok, file} =
      attrs
      |> Enum.into(%{
        file_path: "some file_path",
        name: "some name"
      })
      |> Elidah.FILES.create_file()

    file
  end
end
