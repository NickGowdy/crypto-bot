defmodule Streamer.Binance do
  use WebSockex
  require Logger
  alias Streamer.Binance.TradeEvent
  alias Naive

  @stream_endpoint "wss://testnet.binance.vision/ws/"

  def start_link(symbol) do
    IO.inspect("Trying to start websockex with symbol #{symbol}")
    symbol = String.downcase(symbol)

    WebSockex.start_link(
      "#{@stream_endpoint}#{symbol}@trade",
      __MODULE__,
      nil
    )
  end

  def handle_frame({type, msg}, state) do
    case Jason.decode(msg) do
      {:ok, event} -> process_event(event)
      {:error, _} -> Logger.error("Unable to parse msg: #{msg}")
    end

    {:ok, state}
  end

  def process_event(%{"e" => "trade"} = event) do
    trade_event = %TradeEvent{
      :event_type => event["e"],
      :event_time => event["E"],
      :symbol => event["s"],
      :trade_id => event["t"],
      :price => event["p"],
      :quantity => event["q"],
      :buyer_order_id => event["b"],
      :seller_order_id => event["a"],
      :trade_time => event["T"],
      :buyer_market_maker => event["m"]
    }

    Logger.debug(
      "Trade event recieved " <>
        "#{trade_event.symbol}@#{trade_event.price}"
    )

    Naive.send_event(trade_event)
  end
end
