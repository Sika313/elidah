defmodule ElidahWeb.ViewClassSessionsComponent do
  use ElidahWeb, :live_component
  alias Elidah.CLASS_SESSIONS 
  alias Elidah.CLASSES 
  alias Elidah.EMPLOYEES 

  def update(assigns, socket) do
    class_sessions = CLASS_SESSIONS.list_class_session()
    class_sessions_map = for class_session <- class_sessions do
      Map.from_struct(class_session)
    end
    class_session_teachers = for class_session <- class_sessions_map do
      teacher_id = CLASSES.find_by_grade_and_subject(class_session) |> Map.from_struct()
      teacher = EMPLOYEES.get_employee!(teacher_id.teacher_id)
      Map.put(class_session, :teacher, teacher)
    end
    IO.inspect(class_session_teachers, label: "CST--->")
    socket = socket
    |> assign(:class_sessions, class_session_teachers)
    {:ok, socket}
  end

  def render(assigns) do
   ~H"""

<div class="relative overflow-x-auto">
    <button phx-click="close_view_class_sessions">
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
</svg>

    </button>
    <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                 Grade 
                </th>
                <th scope="col" class="px-6 py-3">
                  Subject 
                </th>
                <th scope="col" class="px-6 py-3">
                  Teacher 
                </th>
                <th scope="col" class="px-6 py-3">
                  Date 
                </th>
           </tr>
        </thead>
        <tbody>
          <%= for class_session <- @class_sessions do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= class_session.grade %> 
                </th>
                <td class="px-6 py-4">
                  <%= class_session.subject %> 
                </td>
                <td class="px-6 py-4">
                  <%= class_session.teacher.fname %> <%= class_session.teacher.lname %>
                </td>
 <td class="px-6 py-4">
                  <%= class_session.inserted_at %>
                </td>

            </tr>
          <% end %>
      </tbody>
    </table>
</div>

   """
  end

end
