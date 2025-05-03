defmodule ElidahWeb.AdminLive do
  use ElidahWeb, :live_view

  alias Elidah.EMPLOYEES
  alias Elidah.ROLES
  alias ElidahWeb.ViewEmployeesComponent 

  def mount(_params, session, socket) do
    user = EMPLOYEES.get_employee!(session["user_id"]) |> Map.from_struct()
    roles = ROLES.list_roles()
    |> then(fn roles -> for i <- roles do Map.from_struct(i) end end )
    socket = socket
    |> assign(:user, user)
    |> assign(:roles, roles)
    |> assign(:view_employees, false)

    {:ok, socket}
  end

  
  def handle_event("create_user", params, socket) do
    IO.inspect(params, label: "PARAMS--->")
    user = %{
      fname: params["fname"],
      lname: params["lname"],
      gender: params["gender"],
      phone: params["phone"],
      password: params["password"],
      role_id: String.to_integer(params["role"])
    }
    case EMPLOYEES.create_employee(user) do
      {:ok, _} ->
        socket = socket
        |> put_flash(:info, "User created successfully.")
        {:noreply, socket}
      {:error, _} ->
        socket = socket
        |> put_flash(:error, "User creation failed.")
        {:noreply, socket}
    end
  end

  def handle_event("view_emp", _params, socket) do
    socket = socket
    |> assign(:view_employees, true)
    {:noreply, socket}
  end

  def handle_event("view_emp_close", _params, socket) do
    socket = socket
    |> assign(:view_employees, false)
    {:noreply, socket}
  end

end
