defmodule Elidah.SALARIESTest do
  use Elidah.DataCase

  alias Elidah.SALARIES

  describe "salaries" do
    alias Elidah.SALARIES.Salary

    import Elidah.SALARIESFixtures

    @invalid_attrs %{comment: nil, name: nil, napsa: nil, nhima: nil, other: nil, paye: nil, phone: nil, total_income: nil}

    test "list_salaries/0 returns all salaries" do
      salary = salary_fixture()
      assert SALARIES.list_salaries() == [salary]
    end

    test "get_salary!/1 returns the salary with given id" do
      salary = salary_fixture()
      assert SALARIES.get_salary!(salary.id) == salary
    end

    test "create_salary/1 with valid data creates a salary" do
      valid_attrs = %{comment: "some comment", name: "some name", napsa: 120.5, nhima: 120.5, other: 120.5, paye: 120.5, phone: "some phone", total_income: 120.5}

      assert {:ok, %Salary{} = salary} = SALARIES.create_salary(valid_attrs)
      assert salary.comment == "some comment"
      assert salary.name == "some name"
      assert salary.napsa == 120.5
      assert salary.nhima == 120.5
      assert salary.other == 120.5
      assert salary.paye == 120.5
      assert salary.phone == "some phone"
      assert salary.total_income == 120.5
    end

    test "create_salary/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SALARIES.create_salary(@invalid_attrs)
    end

    test "update_salary/2 with valid data updates the salary" do
      salary = salary_fixture()
      update_attrs = %{comment: "some updated comment", name: "some updated name", napsa: 456.7, nhima: 456.7, other: 456.7, paye: 456.7, phone: "some updated phone", total_income: 456.7}

      assert {:ok, %Salary{} = salary} = SALARIES.update_salary(salary, update_attrs)
      assert salary.comment == "some updated comment"
      assert salary.name == "some updated name"
      assert salary.napsa == 456.7
      assert salary.nhima == 456.7
      assert salary.other == 456.7
      assert salary.paye == 456.7
      assert salary.phone == "some updated phone"
      assert salary.total_income == 456.7
    end

    test "update_salary/2 with invalid data returns error changeset" do
      salary = salary_fixture()
      assert {:error, %Ecto.Changeset{}} = SALARIES.update_salary(salary, @invalid_attrs)
      assert salary == SALARIES.get_salary!(salary.id)
    end

    test "delete_salary/1 deletes the salary" do
      salary = salary_fixture()
      assert {:ok, %Salary{}} = SALARIES.delete_salary(salary)
      assert_raise Ecto.NoResultsError, fn -> SALARIES.get_salary!(salary.id) end
    end

    test "change_salary/1 returns a salary changeset" do
      salary = salary_fixture()
      assert %Ecto.Changeset{} = SALARIES.change_salary(salary)
    end
  end
end
