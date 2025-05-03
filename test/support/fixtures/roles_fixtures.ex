defmodule Elidah.ROLESFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Elidah.ROLES` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Elidah.ROLES.create_role()

    role
  end
end
