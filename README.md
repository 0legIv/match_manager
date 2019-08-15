# MatchManager

## Application workflow

* When started, the application reads the csv file and save the result to the GenServer state, module - `MatchManager.MatchStore`

* There are the endpoints that receive get request and call the following functions in the `MatchManagerWeb.MatchController`

* These functions call corresponding functions in `MatchManager.MatchStore` depending on the requested result (JSON, Protocol Buffers)

* To create the result there are unified structures that can be found in `match_manager/structures`. 

## Starting the application

Start the application in the IEX:

* Enter the root directory of the application
* `mix deps.get`
* `iex -S mix phx.server`

Start the application with Docker:

* Enter the root directory of the application
* `docker build -t match_manager .`
* `docker run -i -t --net=host match_manager:latest`

Running the tests: 

* Enter the root directory of the application
* `mix deps.get`
* `mix test`

## ENV variables

* `${PORT}` - port on which the application will be launched
* `${DATA_FILE}` - csv file with match results

To run the docker container with this variables:

Example: `docker run -e PORT=4002 -e DATA_FILE="data.csv" -i -t --net=host match_manager:latest`

**By default dockerfile has predefined PORT=4001 and DATA_FILE="data.csv"**

## Endpoints

Default port for the application in prod - `4001`

`GET` request:
* `localhost:4001/matches` - list all data from the csv file in JSON
* `localhost:4001/matches/:div/:season` - retrieve the results for a specific league and season pair in JSON

* `localhost:4001/matches/proto` - list all data from the csv file in Protocol Buffers
* `localhost:4001/matches/proto/:div/:season` - retrieve the results for a specific league and season pair in Protocol Buffers
