defmodule ElidahWeb.ViewDaysComponent do
  use ElidahWeb, :live_component
  alias Elidah.CLASSES 
  alias Elidah.CLASS_SESSIONS
  alias Elidah.EMPLOYEES 

  def update(assigns, socket) do
    classes = for class <- CLASSES.list_classes do
      Map.from_struct(class)
    end
    classes_one = for class <- classes do
      teacher = EMPLOYEES.get_employee!(String.to_integer(class.teacher_id))          |> Map.from_struct()
      Map.put(class, :teacher, teacher)
    end
    classes_two = for class <- classes_one do
      params = %{grade: class.grade, subject: class.subject}
      total = CLASS_SESSIONS.find_by_grade_and_subject_two(params) |> Enum.count()
      Map.put(class, :total, total)
    end

    socket = socket
    |> assign(:classes, classes_two)
    {:ok, socket}
  end

def render(assigns) do
~H"""
      <div>
      <div class="relative overflow-x-auto">
      <button phx-click="close_view_days">
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
      </svg>

    </button>
    <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                 Name 
                </th>
                <th scope="col" class="px-6 py-3">
                  Phone number 
                </th>
                <th scope="col" class="px-6 py-3">
                  Total days taught 
                </th>
           </tr>
        </thead>
        <tbody>
          <%= for class <- @classes do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= class.teacher.fname %> 
                </th>
                <td class="px-6 py-4">
                  <%= class.teacher.phone %> 
                </td>
                <td class="px-6 py-4">
                  <%= class.total %> 
                </td>
            </tr>
          <% end %>
      </tbody>
    </table>
     </div>
     </div>

"""
end

end
