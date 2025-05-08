defmodule ElidahWeb.PageController do
  use ElidahWeb, :controller
  import Phoenix.LiveView.Controller
  alias Elidah.EMPLOYEES

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def login(conn, _params) do
    render(conn, :login)
  end

  def handle_login(conn, params) do
    user = %{
      phone: params["phone"],
      password: params["password"]
    }
    case EMPLOYEES.find_by_phone_and_password(user) do
      {:error} ->
        conn = conn
        |> put_flash(:error, "INVALID CREDENTIALS")
        |> redirect(to: "/login")
        conn
      {:ok, result} ->
        to_render = cond do
          result.role_id == 1 -> ElidahWeb.AdminLive
          result.role_id == 2 -> ElidahWeb.TeacherLive
        end
        conn = conn 
        |> put_flash(:info, "Login successful")
        |> put_session(:user_id, result.id)
        |> live_render(to_render)
    end
  end

  def logout(conn, _params) do
    conn = conn
    |> clear_session()
    |> put_flash(:info, "Successfully logged out.")
    |> redirect(to: "/")
    conn
  end



end
