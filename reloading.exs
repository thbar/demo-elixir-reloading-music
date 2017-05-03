# This avoids "warning: redefining module Midi" which occurs on reload
Code.compiler_options(ignore_module_conflict: true)

defmodule Monitor do
  use ExFSWatch, dirs: ["music.exs"], listener_extra_args: "--latency=0.0"
  
  def callback(_file_path, _events) do
    reload()
  end
  
  def reload do
    Code.eval_file("music.exs")
  end
end

# Force a first load at startup
Monitor.reload

# Make monitor watch the filesystem
Monitor.start

Midi.start_link