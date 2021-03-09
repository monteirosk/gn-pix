defmodule PagamentosWeb.PixController do
  use PagamentosWeb, :controller
  alias Pagamentos.Pix

  def index(conn, _params) do
    text(conn, "#{Pix.get_token()}")
  end
end
