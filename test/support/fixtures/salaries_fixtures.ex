defmodule Elidah.SALARIESFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Elidah.SALARIES` context.
  """

  @doc """
  Generate a salary.
  """
  def salary_fixture(attrs \\ %{}) do
    {:ok, salary} =
      attrs
      |> Enum.into(%{
        comment: "some comment",
        name: "some name",
        napsa: 120.5,
        nhima: 120.5,
        other: 120.5,
        paye: 120.5,
        phone: "some phone",
        total_income: 120.5
      })
      |> Elidah.SALARIES.create_salary()

    salary
  end
end
