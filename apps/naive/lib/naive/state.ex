defmodule Naive.State do
  @enforce_keys [:symbol, :profit_interval, :tick_size]
  defstruct [
    :symbol,
    :profit_interval,
    :tick_size,
    :buy_order,
    :sell_order
  ]
end
