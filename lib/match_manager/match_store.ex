defmodule MatchManager.MatchStore do
  use GenServer
  alias MatchManager.Structures.MatchDiv
  alias MatchManager.Protobuf.MatchResults

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

  @spec list_data() :: map()
  def list_data() do
    GenServer.call(__MODULE__, :list_data)
  end

  @spec find_matches(String.t(), String.t()) :: list()
  def find_matches(div, season) do
    GenServer.call(__MODULE__, {:find_matches, div, season})
  end

  @spec update_state_from_file(String.t()) :: :ok
  def update_state_from_file(path) do
    GenServer.call(__MODULE__, {:update_state, path})
  end

  @spec list_data_json() :: list()
  def list_data_json() do
    case list_data() do
      data when data == %{} ->
        {:error, :no_data}

      {:error, reason} ->
        {:error, reason}

      matches ->
        matches_json =
          matches
          |> MatchDiv.to_struct()
          |> MatchDiv.from_struct()

        {:ok, matches_json}
    end
  end

  @spec list_data_proto() :: binary()
  def list_data_proto() do
    list_data()
    |> MatchResults.to_struct()
    |> MatchResults.encode()
  end

  @spec parse_csv(String.t()) :: {:ok, list()} | {:error, String.t()}
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
    case get_in(state, [div, season]) do
      nil ->
        Logger.error("Matches not found")
        {:reply, {:error, :match_not_found}, state}

      matches ->
        {:reply, {:ok, matches}, state}
    end
  end

  def handle_call({:update_state, path}, _from, _state) do
    case parse_csv(path) do
      {:ok, decoded_file} ->
        {:reply, :ok, decoded_file}

      {:error, reason} ->
        {:reply, {:error, reason}, %{}}
    end
  end
end
