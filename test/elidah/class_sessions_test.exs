defmodule Elidah.CLASS_SESSIONSTest do
  use Elidah.DataCase

  alias Elidah.CLASS_SESSIONS

  describe "class_session" do
    alias Elidah.CLASS_SESSIONS.Class_session

    import Elidah.CLASS_SESSIONSFixtures

    @invalid_attrs %{grade: nil, subject: nil}

    test "list_class_session/0 returns all class_session" do
      class_session = class_session_fixture()
      assert CLASS_SESSIONS.list_class_session() == [class_session]
    end

    test "get_class_session!/1 returns the class_session with given id" do
      class_session = class_session_fixture()
      assert CLASS_SESSIONS.get_class_session!(class_session.id) == class_session
    end

    test "create_class_session/1 with valid data creates a class_session" do
      valid_attrs = %{grade: "some grade", subject: "some subject"}

      assert {:ok, %Class_session{} = class_session} = CLASS_SESSIONS.create_class_session(valid_attrs)
      assert class_session.grade == "some grade"
      assert class_session.subject == "some subject"
    end

    test "create_class_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CLASS_SESSIONS.create_class_session(@invalid_attrs)
    end

    test "update_class_session/2 with valid data updates the class_session" do
      class_session = class_session_fixture()
      update_attrs = %{grade: "some updated grade", subject: "some updated subject"}

      assert {:ok, %Class_session{} = class_session} = CLASS_SESSIONS.update_class_session(class_session, update_attrs)
      assert class_session.grade == "some updated grade"
      assert class_session.subject == "some updated subject"
    end

    test "update_class_session/2 with invalid data returns error changeset" do
      class_session = class_session_fixture()
      assert {:error, %Ecto.Changeset{}} = CLASS_SESSIONS.update_class_session(class_session, @invalid_attrs)
      assert class_session == CLASS_SESSIONS.get_class_session!(class_session.id)
    end

    test "delete_class_session/1 deletes the class_session" do
      class_session = class_session_fixture()
      assert {:ok, %Class_session{}} = CLASS_SESSIONS.delete_class_session(class_session)
      assert_raise Ecto.NoResultsError, fn -> CLASS_SESSIONS.get_class_session!(class_session.id) end
    end

    test "change_class_session/1 returns a class_session changeset" do
      class_session = class_session_fixture()
      assert %Ecto.Changeset{} = CLASS_SESSIONS.change_class_session(class_session)
    end
  end
end
