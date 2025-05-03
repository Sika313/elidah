defmodule ElidahWeb.LoginLive do
  use ElidahWeb, :live_view

  alias Elidah.EMPLOYEES

  def mount(_params, session, socket) do
    {:ok, socket}
  end

  def handle_event("login", params, socket) do
    IO.inspect(params, label: "PARAMS--->")
    user = %{
      phone: params["phone"],
      password: params["password"]
    }
    case EMPLOYEES.find_by_phone_and_password(user) do
      {:error} ->
        socket = socket
        |> put_flash(:error, "INVALID CREDENTIALS")
        {:noreply, socket}

      {:ok, result} ->
        socket = socket
        |> put_flash(:info, "USER FOUND")
        {:noreply, socket}
    end
  end

end
