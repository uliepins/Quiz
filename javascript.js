(function() {

	// this function builds and shows the test menu page
	function buildTestSelector(receivedTests) {
		let outputTests = [];
		let tests = [];
		let cntTests = 0;
		receivedTests.forEach((object) => {
			if(cntTests === 0){
				tests.push(`<option disabled selected value>${chooseTest}</option>`);
			}
			tests.push(`<option value="${object.TestID}">${object.TestName}</option>`);
			cntTests++;
		});
		outputTests.push(
			`<input id = "nameInput" type="text" name="name" value="" placeholder="${placeholder}"><br>
			<div class="select"><select id = "testSelector">${tests}</select></div>`
		);
		quizContainer.innerHTML = outputTests.join("");
	}
	
	// this function builds and shows the current question
	function buildQuestion(receivedQuestions, questionNumber) {
		// if final question, update testStatus
		if((totalQuestions - 1) == questionNumber){
			testStatus = "final";
		}
		// clear the screen
		quizContainer.innerHTML = "";
		// set test name to title bar
		if(questionNumber == 0){
			testTitle.innerHTML = testName;
		}
		// calculate progress bar level
		let percent = questionNumber*100/totalQuestions;
		// if zero, set to 3, so user feels that there is some progress :) 
		if(percent == 0){
			percent = 3;
		}
		moveProgressBar(percent);
		let answers = [];
		let cntAnswers = 0;
		userAnswer = null;
		correctAnswer = null;
		correctAnswer = receivedQuestions[questionNumber].CorrectAnswerLetter;
		questionID = receivedQuestions[questionNumber].QuestionID;
		answers.push(
			`<label class="question">${receivedQuestions[questionNumber].Question}</label>
			<div class="wrapper">`
			 );
		receivedQuestions[questionNumber].Answers.forEach((answer) => {
			answers.push(`
				<div class="gridItems" id="answer${cntAnswers}" title="${answer.AnswerLetter}">${answer.AnswerLetter}: ${answer.Answer}</div>`
			);
			cntAnswers++;
		});
		answers.push(`</div>`);
		quizContainer.innerHTML = answers.join("");
		// build onClickListeners
		document.querySelectorAll('.gridItems').forEach(function(e) {
		e.addEventListener('click', function() {
			// cancel all other selections
			let i;
			for (i = 0; i < cntAnswers; i++) { 
				document.getElementById("answer" + i).style.backgroundColor = colorWhite;
				document.getElementById("answer" + i).style.color = colorBlack;
			}
			this.style.backgroundColor = itemBackgroundColor;
			this.style.color = colorWhite;
			warningLabel.style.display = "none";
			userAnswer =  this.title;
			})
		});
	}
  
	function buttonPress(){  
		if(testStatus == "new"){
			let nameInput = document.getElementById("nameInput");
			let selectedTest = document.getElementById("testSelector");
			let testValue = selectedTest.options[selectedTest.selectedIndex];
			if (!nameInput.value || !testValue.value){
				warningLabel.style.display = "inline-block";
				if (!nameInput.value) {
					warningLabel.innerHTML  = enterName;
				}
				else if (!testValue.value){
					warningLabel.innerHTML  = chooseTest;
				}
			}
			else{
				testID = testValue.value;
				testName = testValue.text;
				userName = nameInput.value;
				warningLabel.style.display = "none";
				testStatus = "inProgress";	
				controlButton.innerHTML = nextQuestion;
				progressBar.style.display = "block";
				// get questions
				ajax_post("getQuestions");
			}
		}
		else if(testStatus == "inProgress" || "finalQuestion"){
			if(!userAnswer){
				warningLabel.style.display = "inline-block";
				warningLabel.style.marginTop = "20px";
				warningLabel.innerHTML = chooseAnswer;
			}
			else{
				questionNumber = questionNumber + 1;
				if(userAnswer == correctAnswer){
					correctAnswers++;
				}
				if(testStatus == "inProgress"){
					// update UserProgress table
					ajax_post("updateProgress"); 
					// generate next question
					buildQuestion(receivedQuestions, questionNumber);	
				}
				else if(testStatus == "final"){
					// update UserProgress table
					ajax_post("updateProgress"); 
					// update CompletedTests table
					ajax_post("updateCompletedTests"); 
					progressBar.style.display = "none";
					let finalMessage = [];
					finalMessage.push(`<label class="finalTitleMessage">Paldies, ${userName}!</label><br><br>
					<label class="finalDetailsMessage">Tu atbildēji pareizi uz ${correctAnswers} no ${totalQuestions} jautājumiem.</label>`);							
					quizContainer.innerHTML = finalMessage.join("");
					controlButton.innerHTML = startOver;
					testStatus = "reload";
				}
				else if(testStatus == "reload"){
					location.reload();
				}
			}
		}
	}
  
	function ajax_post(operationType){
		// ereate XMLHttpRequest object
		let hr = new XMLHttpRequest();
		let url = phpFileUrl;
		// set parameters for PHP invoke
		let vars = "operationType="+operationType+"&testID="+testID+"&userName="
		+userName+"&userAnswer="+userAnswer+"&questionID="+questionID+"&correctAnswers="
		+correctAnswers+"&totalQuestions="+totalQuestions;
		hr.open("POST", url, true);
		hr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		// access the onreadystatechange event
		hr.onreadystatechange = function(testStatus) {
			if(hr.readyState == 4 && hr.status == 200) {
				if(hr.responseText.length > 5){
					theResponse = JSON.parse(hr.responseText);
					// if received tests, show menu
					if(theResponse[0].TestID){
						buildTestSelector(theResponse);
					}
					// if received questions, show question and answers
					else if(theResponse[0].QuestionID){
						totalQuestions = theResponse.length;
						receivedQuestions = theResponse;
						buildQuestion(receivedQuestions, 0)
					}
				}
			}
		}
		// send the data to PHP
		hr.send(vars);
	}

	// this function changes the progressBar state
	function moveProgressBar(level) {
		let width = progressBar.style.width;
		width = width.replace("%", "");
		let id = setInterval(frame, 20);
		function frame() {
			if (width >= level) {
				clearInterval(id);
			}
		else {
			width++; 
			progressBar.style.width = width + '%'; 
		}
	  }
	}

	// default variables and contants
	const chooseTest = "Izvēlies testu";
	const placeholder = "Ievadi savu vārdu";
	const colorWhite = "white";
	const colorBlack = "black";
	const itemBackgroundColor = "#379CC3";
	const enterName = "Ievadi savu vārdu!";
	const nextQuestion = "Nākamais";
	const chooseAnswer = "Izvēlies atbilžu variantu!";
	const startOver = "Sākt no jauna";
	const phpFileUrl = "operations.php";

	let theResponse;
	let testID;
	let testName;
	let userName;
	let userAnswer;
	let questionID;
	let correctAnswer;
	let receivedQuestions;
	let testStatus = "new";
	let totalQuestions = 0;
	let correctAnswers = 0;
	let wrongAnswers = 0;
	let questionNumber = 0;

	const quizContainer = document.getElementById("quiz");
	const testTitle = document.getElementById("testTitle");
	const controlButton = document.getElementById("controlButton");
	const progressBar = document.getElementById("progressBar");
	const warningLabel = document.getElementById("warningLabel");

	// add onClick listener to main button
	controlButton.addEventListener("click", buttonPress);

	// call PHP to get the tests from db
	ajax_post("getTests"); 

})();
