defmodule Midi do
  use GenServer
  require Logger
  
  def start_link do
    # Logger.info "Available devices: #{inspect PortMidi.devices}"
    {:ok, device} = PortMidi.open(:output, "Renoise MIDI-In")
    tick_period = 50
    Process.send_after(:midi, {:tick}, tick_period)
    GenServer.start_link(__MODULE__, %{
      current_tick: -1,
      device: device,
      tick_period: tick_period
    }, name: :midi)
  end

  def handle_info({:tick}, state) do
    Process.send_after(:midi, {:tick}, state.tick_period)
    current_tick = Map.fetch!(state, :current_tick) + 1
    {:noreply, %{state | current_tick: current_tick, tick_period: 50}}
  end
end