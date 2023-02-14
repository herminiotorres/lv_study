defmodule LvStudyWeb.LightLive do
  use LvStudyWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Front Proch Light</h1>
    <div id="light">
      <div class="meter">
        <span style={"width: #{@brightness}%"}>
          <%= @brightness %>%
        </span>
      </div>
      <button phx-click="off">
        <img src="/images/light-off.svg" alt="light off" />
      </button>
      <button phx-click="down">
        <img src="/images/down.svg" alt="decrement light by 10" />
      </button>
      <button phx-click="random">
        <img src="/images/fire.svg" alt="choose a random light number" />
      </button>
      <button phx-click="up">
        <img src="/images/up.svg" alt="increment light by 10" />
      </button>
      <button phx-click="on">
        <img src="/images/light-on.svg" alt="light on" />
      </button>
    </div>
    <form phx-change="update">
      <input
        type="range"
        min="0"
        max="100"
        name="brightness"
        value={@brightness}
      />
    </form>
    """
  end

  def handle_event("on", _params, socket) do
    socket = assign(socket, brightness: 100)

    {:noreply, socket}
  end

  def handle_event("up", _params, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))

    {:noreply, socket}
  end

  def handle_event("down", _params, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))

    {:noreply, socket}
  end

  def handle_event("off", _params, socket) do
    socket = assign(socket, brightness: 0)

    {:noreply, socket}
  end

  def handle_event("random", _params, socket) do
    socket = assign(socket, :brightness, Enum.random(0..100))

    {:noreply, socket}
  end

  def handle_event("update", %{"brightness" => brightness}, socket) do
    socket = assign(socket, :brightness, String.to_integer(brightness))

    {:noreply, socket}
  end
end
