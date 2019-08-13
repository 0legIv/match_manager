defmodule MatchManager.MatchStore do
  use GenServer
  alias MatchManager.Structures.MatchDiv

  require Logger

  def start_link(_params) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(_args) do
    data =
      with file when not is_nil(file) <- Application.get_env(:match_manager, :data_file),
           {:ok, data} <- parse_csv(file) do
        data
      else
        {:error, reason} ->
          Logger.error("#{inspect(reason)}")
          %{}

        nil ->
          Logger.error("env DATA_FILE not set")
          %{}
      end

    {:ok, data}
  end

  def list_data() do
    GenServer.call(__MODULE__, :list_data)
  end

  def find_matches(div, season) do
    GenServer.call(__MODULE__, {:find_matches, div, season})
  end

  def update_state_from_file(path) do
    GenServer.call(__MODULE__, {:update_state, path})
  end

  def list_data_json() do
    list_data()
    |> MatchDiv.to_struct()
    |> MatchDiv.from_struct()
  end

  def parse_csv(path) do
    if File.exists?(path) do
      parsed_data =
        path
        |> File.stream!()
        |> CSV.decode!(headers: true)
        |> Stream.map(fn match -> Map.delete(match, "") end)

      divs_map =
        Enum.reduce(parsed_data, %{}, fn match, acc ->
          Map.put(acc, match["Div"], %{})
        end)

      seasons =
        Enum.reduce(parsed_data, divs_map, fn match, acc ->
          put_in(acc, [match["Div"], match["Season"]], [])
        end)

      full_response =
        Enum.reduce(parsed_data, seasons, fn match, acc ->
          match_list = acc[match["Div"]][match["Season"]] ++ [match]
          put_in(acc, [match["Div"], match["Season"]], match_list)
        end)

      {:ok, full_response}
    else
      {:error, "File with results data not exist"}
    end
  end

  def handle_call(:list_data, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:find_matches, div, season}, _from, state) do
    matches = state[div][season]
    {:reply, matches, state}
  end

  def handle_call({:update_state, path}, _from, _state) do
    decoded_file = parse_csv(path)
    {:reply, :ok, decoded_file}
  end
end
