defmodule Pagarmex.Client do
  alias Plug.Conn.Query

  alias Pagarmex.Config

  @request_url "https://api.pagar.me/core/v5"

  def request(config, method, path, params \\ []) do
    method
    |> Finch.build(
      build_request_url(path, params),
      [
        {"Authorization", "Basic #{encode_credentials(config)}"},
        {"Content-Type", "application/json"},
        {"User-Agent", "Pagarmex/#{Pagarmex.MixProject.project()[:version]}"}
      ],
      build_request_body(params)
    )
    |> IO.inspect(label: "request")
    |> Finch.request(Pagarmex.Finch)
    |> parse_as_json()
  end

  defp encode_credentials(config) do
    Base.encode64(Config.get_config!(config, :secret_key) <> ":", padding: true)
  end

  defp build_request_url(path, params) do
    query_params = params |> Keyword.get(:query, %{}) |> Query.encode()
    "#{@request_url}#{path}?#{query_params}"
  end

  defp build_request_body(params) do
    params
    |> Keyword.get(:body, %{})
    |> Jason.encode!()
  end

  defp parse_as_json({:ok, %Finch.Response{status: 200, body: body}}) do
    Jason.decode(body)
  end

  defp parse_as_json({:ok, %Finch.Response{status: error_code, body: body}}) do
    case Jason.decode(body) do
      {:ok, decoded_body} ->
        {:error, {:http, error_code, decoded_body}}

      _ ->
        {:error, {:http, error_code, body}}
    end
  end

  defp parse_as_json({:error, _exception} = error), do: error
end
