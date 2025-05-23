defmodule ElidahWeb.ViewClassesComponent do
  use ElidahWeb, :live_component
  alias Elidah.CLASSES 
  alias Elidah.EMPLOYEES 

  def update(assigns, socket) do
    classes = for class <- CLASSES.list_classes do
      Map.from_struct(class)
    end
    classes = for class <- classes do
      teacher = EMPLOYEES.get_employee!(String.to_integer(class.teacher_id))          |> Map.from_struct()
      Map.put(class, :teacher, teacher)
    end

    socket = socket
    |> assign(:classes, classes)
    {:ok, socket}
  end

  def render(assigns) do
   ~H"""

<div class="relative overflow-x-auto">
    <button phx-click="close_view_classes">
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
           </tr>
        </thead>
        <tbody>
          <%= for class <- @classes do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= class.grade %> 
                </th>
                <td class="px-6 py-4">
                  <%= class.subject %> 
                </td>
                <td class="px-6 py-4">
                  <%= class.teacher.fname %> <%= class.teacher.lname %>
                </td>
            </tr>
          <% end %>
      </tbody>
    </table>
</div>

   """
  end

end
