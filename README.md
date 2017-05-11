# 411_Project_4
Project 4 for CPSC-411 Mobile Development
Name: Trajon Felton
Date Written: 5/10/2017
Description: Provides users with 6 different currencies and allows user to input an amount into a textfield and see the given exchange rate.

Note: I could not get the save state to work for the file. When this load it will always delay a total of 2 seconds in order to get all of 
The currencies. Tables will start off empty until they are added using the add button on the top right. After loaded user must press the 
refresh button in order to populate the table with their favorite exchange currencies. Pressing refresh again when the table is refreshed
will wipe out all current entries, leaving the tables blank again.

Note: Credits for YQL-swift file go directly to David McLaren, file is used for the purpose of creating a json request to yahoo's API Server.
Credits for parts of the Demo Function in teh CurrencyViewController file go partially to David Mclaren, for the functional idea. Purpose of 
this function is to make a request to yahoo's api and return a json dictionary of results that is passed into a dictionary containing 
the iso exchange as well as the rate.
