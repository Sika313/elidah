defmodule Elidah.ROLESTest do
  use Elidah.DataCase

  alias Elidah.ROLES

  describe "roles" do
    alias Elidah.ROLES.Role

    import Elidah.ROLESFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert ROLES.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert ROLES.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Role{} = role} = ROLES.create_role(valid_attrs)
      assert role.description == "some description"
      assert role.name == "some name"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ROLES.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Role{} = role} = ROLES.update_role(role, update_attrs)
      assert role.description == "some updated description"
      assert role.name == "some updated name"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = ROLES.update_role(role, @invalid_attrs)
      assert role == ROLES.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = ROLES.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> ROLES.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = ROLES.change_role(role)
    end
  end
end
