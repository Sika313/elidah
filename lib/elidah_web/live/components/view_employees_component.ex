defmodule ElidahWeb.ViewEmployeesComponent do
  use ElidahWeb, :live_component
  alias Elidah.EMPLOYEES 

  def update(assigns, socket) do
    employees = for employee <- EMPLOYEES.list_employees do
      Map.from_struct(employee)
    end
    IO.inspect(employees, label: "EMPLOYEES--->")
    socket = socket
    |> assign(:employees, employees)
    {:ok, socket}
  end

  def render(assigns) do
   ~H"""


<div class="relative overflow-x-auto">
    <button phx-click="view_emp_close">
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
</svg>

    </button>
    <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                  First name
                </th>
                <th scope="col" class="px-6 py-3">
                  Last name 
                </th>
                <th scope="col" class="px-6 py-3">
                  Gender 
                </th>
                <th scope="col" class="px-6 py-3">
                  Phone number 
                </th>
            </tr>
        </thead>
        <tbody>
          <%= for employee <- @employees do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= employee.fname %> 
                </th>
                <td class="px-6 py-4">
                  <%= employee.lname %> 
                </td>
                <td class="px-6 py-4">
                  <%= employee.gender %> 
                </td>
                <td class="px-6 py-4">
                  <%= employee.phone %>  
                </td>
            </tr>
          <% end %>
      </tbody>
    </table>
</div>

   """
  end

end
