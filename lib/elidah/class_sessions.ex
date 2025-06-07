defmodule Elidah.CLASS_SESSIONS do
  @moduledoc """
  The CLASS_SESSIONS context.
  """

  import Ecto.Query, warn: false
  alias Elidah.Repo

  alias Elidah.CLASS_SESSIONS.Class_session


  def find_by_grade_and_subject(params) do
    query = from c in Class_session, where: c.grade == ^params.grade and c.subject == ^params.subject
    Repo.one(query)
  end

  @doc """
  Returns the list of class_session.

  ## Examples

      iex> list_class_session()
      [%Class_session{}, ...]

  """
  def list_class_session do
    Repo.all(Class_session)
  end

  @doc """
  Gets a single class_session.

  Raises `Ecto.NoResultsError` if the Class session does not exist.

  ## Examples

      iex> get_class_session!(123)
      %Class_session{}

      iex> get_class_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_class_session!(id), do: Repo.get!(Class_session, id)

  @doc """
  Creates a class_session.

  ## Examples

      iex> create_class_session(%{field: value})
      {:ok, %Class_session{}}

      iex> create_class_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_class_session(attrs \\ %{}) do
    %Class_session{}
    |> Class_session.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a class_session.

  ## Examples

      iex> update_class_session(class_session, %{field: new_value})
      {:ok, %Class_session{}}

      iex> update_class_session(class_session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_class_session(%Class_session{} = class_session, attrs) do
    class_session
    |> Class_session.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a class_session.

  ## Examples

      iex> delete_class_session(class_session)
      {:ok, %Class_session{}}

      iex> delete_class_session(class_session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_class_session(%Class_session{} = class_session) do
    Repo.delete(class_session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking class_session changes.

  ## Examples

      iex> change_class_session(class_session)
      %Ecto.Changeset{data: %Class_session{}}

  """
  def change_class_session(%Class_session{} = class_session, attrs \\ %{}) do
    Class_session.changeset(class_session, attrs)
  end
end
