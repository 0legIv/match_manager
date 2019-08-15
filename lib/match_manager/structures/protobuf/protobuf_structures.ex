defmodule MatchManager.Protobuf.Structures do
  use Protobuf,
      """
        message MatchResults {

          message Div {
            required string div = 1;
        
            message Season {
              required string season = 1;

              message Match {
                required string away_team = 1;
                required string date = 2;
                required string div = 3;
                required string ftag = 4;
                required string fthg = 5;
                required string ftr = 6;
                required string home_team = 7;
                required string htag = 8;
                required string hthg = 9;
                required string htr = 10;
                required string season = 11;
              }
        
              repeated Match matches = 2;
              
            }
        
            repeated Season seasons = 2;
          }
          
          repeated Div divs = 1;
        }
      """
end
