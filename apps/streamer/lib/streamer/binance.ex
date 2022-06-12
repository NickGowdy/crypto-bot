defmodule Streamer.Binance do
  use WebSockex

  @stream_endpoint "wss://stream.binance.com:9443/ws/"

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
    IO.puts("Recieved message - Type: #{inspect(type)} -- Message: #{inspect(msg)}")
    {:ok, state}
  end
end
