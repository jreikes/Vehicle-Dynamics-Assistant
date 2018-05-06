<?
$resourceName="Vehicle Dynamics Assistant";
?>
<img src="<?=$path;?>/title.gif" width="574" height="80" alt="Vehicle Dynamics Assistant">

<hr>
<br>
<b>Disclaimer</b><br>
This tool is provided only to provide general guidance to troubleshooting handling problems.  In practice, there are countless variables that can impact a car's handling, not all of which are fully addresssed here.  The advice provided by this tool should not be used without consulting with a trained professional.  Additionally, any changes made to a vehicle's setup should be performed by a trained professional.  Please consult your vehicle's warranty materials and service manual to be sure any changes you make will not void your vehicle's warranty and will not bring it outside of its design tolerances.<br>
<br>
<hr>
<br>
<?
include ("$path/config.php");

//Grab all the variables that have been passed
$problems = $_POST['problems'];
$adjustable = $_POST['adjustable'];
//$drivenWheels = $_POST['drivenWheels'];
//$lsdFront = $_POST['lsdFront'];
//$lsdRear = $_POST['lsdRear'];
$submit = $_POST['submit'];
$restart = $_POST['restart'];

function listSolutions($availability) {
	global $solutions, $result, $adjustable, $problem;
	$solutions = explode (", ", $result[solutions]);
	foreach ($solutions as $solution) {
		if (eregi ("(\+|\-)?([0-9]+)(f|r)?", $solution, $solution_parsed)) {
			$query_solution = mysql_query("SELECT * FROM adjustments WHERE id=\"$solution_parsed[2]\";")
			or print("Error - Solution query failed<br>\n");
			$result_solution = mysql_fetch_array($query_solution);

			//check if hidden solution's aliases are available
			$alias_available = 0;
			if ($result_solution[adjustment_group] == "Hidden") {
				foreach (explode(", ", $result_solution[adjustment]) as $solution_alias) {
					if ($adjustable[$solution_alias] == 1) {
						$alias_available = 1;
					}
				}
			}

			//check if either 1) the adjustment's presence/non presence is equal to whether we're printing present/not present vars; 2) the adjustment is hidden and set as "0" meaning all cars can check it; or 3) the adjustment is hidden and the alias presence/not presence matches the availability variable
			if ((($adjustable[$solution_parsed[2]] == $availability) && ($result_solution[adjustment] != "0") && ($alias_available != "1")) || ($result_solution[adjustment] == "0" && $availability == 1) || (($alias_available == 1) && ($availability == 1))) {
				echo "<li>";
				if ($solution_parsed[1] == "+") {
					//positive adjustment
					if ($problem > 0) {
						echo $result_solution[positive];
					}
					else {
						echo $result_solution[negative];
					}
				}
				else {
					//negative adjustment
					if ($problem > 0) {
						echo $result_solution[negative];
					}
					else {
						echo $result_solution[positive];
					}
				}
				if ($solution_parsed[3] == "f") {
					echo " front";
				}
				if ($solution_parsed[3] == "r") {
					echo " rear";
				}
				echo "</li>\n";
			}
		}
		else {
			echo "Solutions parse error.\n";
		}
	}
}

//Connect to and select database
$db_link = mysql_connect($mysql_host, $mysql_user, $mysql_password)
  or print("Error - Could not connect to database<br>\n<br>\n");
mysql_select_db($dbname)
  or print("Could not select vehicle dynamics database.<br>\n<br>\n");

//Do the following if the user's info has not yet been input
if (!$submit) {
	echo "<form action=\"$link\" method=\"post\" name=\"vehicleInfo\" id=\"vehicleInfo\">\n";
	
	//Collect information on the car's problems
	echo "<b>Problems</b><br>\n"
		."Please select the handling problems you wish to address<br>\n"
		."<br>";

	//Select all of the oversteer/understeer problems from the database
	$query = mysql_query("SELECT id, problem FROM problems WHERE problem_type='0' ORDER BY id;")
    or print("Error - oversteer/understeer problems query failed<br>\n<br>\n");
	
	while ($result = mysql_fetch_array($query)) {
		echo "$result[problem]:<br>\n"
			."<input type=\"radio\" name=\"problems[$result[id]]\" value=\"0\" checked> Neutral / No problem<br>\n"
			."<input type=\"radio\" name=\"problems[$result[id]]\" value=\"-1\"> Understeer<br>\n"
			."<input type=\"radio\" name=\"problems[$result[id]]\" value=\"1\"> Oversteer<br>\n"
			."<br>\n";
	}
	
	echo "<br>\n"
		."Other common issues:<br>\n";
	
	//Select all of the present / not present problems from the database
	$query = mysql_query("SELECT id, problem FROM problems WHERE problem_type='1' ORDER BY id;")
    or print("Error - present/not present problems query failed<br>\n<br>\n");
	
	while ($result = mysql_fetch_array($query)) {
		echo "<input type=\"hidden\" name=\"problems[$result[id]]\" value=\"0\">\n"
			."<input type=\"checkbox\" name=\"problems[$result[id]]\" value=\"1\"> $result[problem]<br>\n";
	}

/*
	//Collect information on the vehicle's adjustability
	echo "<br>\n"
		."<hr>\n"
		."<br>\n"
		."<b>Vehicle Information</b><br>\n"
		."Please provide some basic information on your vehicle<br>\n"
		."<br>\n"
		."Driven wheels:<br>\n"
		."<input type=\"radio\" name=\"drivenWheels\" value=\"r\" checked> Rear<br>\n"
		."<input type=\"radio\" name=\"drivenWheels\" value=\"f\"> Front<br>\n"
		."<input type=\"radio\" name=\"drivenWheels\" value=\"a\"> All<br>\n"
		."<br>\n"
		."Is your car equiped with a limited slip differential?<br>\n"
		."<input type=\"checkbox\" name=\"lsdFront\" value=\"1\"> front<br>\n"
		."<input type=\"checkbox\" name=\"lsdRear\" value=\"1\"> rear<br>\n";
*/

		echo "<br>\n"
		."<hr>\n"
		."<br>\n"
		."<b>Adjustability</b><br>\n"
		."Please check what variables of your car's setup you are able to change with your current setup and within any applicable rules your club or sanctioning body may have:<br>\n";

	//Select the various group names (which aren't "hidden") and create an array of just the unique groups
	$query = mysql_query("SELECT DISTINCT adjustment_group FROM adjustments WHERE adjustment_group!=\"Hidden\";")
    or print("Error - Group query failed<br>\n<br>\n");
	
	while ($result = mysql_fetch_array($query)) {
		echo "<br>\n"
			."$result[adjustment_group]:<br>\n";
		$query2 = mysql_query("SELECT id, adjustment FROM adjustments WHERE adjustment_group=\"$result[adjustment_group]\" ORDER BY id;")
		or print("Error - Adjustment query failed<br>\n<br>\n");
		while ($result2 = mysql_fetch_array($query2)) {
			echo "<input type=\"hidden\" name=\"problems[$result[id]]\" value=\"0\">\n"
				."<input type=\"checkbox\" name=\"adjustable[$result2[id]]\" value=\"1\"> $result2[adjustment]<br>\n";
		}
	}

	//close the page/form
	echo "<br>\n"
		."<hr>\n"
		."<br>\n"
		."<input type=\"submit\" name=\"submit\" value=\"Submit\">&nbsp;&nbsp;<input type=\"reset\" name=\"reset\" value=\"Reset\">\n"
		."</form>";
}

//Do the following once the user has submitted the variables
else {
	$i = 1;
	foreach ($problems as $problem) {
		if ($problem) {
			$query = mysql_query("SELECT problem_type, problem, solutions FROM problems WHERE id=\"$i\";")
			or print("Error - Problem query failed<br>\n<br>\n");
			$result = mysql_fetch_array($query);
			
			echo "<b>$result[problem]";
			if ($result[problem_type] == 0 && $problem == 1) {
				echo " - Oversteer";
			}
			elseif ($result[problem_type] == 0 && $problem == -1) {
				echo " - Understeer";
			}
			echo "</b><br>\n"
				."<br>\n"
				."Solutions available within currently available adjustments:<br>\n"
				."<ul>\n";
			listSolutions(1);
			echo "</ul>\n"
				."Other possible solutions to your problem*:<br>\n"
				."<ul>\n";
			listSolutions(0);
			echo "</ul>\n"
				."<br>\n"
				."<hr>\n"
				."<br>\n";
		}
		$i++;
	}

echo "* Before making modifications to your vehicle to increase its adjustability, first make sure the problem you are attempting to address is in fact a problem.  Make sure an experienced driver has tested the vehicle on a closed racetrack as this is the only way to accurately and safely determine what problems a car may or may not be experiencing.  If indeed there is a problem that you wish to address by changing the vehicle, it is usually best to first try resolving the problem via the adjustments you currently have available, rather than modifying the vehicle and adding more variables to the equation.<br>\n"
	."<br>\n"
	."<form action=\"$link\" method=\"post\" name=\"restart\" id=\"restart\">\n"
	."<input type=\"submit\" name=\"restart\" value=\"Restart Application\"><br>\n"
	."</form>";
}

//Close connection to database
mysql_close($db_link);

echo "\n";
?>