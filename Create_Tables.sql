--- Title :-        IPL_Database Project
--- Created by :-   Vinit Sangoi
--- Date :-         19-07-2022
--- Tool used:-     PostgreSQL

/*
Description :- 
		• This is a IPL Database Project from my SQL training on Internshala. This database contains 2 tables deliveries & matches.
		• Deliveries table has 1,92,468 rows, where it contains ball by ball data from IPL 2008 to 2020.
		• Matches table has 816 rows, where it contains match to match data & results of matches played between IPL 2008 to 2020.
		• In this project, i was given with 25 SQL questions. You can check out my approach & queries below.
*/



--- Questions :- 

--- Q1) Create a table named 'matches' with appropriate data types for columns

CREATE TABLE matches02
    (
	id 			int 		primary key,
	city 			varchar(50),	
	date 			date,	
	player_of_match 	varchar(50),
	venue 			varchar (100),
	neutral_venue 		int,
	team1 			varchar(50),
	team2 			varchar(50),
	toss_winner 		varchar(50),
	toss_decision 		varchar(50),
	winner 			varchar(50),
	result 			varchar(50),
	result_margin 		int,
	eliminator 		varchar(50),
	method 			varchar(50),
	umpire1 		varchar(50),
	umpire2 		varchar(50)		
    )	



--- Q2) Create a table named 'deliveries' with appropriate data types for columns

Create table deliveries
   ( 
	id 			int,
	inning 			int,
	over 			int,
	ball 			int,
	batsman 		varchar(50),
	non_sticker 		varchar(50),
	bowler 			varchar(50),
	batsman_run 		int,
	extra_runs 		int,
	total_runs 		int,
	is_wicket 		int,
	dismissal_kind 		varchar(50),
	player_dismissed 	varchar(50),
	fielder 		varchar(50),
	extra_type 		varchar(50),
	batting_team 		varchar(50),
	bowling_team 		varchar(50),
	
	constraint fk_matches
	foreign key(id)
	references matches(id)	
   )



--- Q3) Import data from csv file 'IPL_matches.csv' attached in resources to 'matches' table
-- Note : Change the file path according to your device.

  copy matches from 'V:\SQL Internshala\Data-Resource\IPL_matches (3).csv' CSV Header
 


--- Q4) Import data from csv file 'IPL_Ball.csv' attached in resources to 'deliveries' table
-- Note : Change the file path according to your device.

   copy deliveries from 'V:\SQL Internshala\Data-Resource\IPL_Ball.csv' csv header
  
  
--- 𝗖𝗵𝗲𝗰𝗸 𝗼𝘂𝘁 𝗻𝗲𝘅𝘁 IPL_Database_Project.sql 𝗳𝗶𝗹𝗲 𝗳𝗼𝗿 𝘁𝗵𝗲 𝗳𝘂𝗿𝘁𝗵𝗲𝗿 𝗾𝘂𝗲𝘀𝘁𝗶𝗼𝗻𝘀
