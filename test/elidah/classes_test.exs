defmodule Elidah.CLASSESTest do
  use Elidah.DataCase

  alias Elidah.CLASSES

  describe "classes" do
    alias Elidah.CLASSES.Class

    import Elidah.CLASSESFixtures

    @invalid_attrs %{grade: nil, subject: nil, teacher_id: nil}

    test "list_classes/0 returns all classes" do
      class = class_fixture()
      assert CLASSES.list_classes() == [class]
    end

    test "get_class!/1 returns the class with given id" do
      class = class_fixture()
      assert CLASSES.get_class!(class.id) == class
    end

    test "create_class/1 with valid data creates a class" do
      valid_attrs = %{grade: "some grade", subject: "some subject", teacher_id: "some teacher_id"}

      assert {:ok, %Class{} = class} = CLASSES.create_class(valid_attrs)
      assert class.grade == "some grade"
      assert class.subject == "some subject"
      assert class.teacher_id == "some teacher_id"
    end

    test "create_class/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CLASSES.create_class(@invalid_attrs)
    end

    test "update_class/2 with valid data updates the class" do
      class = class_fixture()
      update_attrs = %{grade: "some updated grade", subject: "some updated subject", teacher_id: "some updated teacher_id"}

      assert {:ok, %Class{} = class} = CLASSES.update_class(class, update_attrs)
      assert class.grade == "some updated grade"
      assert class.subject == "some updated subject"
      assert class.teacher_id == "some updated teacher_id"
    end

    test "update_class/2 with invalid data returns error changeset" do
      class = class_fixture()
      assert {:error, %Ecto.Changeset{}} = CLASSES.update_class(class, @invalid_attrs)
      assert class == CLASSES.get_class!(class.id)
    end

    test "delete_class/1 deletes the class" do
      class = class_fixture()
      assert {:ok, %Class{}} = CLASSES.delete_class(class)
      assert_raise Ecto.NoResultsError, fn -> CLASSES.get_class!(class.id) end
    end

    test "change_class/1 returns a class changeset" do
      class = class_fixture()
      assert %Ecto.Changeset{} = CLASSES.change_class(class)
    end
  end
end
