<?php

// connect to db
require_once("includes/db_connect.php");

class ManageTests {
	
	public function getTests($connection){

		$sql = "SELECT * FROM Tests";
		$result = $connection->query($sql);
		$results = array();
		$i = 0;
		
		if ($result->num_rows > 0) {
			// output data of each row
			while($row = $result->fetch_assoc()) {
				
				$results [$i]["TestID"]= $row["TestID"];
				$results [$i]["TestName"]= $row["TestName"];
				$i++;
			}
			$JSONResponse = json_encode($results);
			echo $JSONResponse;
		} 
		else {
			
			echo "NR";
		}
		$connection->close();
	}
	
	public function getQuestions($connection, $testID){
		
		$sqlQuestions = "SELECT QuestionID, Question, CorrectAnswerLetter 
		FROM Questions WHERE TestID = '$testID'
		ORDER BY QuestionID ASC";

		$resultQuestions = $connection->query($sqlQuestions);
		$results = array();
		$i = 0;
		$i2 = 0;
		
		if ($resultQuestions->num_rows > 0) {
			// output data of each row
			while($row = $resultQuestions->fetch_assoc()) {
				
				$questionID  = $row["QuestionID"];
				$results [$i]["QuestionID"]= $questionID;
				$results [$i]["Question"]= $row["Question"];
				$results [$i]["CorrectAnswerLetter"]= $row["CorrectAnswerLetter"];
				
				// query for answers
				$sqlAnswers = "SELECT Answer, AnswerLetter 
				FROM Answers where QuestionID = '$questionID'
				ORDER BY AnswerLetter ASC";
				
				$resultAnswers = $connection->query($sqlAnswers);
				$i2 = 0;
				if ($resultAnswers->num_rows > 0) {
					while($row2 = $resultAnswers->fetch_assoc()) {
						$results [$i]["Answers"][$i2]["Answer"] = $row2["Answer"];
						$results [$i]["Answers"][$i2]["AnswerLetter"] = $row2["AnswerLetter"];
						$i2++;
					}
				}
				$i++;
			}
			
			$JSONResponse = json_encode($results);
			echo $JSONResponse;
		} 
		else {
			echo "NR";
		}
		$connection->close();
	}
	
	public function updateProgress($connection, $testID, $userName, $questionID, $userAnswer){
		
		$sqlUpdateProgress = "INSERT INTO UserProgress VALUES (
		'$userName', '$testID', '$questionID', '$userAnswer', CURRENT_TIMESTAMP)";
		
		if ($connection->query($sqlUpdateProgress) === TRUE) {
		echo "OK";
		}
		else {
			echo "ERR";
		}
		$connection->close();
	}
	
	public function updateCompletedTests($connection, $testID, $userName, $correctAnswers, $totalQuestions){
		
		$sqlupdateCompletedTests = "INSERT INTO CompletedTests VALUES (
		'$userName', '$testID', '$correctAnswers', '$totalQuestions', CURRENT_TIMESTAMP)";
		
		if ($connection->query($sqlupdateCompletedTests) === TRUE) {
		echo "OK";
		}
		else {
			echo "ERR";
		}
		$connection->close();
	}
}

// receive request from javaScript

// get tests
if ($_POST["operationType"] == "getTests"){
	$getTests = new ManageTests();
	$getTests -> getTests($connection);
}
// get questions 
else if ($_POST["operationType"] == "getQuestions"){
	$getQuestions = new ManageTests();
	$getQuestions -> getQuestions($connection, $_POST["testID"]);
}
// update user progress
else if ($_POST["operationType"] == "updateProgress"){
	$updateUserProgress = new ManageTests();
	$updateUserProgress -> updateProgress($connection, $_POST["testID"], $_POST["userName"], $_POST["questionID"], $_POST["userAnswer"]);
}

// update completed tests
else if ($_POST["operationType"] == "updateCompletedTests"){
	$updateCompletedTests = new ManageTests();
	$updateCompletedTests -> updateCompletedTests($connection, $_POST["testID"], $_POST["userName"], $_POST["correctAnswers"], $_POST["totalQuestions"]);
}

?>