defmodule ElidahWeb.AdminLive do
  use ElidahWeb, :live_view

  alias Elidah.EMPLOYEES
  alias Elidah.ROLES
  alias Elidah.CLASSES
  alias Elidah.CLASS_SESSIONS
  alias Elidah.SALARIES
  alias ElidahWeb.ViewEmployeesComponent 
  alias ElidahWeb.ViewClassesComponent 
  alias ElidahWeb.ViewClassSessionsComponent
  alias ElidahWeb.ViewSalariesComponent

  def mount(_params, session, socket) do
    user = EMPLOYEES.get_employee!(session["user_id"]) |> Map.from_struct()
    classes = CLASSES.list_classes()
    classes_map = for class <- classes do
      Map.from_struct(class)
    end
    roles = ROLES.list_roles()
    |> then(fn roles -> for i <- roles do Map.from_struct(i) end end )
    teachers = EMPLOYEES.get_by_role_id(2)
    teachers = for teacher <- teachers do
      Map.from_struct(teacher)
    end
    all_employees = EMPLOYEES.list_employees()
    |> then(fn employees -> for emp <- employees do Map.from_struct(emp) end end)
    emp_add_payroll = Enum.filter(all_employees, fn e -> SALARIES.find_by_phone(e.phone) == [] end) 
    IO.inspect(emp_add_payroll, label: "THIS--->")
      
      
    socket = socket
    |> assign(:user, user)
    |> assign(:classes, classes_map)
    |> assign(:teachers, teachers)
    |> assign(:emp_add_payroll, emp_add_payroll)
    |> assign(:roles, roles)
    |> assign(:view_employees, false)
    |> assign(:view_classes, false)
    |> assign(:view_class_sessions, false)
    |> assign(:view_salaries, false)
    {:ok, socket}
  end

  def handle_event("view_emp_close", _params, socket) do
    socket = socket
    |> assign(:view_employees, false)
    {:noreply, socket}
  end
  def handle_event("close_view_classes", _params, socket) do
   socket = socket
   |> assign(:view_classes, false)
   {:noreply, socket}
  end
  def handle_event("close_view_class_sessions", _params, socket) do
   socket = socket
   |> assign(:view_class_sessions, false)
   {:noreply, socket}
  end
def handle_event("close_view_salaries", _params, socket) do
   socket = socket
   |> assign(:view_salaries, false)
   {:noreply, socket}
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
        teachers = EMPLOYEES.get_by_role_id(2)
        teachers = for teacher <- teachers do
        Map.from_struct(teacher)
        end

        socket = socket
        |> assign(:teachers, teachers)
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

  def handle_event("view_classes", _params, socket) do
    socket = socket
    |> assign(:view_classes, true)
    {:noreply, socket}
  end
  def handle_event("view_class_sessions", _params, socket) do
    socket = socket
    |> assign(:view_class_sessions, true)
    {:noreply, socket}
  end
  def handle_event("view_salaries", _params, socket) do
    socket = socket
    |> assign(:view_salaries, true)
    {:noreply, socket}
  end



    def handle_event("handle_add_class", params, socket) do
    IO.inspect(params, label: "PARAMS--->")
    class = %{
      grade: params["grade"],
      subject: params["subject"],
      teacher_id: params["teacher_id"]
    }
    CLASSES.create_class(class)
    socket = socket
    |> put_flash(:info, "Class added successfully.")
    {:noreply, socket}
  end

  def handle_event("handle_add_class_session", params, socket) do
    class = %{
      grade: params["grade"],
      subject: params["subject"],
    }
    CLASS_SESSIONS.create_class_session(class)
    socket = socket
    |> put_flash(:info, "Class session added successfully.")
    {:noreply, socket}
  end

  def to_float(value) do
    Float.parse(value) |> Tuple.to_list() |> Enum.at(0)
  end

  def handle_event("handle_add_payroll", params, socket) do
    payroll = %{
      name: params["name"],
      phone: params["phone"],
      total_income: to_float(params["total_income"]),
      napsa: to_float(params["napsa"]),
      nhima: to_float(params["nhima"]),
      paye: to_float(params["paye"]),
      other: to_float(params["other"]),
      comment: params["other"]
    }
    SALARIES.create_salary(payroll)
    all_employees = EMPLOYEES.list_employees()
    |> then(fn employees -> for emp <- employees do Map.from_struct(emp) end end)
    emp_add_payroll = Enum.filter(all_employees, fn e -> SALARIES.find_by_phone(e.phone) == [] end)
    socket = socket
    |> put_flash(:info, "Employee successfully registered for payroll.")
    |> assign(:emp_add_payroll, emp_add_payroll)
    {:noreply, socket}
  end

end
