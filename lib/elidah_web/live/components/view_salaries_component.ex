defmodule ElidahWeb.ViewSalariesComponent do
  use ElidahWeb, :live_component
  alias Elidah.SALARIES 

  def update(assigns, socket) do
    salaries = SALARIES.list_salaries()
    |> then(fn salaries -> for salary <- salaries do Map.from_struct(salary) end end)
    IO.inspect(salaries, label: "SALARIES--->")
        socket = socket
    |> assign(:salaries, salaries)
    {:ok, socket}
  end

  def render(assigns) do
   ~H"""

<div class="relative overflow-x-auto">
    <button phx-click="close_view_salaries">
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
                  Total income 
                </th>
                <th scope="col" class="px-6 py-3">
                   NAPSA
                </th>
                <th scope="col" class="px-6 py-3">
                   NHIMA 
                </th>
                <th scope="col" class="px-6 py-3">
                  PAYE 
                </th>
                <th scope="col" class="px-6 py-3">
                  OTHER CHARGES 
                </th>
               <th scope="col" class="px-6 py-3">
                  Comment 
                </th>
               <th scope="col" class="px-6 py-3">
                  START DATE 
                </th>

           </tr>
        </thead>
        <tbody>
          <%= for salary <- @salaries do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= salary.name %> 
                </th>
                <td class="px-6 py-4">
                  <%= salary.phone %> 
                </td>
                <td class="px-6 py-4">
                  <%= salary.total_income |> then(fn i -> Float.to_charlist(i) end) %>
                </td>
                <td class="px-6 py-4">
                  <%= salary.napsa %>
                </td>
                <td class="px-6 py-4">
                  <%= salary.nhima %>
                </td>
                <td class="px-6 py-4">
                  <%= salary.paye %>
                </td>
                <td class="px-6 py-4">
                  <%= salary.other %>
                </td>
                <td class="px-6 py-4">
                  <%= salary.comment %>
                </td>
                <td class="px-6 py-4">
                  <%= salary.inserted_at %>
                </td>

            </tr>
          <% end %>
      </tbody>
    </table>
</div>

   """
  end

end
