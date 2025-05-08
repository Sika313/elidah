defmodule Elidah.FILESTest do
  use Elidah.DataCase

  alias Elidah.FILES

  describe "files" do
    alias Elidah.FILES.File

    import Elidah.FILESFixtures

    @invalid_attrs %{file_path: nil, name: nil}

    test "list_files/0 returns all files" do
      file = file_fixture()
      assert FILES.list_files() == [file]
    end

    test "get_file!/1 returns the file with given id" do
      file = file_fixture()
      assert FILES.get_file!(file.id) == file
    end

    test "create_file/1 with valid data creates a file" do
      valid_attrs = %{file_path: "some file_path", name: "some name"}

      assert {:ok, %File{} = file} = FILES.create_file(valid_attrs)
      assert file.file_path == "some file_path"
      assert file.name == "some name"
    end

    test "create_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FILES.create_file(@invalid_attrs)
    end

    test "update_file/2 with valid data updates the file" do
      file = file_fixture()
      update_attrs = %{file_path: "some updated file_path", name: "some updated name"}

      assert {:ok, %File{} = file} = FILES.update_file(file, update_attrs)
      assert file.file_path == "some updated file_path"
      assert file.name == "some updated name"
    end

    test "update_file/2 with invalid data returns error changeset" do
      file = file_fixture()
      assert {:error, %Ecto.Changeset{}} = FILES.update_file(file, @invalid_attrs)
      assert file == FILES.get_file!(file.id)
    end

    test "delete_file/1 deletes the file" do
      file = file_fixture()
      assert {:ok, %File{}} = FILES.delete_file(file)
      assert_raise Ecto.NoResultsError, fn -> FILES.get_file!(file.id) end
    end

    test "change_file/1 returns a file changeset" do
      file = file_fixture()
      assert %Ecto.Changeset{} = FILES.change_file(file)
    end
  end
end
