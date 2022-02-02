# DataCrossing
A fan-made passion project. iOS app designed to keep track of data mined from Animal Crossing: New Horizons.

DataCrossing is a project I created over the past month as a way to track the vast amount of data provided by dataminers - in particular, credit goes to Ninji for providing the data DataCrossing uses.
Additionally, I've added this to my public repository as a representation to recruiters of what I am capable of. Unless otherwise noted, all code was written by me. 
DataCrossing also uses opensource code, and any bridging code I added in order to use it in-app is labelled as such. 

## Why Make This?
There is an insane amount of data to keep track of in Animal Crossing: New Horizons. I found the mathematics and logic behind each ACNH component fascinating, and wanted to create an app for keeping track of information usually tracked on paper (e.g. Which of the 80 Bugs, 80 Fish, and 40 Creatures have been caught? What can I catch this month? Which of the 2,147,483,647 weather seeds was your island assigned?). I want to add even more data moving forward, such as Turnip Prophet (which tracks the in-game stock market (stalk market), and flower genomes. 

## Dependencies
* Kingfisher (https://github.com/onevcat/Kingfisher)
* SwiftCSV (https://github.com/swiftcsv/SwiftCSV)

## Animal Crossing Resources 
* Data Spreadsheet for Animal Crossing: New Horizons (https://tinyurl.com/acnh-sheet)
* MeteoNook (https://github.com/Treeki/MeteoNook)

## Future Goals
* Add TurnipProphet (https://github.com/mikebryant/ac-nh-turnip-prices)
* Add a "Leaving This Month" Section to the Museum Page
* (~~Information screens for bugs, fish, and creatures including availability schedules~~)
* Allow for uncatching critters
* Add NPC schedule predictions
* Implement MeteoNook Seed Guessing and Weather Event storage
* Fossils and Art sections for Museum
* More Unit Tests

## Testing Information
Currently, DataCrossing allows for weather seed inputs or no weather seed. If you do not add a weather seed, the code currently will default you to the weather seed used by Dagnel (https://www.youtube.com/channel/UCHZfd9QFgqX1vJl8U7fSmKA) who partially inspired this app with his "Completing the Museum" speedrun. 

## Features

### MeteoNook and Weather Seeds
Every ACNH island is randomly assigned a weather seed between 1 and 2147483647. This number is unaccessible in-game, but determines all weather for that island moving forward. The team at MeteoNook created an online applet to keep track of your weather until you're able to narrow down your seed. (https://wuffs.org/acnh/weather/)
> There are over 2 billion possible weather seeds, but only one is correct for your island. MeteoNook goes through every single possibility, calculates the weather it would give, and checks it against the data you provide. If it doesn't make sense (e.g. you said you had rain at a given time, but the seed would make it sunny) then that possibility is ignored.

### Museum Pages
Currently, DataCrossing can track which of the 80 fish, 80 bugs, and 40 sea creatures you have and have not caught. This can also be tracked in game, but it can be cumbersome and no information is provided on a critter until you catch it (much like a Pokedex). The CSVs included have the data for what weather, location, and times (both of year and of day) that all living creatures can be caught in game. This is dependent on the hemisphere of your island, so DataCrossing will provide the information relevant to your islands hemisphere. 

README in progress. 

As I am working alone on a local machine, this may not be the most recent version of DataCrossing. I still have more to implement. If you're curious in the project in regards to a job opportunity,
I can answer any questions through email or interview.

If you're an Animal Crossing fan, please feel free to use this as you wish! I've made some basic bridging headers and functions to connect DataCrossing to the open-source code for MeteoNook, which was written in Rust.

CSVs are formatted from the spreadsheet at https://tinyurl.com/acnh-sheet. I've reformatted them heavily for what I needed in this project, but they are all derivative of this spreadsheet, which saved me a LOT of time collecting and typing information about the
various critters in-game (80 fish, 80 bugs, and 40 different deep-sea creatures!). 

:heart: Natalie (or Island Representative Nombi)

### Note
This project is a fan project, completely unaffiliated with Animal Crossing or Nintendo.
