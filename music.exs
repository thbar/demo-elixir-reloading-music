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
      # We could write down :os.system_time(:milli_seconds) later
      # to dynamically recompute ticks based on elapsed time
      # and correct for drift
      device: device,
      tick_period: tick_period
    }, name: :midi)
  end

  def handle_info({:tick}, state) do
    # Immediately reschedule the next tick to reduce drift
    Process.send_after(:midi, {:tick}, state.tick_period)
    current_tick = Map.fetch!(state, :current_tick) + 1
    show_visual_feedback(current_tick)
    {:noreply, %{state | current_tick: current_tick, tick_period: 50}}
  end
  
  def show_visual_feedback(current_tick) do
    if rem(current_tick, 64) == 0 do
      IO.write IO.ANSI.clear <> IO.ANSI.home
    end
    if rem(current_tick, 8) == 0 do
      IO.write IO.ANSI.yellow <> to_string(1 + round(rem(current_tick, 64) / 8)) <> IO.ANSI.default_color
    end
  end
end