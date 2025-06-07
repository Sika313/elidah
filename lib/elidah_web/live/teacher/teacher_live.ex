defmodule ElidahWeb.TeacherLive do
  use ElidahWeb, :live_view
  alias Elidah.EMPLOYEES
  alias Elidah.FILES
  alias Elidah.CLASSES
  alias Elidah.SALARIES
  alias ElidahWeb.ViewFileComponent

  def mount(_params, session, socket) do
    user = EMPLOYEES.get_employee!(session["user_id"]) |> Map.from_struct()
    salary = SALARIES.find_by_phone(user.phone)
    |> then(fn salaries -> for salary <- salaries do Map.from_struct(salary) end end)
    |> Enum.at(0)
    classes = CLASSES.find_class_by_teacher_id(user.id) 
    classes_map = for class <- classes do
      Map.from_struct(class)
    end
    files = case FILES.get_by_emp_id(user.id) do
      [] -> []
      result -> for r <- result do Map.from_struct(r) end
    end
    IO.inspect(salary, label: "SALARY--->")
    socket = socket
    |> assign(:user, user)
    |> assign(:salary, salary)
    |> assign(:classes, classes_map)
    |> assign(:view_employees, false)
    |> assign(:files, files)
    |> assign(:file_id, "")
    |> assign(:show_file, false)
    |> assign(:uploaded_files, [])
    |> allow_upload(:avatar, accept: ~w(.pdf), max_entries: 2)
    {:ok, socket}
  end

  def handle_event("save", params, socket) do
  IO.inspect(params, label: "PARAMS--->")
  uploaded_files =
    consume_uploaded_entries(socket, :avatar, fn %{path: path}, _entry ->
      dest = Path.join(Application.app_dir(:elidah, "priv/static/images/uploads"), Path.basename(path))
      # You will need to create `priv/static/uploads` for `File.cp!/2` to work.
      File.cp!(path, dest <> ".pdf")
      file_name = String.splitter(dest, "/") |> Enum.take(-1)
      full_file_name = Enum.at(file_name, 0) <> ".pdf"
      insert_into_files_table = %{
        name: params["name"],
        file_path: full_file_name,
        employee_id: socket.assigns.user.id
      }
      
      FILES.create_file(insert_into_files_table)
      {:ok, ~p"/uploads/#{Path.basename(dest)}"}
    end)
    files = case FILES.get_by_emp_id(socket.assigns.user.id) do
      [] -> []
      result -> for r <- result do Map.from_struct(r) end
    end
    socket = socket
    |> assign(:files, files)
  {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("view_file", params, socket) do
    IO.inspect(params, label: "PARAMS---")
    socket = socket
    |> assign(:show_file, true)
    |> assign(:file_id, params["file_id"])
    {:noreply, socket} 
  end
  
  def handle_event("hide_show_file", _params, socket) do
    socket = socket
    |> assign(:show_file, false)
    {:noreply, socket}
  end

end
