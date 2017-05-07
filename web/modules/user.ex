defmodule Broccoli.User do

  def id(conn), do: Guardian.Plug.current_resource(conn)

end
