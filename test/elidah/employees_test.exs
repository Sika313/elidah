defmodule Elidah.EMPLOYEESTest do
  use Elidah.DataCase

  alias Elidah.EMPLOYEES

  describe "employees" do
    alias Elidah.EMPLOYEES.Employee

    import Elidah.EMPLOYEESFixtures

    @invalid_attrs %{fname: nil, gender: nil, lname: nil, password: nil, phone: nil}

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert EMPLOYEES.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert EMPLOYEES.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      valid_attrs = %{fname: "some fname", gender: "some gender", lname: "some lname", password: "some password", phone: "some phone"}

      assert {:ok, %Employee{} = employee} = EMPLOYEES.create_employee(valid_attrs)
      assert employee.fname == "some fname"
      assert employee.gender == "some gender"
      assert employee.lname == "some lname"
      assert employee.password == "some password"
      assert employee.phone == "some phone"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EMPLOYEES.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      update_attrs = %{fname: "some updated fname", gender: "some updated gender", lname: "some updated lname", password: "some updated password", phone: "some updated phone"}

      assert {:ok, %Employee{} = employee} = EMPLOYEES.update_employee(employee, update_attrs)
      assert employee.fname == "some updated fname"
      assert employee.gender == "some updated gender"
      assert employee.lname == "some updated lname"
      assert employee.password == "some updated password"
      assert employee.phone == "some updated phone"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = EMPLOYEES.update_employee(employee, @invalid_attrs)
      assert employee == EMPLOYEES.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = EMPLOYEES.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> EMPLOYEES.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = EMPLOYEES.change_employee(employee)
    end
  end
end
