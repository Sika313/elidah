defmodule Elidah.EMPLOYEESFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Elidah.EMPLOYEES` context.
  """

  @doc """
  Generate a employee.
  """
  def employee_fixture(attrs \\ %{}) do
    {:ok, employee} =
      attrs
      |> Enum.into(%{
        fname: "some fname",
        gender: "some gender",
        lname: "some lname",
        password: "some password",
        phone: "some phone"
      })
      |> Elidah.EMPLOYEES.create_employee()

    employee
  end
end
