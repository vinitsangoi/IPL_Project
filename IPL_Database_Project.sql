--- Title :-        IPL_Database Project
--- Created by :-   Vinit Sangoi
--- Date :-         19-07-2022
--- Tool used:-     PostgreSQL

/*
Description :- 
		• This is a IPL Database Project from my SQL training on Internshala. This database contains 2 tables deliveries & matches.
		• Deliveries table has 1,92,468 rows, where it contains ball by ball data from IPL 2008 to 2020.
		• Matches table has 816 rows, where it contains match to match data & results of matches played between IPL 2008 to 2020.
		• In this project, i was given with 24 SQL questions. You can check out my approach & queries below.
*/



--- Questions 5 TO 24 :- 

--- Q5) Select the top 20 rows of the deliveries table

	SELECT 	*
	FROM 	deliveries
	LIMIT 	20



--- Q6) Select the top 20 rows of the matches table

	SELECT 	*
	FROM 	matches
	LIMIT 	20



--- Q7) Fetch data of all the matches played on 2nd May 2013

	SELECT 	*
	FROM 	matches
	WHERE 	date = '2013-05-02'



--- Q8) Fetch data of all the matches where the margin of victory is more than 100 runs

-- For this question, we need to make some changes
-- result_margin column consist numeric & text both values, but the data type of column is varchar. Due to which we can't use aggregate functions
-- So in order to fix this, we will update the result_margin column and change 'NA' value to 0
	
	UPDATE 	matches
	SET 	result_margin = 0
	where 	result_margin = 'NA'


-- Now, we will change the data type of the result_margin column from varchar to integer
	
	ALTER TABLE 	matches
	ALTER COLUMN 	result_margin Type int Using result_margin :: integer


-- Answer of the question
	
	SELECT 	*
	FROM 	matches
	WHERE 	result_margin > 100



--- Q9) Fetch data of all the matches where the final scores of both teams tied and order it in descending order of the date

	SELECT 		*
	FROM 		matches
	WHERE 		result = 'tie'
	ORDER BY 	date desc



--- Q10) Get the count of cities that have hosted an IPL match

	SELECT 	count(distinct(city))
	FROM 	matches



--- Q11) Create table deliveries_v02 with all the columns of deliveries and an additional column ball_result containing value boundary, dot or other depending on the total_run (boundary for >= 4, dot for 0 and other for any other number)

	CREATE TABLE deliveries_v02 as 
	select 	*,
		CASE WHEN total_runs >= 4 THEN 'boundary'
		     WHEN total_runs = 0 THEN 'dot'
		     ELSE 'other'
		     END as ball_result
	FROM deliveries

    --- To view new table
	SELECT * FROM deliveries_v02	


--- Q12) Write a query to fetch the total number of boundaries and dot balls

-- We can solve this question through 2 methods. 
  -- 1st method will be to solve by the new deliveries_v02 table which was created above, 
  -- 2nd method will be to solve without creating an addition table


 -- Method 1 : Using new created table deliveries_v02
	SELECT 	  ball_result,
		  count(*)
	FROM 	  deliveries_v02
	WHERE 	  ball_result in ('boundary','dot')
	GROUP BY  ball_result


 -- Method 2 : Using the actual table deliveries
	SELECT 	* 
	FROM  (
		SELECT
		    case when total_runs>= 4 then 'boundary'
			 when total_runs = 0 then 'dot'
			 else 'other'
			 end as  ball_result,
		    count(*)
		FROM deliveries
		GROUP BY ball_result 
			  )  AS temp	
	WHERE 	ball_result IN ('boundary','dot')	



--- Q13) Write a query to fetch the total number of boundaries scored by each team

 -- Method 1 : Using new created table deliveries_v02
	SELECT 	  batting_team,
		  count(ball_result) AS total_boundaries
	FROM 	  deliveries_v02
	WHERE 	  ball_result = 'boundary' 
	GROUP BY  batting_team
	ORDER BY  total_boundaries desc


 -- Method 2 : Using the actual table deliveries
	SELECT * 
	FROM  (
		SELECT 	batting_team,	
			case when total_runs>= 4 then 'boundary'
			     when total_runs = 0 then 'dot'
			     else 'other'
			     end as  ball_result,
			count(*) AS total_boundaries
		FROM 	deliveries
		GROUP BY batting_team,ball_result 
		ORDER BY total_boundaries desc	
			  )  AS temp	
	WHERE 	ball_result IN ('boundary')



--- Q14) Write a query to fetch the total number of dot balls bowled by each team

 -- Method 1 : Using new created table deliveries_v02
	SELECT 	  bowling_team,
		  count(ball_result) as total_dotballs
	FROM 	  deliveries_v02
	WHERE 	  ball_result = 'dot'
	GROUP BY  bowling_team
	ORDER BY  total_dotballs desc


 -- Method 2 : Using the actual table deliveries
	SELECT 	* 
	FROM  (
		SELECT  batting_team,	
			Case when total_runs>= 4 then 'boundary'
			     when total_runs = 0 then 'dot'
			     else 'other'
			     end as  ball_result,
			count(*) AS total_dotballs
		FROM    deliveries
		GROUP BY batting_team,ball_result 
		ORDER BY total_dotballs desc	
			   )  AS temp	
	WHERE ball_result IN ('dot')


--- Q15) Write a query to fetch the total number of dismissals by dismissal kinds

	SELECT 	  dismissal_kind,
		  count(dismissal_kind) as count
	FROM 	  deliveries
	WHERE	  dismissal_kind <> 'NA'
	GROUP BY  dismissal_kind
	ORDER BY  count desc



--- Q16) Write a query to get the top 5 bowlers who conceded maximum extra runs

	SELECT 	  bowler,
		  sum(extra_runs) AS total_extras
	FROM 	  deliveries
	GROUP BY  bowler
	ORDER BY  total_extras desc
	LIMIT 	  5



--- Q17) Write a query to create a table named deliveries_v03 with all the columns of deliveries_v02 table and two additional column (named venue and match_date) of venue and date from table matches 

	CREATE TABLE deliveries_v03 AS 
	Select	a.*,
		b.venue,
		b.date
	FROM 	deliveries_v02 AS a
	JOIN 	matches AS b
	ON 		a.id = b.id

    --- To view new table
	SELECT * FROM deliveries_v03	



--- Q18) Write a query to fetch the total runs scored for each venue and order it in the descending order of total runs scored

-- We can solve this question through 2 methods. 
  -- 1st method will be to solve by the new deliveries_v03 table which was created above, 
  -- 2nd method will be to solve without creating an addition table


 -- Method 1 : Using new created table deliveries_v03
	SELECT 	  venue,
	          sum(total_runs) as runs_scored
	FROM 	  deliveries_v03
	GROUP BY  venue
	ORDER BY  runs_scored desc


 -- Method 2 : Using the actual table deliveries
	SELECT 	  m.venue,
	          sum(d.total_runs) AS runs_scored
	FROM 	  deliveries AS d
	JOIN 	  matches AS m
	ON 		  d.id = m.id
	GROUP BY  venue 
	ORDER BY  runs_scored desc



--- 19) Write a query to fetch the year-wise total runs scored at Eden Gardens and order it in the descending order of total runs scored

 -- Method 1 : Using new created table deliveries_v03
	SELECT 	  extract( year from date ) AS ipl_year,
	          sum(total_runs) as runs
	FROM 	  deliveries_v03
	WHERE 	  venue = 'Eden Gardens'
	GROUP BY  ipl_year
	ORDER BY  runs desc


 -- Method 2 : Using the actual table deliveries
	SELECT 	  extract( year from m.date) AS ipl_year,
		  sum(d.total_runs) AS runs
	FROM 	  deliveries AS d
	JOIN 	  matches AS m
	ON 		  d.id = m.id
	WHERE 	  venue = 'Eden Gardens'
	GROUP BY  ipl_year
	ORDER BY  runs desc



--- Q20) Create a new table deliveries_v04 with the first column as ball_id containing information of match_id, inning, over and ball separated by ‘-’ (For ex. 335982-1-0-1 match_id-inning-over-ball) and rest of the columns same as deliveries_v03)

	CREATE TABLE deliveries_v04 AS 
	SELECT 	concat(id,'-',inning,'-',over,'-',ball) AS ball_id, 
			* 
	FROM 	deliveries_v03

    --- To view new table
	SELECT * FROM deliveries_v04



--- Q21) Compare the total count of rows and total count of distinct ball_id in deliveries_v04

	SELECT 	count(*)as total_rows,
		count(distinct ball_id) as distinct_ball_id
	FROM 	deliveries_v04	



--- Q22) Create table deliveries_v05 with all columns of deliveries_v04 and an additional column for row number partition over ball_id. 

 
	CREATE TABLE deliveries_v05 AS 
	SELECT 	*, 
		row_number() over (partition by ball_id) as r_num 
	FROM 	deliveries_v04;



--- Q23) Use the r_num created in deliveries_v05 to identify instances where ball_id is repeating.

	SELECT 	*
	FROM  	deliveries_v05 
	WHERE 	r_num = 2



--- Q24) Use subqueries to fetch data of all the ball_id which are repeating. 

	SELECT 	  *
	FROM 	  deliveries_v05
	WHERE 	  ball_id in ( SELECT ball_id 
			       FROM deliveries_v05 
			       WHERE r_num=2 )
	ORDER BY  ball_id



