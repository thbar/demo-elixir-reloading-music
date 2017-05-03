The code in this repository demonstrates how to use Elixir "hot-reloading"
feature, together with MIDI events generation.

In short:

* `reloading.exs` monitors the file system and hot-reload `music.exs`
* `music.exs`:
  * relies on `GenServer` to ensure the "midi player" will keep state between code reloads
  * creates a "tick" every 50 milliseconds
  * uses `portmidi` to send MIDI events to [Renoise](https://www.renoise.com)

### How to use?

* Install [Renoise](https://www.renoise.com) demo and load `Song.xrns`
* Run the code:

```
brew install portmidi
mix deps.get
mix run --no-halt reloading.exs
```

* Edit `music.exs` to play around