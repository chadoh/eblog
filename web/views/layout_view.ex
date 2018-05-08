defmodule Eblog.LayoutView do
  use Eblog.Web, :view

  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end
end
