Create table deliveries
( 
id int ,
inning int,
over int,
ball int,
batsman varchar(50),
non_sticker varchar(50),
bowler varchar(50),
batsman_run int,
extra_runs int,
total_runs int,
is_wicket int,
dismissal_kind varchar(50),
player_dismissed varchar(50),
fielder varchar(50),
extra_type varchar(50),
batting_team varchar(50),
bowling_team varchar(50),
	constraint fk_matches
	foreign key(id)
	references matches(id)	
)

copy deliveries from 'V:\SQL Internshala\Data-Resource\IPL_Ball.csv' csv header


select *
from deliveries