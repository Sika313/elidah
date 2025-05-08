defmodule ElidahWeb.ViewFileComponent do
  use ElidahWeb, :live_component
  alias Elidah.FILES 

  def update(assigns, socket) do
    IO.inspect(assigns, label: "ASSIGNS--->")
    file = FILES.get_file!(String.to_integer(assigns.file_id))
    file_path = "/images/uploads/" <> file.file_path
    socket = socket
    |> assign(:file, file)
    |> assign(:file_path,file_path)
    {:ok, socket}
  end

  def render(assigns) do
   ~H"""
    <div>
      <button phx-click="hide_show_file">X</button>
      <h1>SHOW FILE</h1>
      <p> <%= @file.name %> </p>
      <iframe src="/images/uploads/live_view_upload-1746685963-447400492218-1.pdf"
            width="800" height="500">
        </iframe>
   </div>
   """
  end

end
