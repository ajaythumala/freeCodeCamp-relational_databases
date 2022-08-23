#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.


while IFS=, read -r field1 field2 field3 field4 field5 field6
do
    if [[ $field3 == 'winner' ]]
    then
      continue
    fi
    $PSQL "insert into teams(name) values('$field3')"
    $PSQL "insert into teams(name) values('$field4')"
    winner=$($PSQL "select team_id from teams where name = '$field3'")
    opponent=$($PSQL "select team_id from teams where name = '$field4'")
    $PSQL "insert into games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($field1, '$field2', $winner, $opponent, $field5, $field6)"
done < games.csv | tail -n +2


