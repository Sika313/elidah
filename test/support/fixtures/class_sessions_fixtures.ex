defmodule Elidah.CLASS_SESSIONSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Elidah.CLASS_SESSIONS` context.
  """

  @doc """
  Generate a class_session.
  """
  def class_session_fixture(attrs \\ %{}) do
    {:ok, class_session} =
      attrs
      |> Enum.into(%{
        grade: "some grade",
        subject: "some subject"
      })
      |> Elidah.CLASS_SESSIONS.create_class_session()

    class_session
  end
end
