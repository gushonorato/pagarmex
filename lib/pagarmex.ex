defmodule Pagarmex do
  import Pagarmex.Client
  alias Pagarmex.Config

  def new(opts \\ []), do: struct!(Config, opts)

  def create_plan(config \\ %Config{}, params),
    do: request(config, :post, "/plans", body: params)

  def get_plan(config \\ %Config{}, plan_id),
    do: request(config, :get, "/plans/#{plan_id}")

  def list_plans(config \\ %Config{}, params \\ %{}),
    do: request(config, :get, "/plans", query: params)

  def update_plan(config \\ %Config{}, plan_id, params),
    do: request(config, :put, "/plans/#{plan_id}", body: params)

  def delete_plan(config \\ %Config{}, plan_id),
    do: request(config, :delete, "/plans/#{plan_id}")

  def create_client(config \\ %Config{}, params),
    do: request(config, :post, "/customers", body: params)

  def get_client(config \\ %Config{}, customer_id),
    do: request(config, :get, "/customers/#{customer_id}")

  def update_client(config \\ %Config{}, customer_id, params),
    do: request(config, :put, "/customers/#{customer_id}", body: params)

  def list_clients(config \\ %Config{}, params \\ %{}),
    do: request(config, :get, "/customers", query: params)

  def create_card(config \\ %Config{}, customer_id, params),
    do: request(config, :post, "/customers/#{customer_id}/cards", body: params)

  def get_card(config \\ %Config{}, customer_id, card_id),
    do: request(config, :get, "/customers/#{customer_id}/cards/#{card_id}")

  def list_cards(config \\ %Config{}, customer_id),
    do: request(config, :get, "/customers/#{customer_id}/cards")

  def update_card(config \\ %Config{}, customer_id, card_id, params),
    do: request(config, :put, "/customers/#{customer_id}/cards/#{card_id}", body: params)

  def delete_card(config \\ %Config{}, customer_id, card_id),
    do: request(config, :delete, "/customers/#{customer_id}/cards/#{card_id}")

  def renew_card(config \\ %Config{}, customer_id, card_id),
    do: request(config, :post, "/customers/#{customer_id}/cards/#{card_id}/renew")

  def create_card_token(config \\ %Config{}, params),
    do:
      request(config, :post, "/tokens",
        body: params,
        query: [appId: Config.get_config!(config, :public_key)]
      )

  def create_subscription(config \\ %Config{}, params),
    do: request(config, :post, "/subscriptions", body: params)

  def get_subscription(config \\ %Config{}, subscription_id),
    do: request(config, :get, "/subscriptions/#{subscription_id}")

  def list_subscriptions(config \\ %Config{}, params),
    do: request(config, :get, "/subscriptions", query: params)

  def cancel_subscription(config \\ %Config{}, subscription_id),
    do: request(config, :delete, "/subscriptions/#{subscription_id}")

  def update_subscription_credit_card(config \\ %Config{}, subscription_id, params),
    do: request(config, :patch, "/subscriptions/#{subscription_id}/card", body: params)

  def update_subscription_metadata(config \\ %Config{}, subscription_id, params),
    do: request(config, :patch, "/subscriptions/#{subscription_id}/metadata", body: params)

  def update_subscription_affiliation(config \\ %Config{}, subscription_id, params) do
    request(config, :patch, "/subscriptions/#{subscription_id}/gateway-affiliation-id",
      body: params
    )
  end

  def update_subscription_payment_method(config \\ %Config{}, subscription_id, params) do
    request(config, :patch, "/subscriptions/#{subscription_id}/payment-method", body: params)
  end

  def update_subscription_start_at(config \\ %Config{}, subscription_id, params) do
    request(config, :patch, "/subscriptions/#{subscription_id}/start-at", body: params)
  end

  def update_subscription_minimum_price(config \\ %Config{}, subscription_id, params) do
    request(config, :patch, "/subscriptions/#{subscription_id}/minimum_price", body: params)
  end

  def enable_subscription_manual_billing(config \\ %Config{}, subscription_id),
    do: request(config, :post, "/subscriptions/#{subscription_id}/manual-billing")

  def disable_subscription_manual_billing(config \\ %Config{}, subscription_id),
    do: request(config, :delete, "/subscriptions/#{subscription_id}/manual-billing")
end
