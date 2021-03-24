defmodule PagamentosWeb.PixController do
  use PagamentosWeb, :controller
  alias Pagamentos.Pix

  def index(conn, params) do
    # {"cpf":"743390000000","nome":"William Monteiro","valor":"1.00","descricao":"Pagamento do pedido112233"}
    json(conn, Pix.gera_novo_pagamento(params))
  end
end
