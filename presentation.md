## Elixir Hot-Reloading & MIDI notes generation

---

### How to implement a very simple Elixir code hot-reloading example?

---

### How to make something funny or interesting out of it?

--- 

### Live sound events generation :smile:

---

### How to generate one note?

---

# Renoise (music production system)

![inline](renoise.png)

---

# PortMidi (C library)

![inline](portmidi.png)

---

# Elixir bindings for PortMidi

![inline](ex-portmidi.png)

---

```elixir
# Start a process for MIDI event queue
{:ok, pid} = PortMidi.open(:output, "Renoise MIDI-In")

note = 48 # C-4
velocity = 127

# Send "NOTE ON"
PortMidi.write(pid, {0x90, note, velocity})

# Send "NOTE OFF"
PortMidi.write(pid, {0x80, note})
```
