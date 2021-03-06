defmodule Pagamentos.Pix do
  def get_token() do
    client_id = "Client_Id_ee542ca94cf7bb3add7ef77d11cdf64cad0f512d"
    client_secret = "Client_Secret_4ba9291843d1fa2e4d1bd87a9a4f384a30a19927"
    auth = Base.encode64("#{client_id}:#{client_secret}")
    url = "https://api-pix.gerencianet.com.br/oauth/token"
    request = Poison.encode!(%{grant_type: "client_credentials"})
    headers = [{"Authorization", "Basic #{auth}"}, {"Content-Type", "application/json"}]
    options = [ssl: [certfile: "certificado.pem"]]

    {:ok, response} =
      HTTPoison.post(
        url,
        request,
        headers,
        options
      )

    token =
      response.body
      |> Poison.decode!()
      |> Map.get("access_token")

    cob =
      criar_cobranca(token)
      |> Poison.decode!()

    locId =
      cob
      |> Map.get("loc")
      |> Map.get("id")

    qrcode = get_qrcode(token, locId)
    Poison.encode!(%{token: token, cobranca: cob, qrcode: qrcode})
    # IO.inspect(qrcode)
  end

  def criar_cobranca(token) do
    url = "https://api-pix.gerencianet.com.br/v2/cob/"

    request =
      "{\"calendario\":{\"expiracao\":3600},\"devedor\":{\"cpf\":\"74339524204\",\"nome\":\"William Monteiro\"},\"valor\":{\"original\":\"1.00\"},\"chave\":\"ec85aa7d-3752-4f93-9bcf-2e14acdee26c\",\"solicitacaoPagador\":\"Pagamento do pedido 456\"}"

    headers = [{"Authorization", "Bearer #{token}"}, {"Content-Type", "application/json"}]
    options = [ssl: [certfile: "certificado.pem"]]

    {:ok, response} =
      HTTPoison.post(
        url,
        request,
        headers,
        options
      )

    response.body
  end

  def get_qrcode(token, locID) do
    url = "https://api-pix.gerencianet.com.br/v2/loc/#{locID}/qrcode"

    headers = [{"Authorization", "Bearer #{token}"}, {"Content-Type", "application/json"}]
    options = [ssl: [certfile: "certificado.pem"]]

    {:ok, response} =
      HTTPoison.get(
        url,
        headers,
        options
      )

    response.body
  end
end
