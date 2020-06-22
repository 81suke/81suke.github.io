<?php
session_start();

$error_message = "";

if(isset($_POST["login"])) {

	if($_POST["password"] == "justice") {
		$_SESSION["user_name"] = $_POST["user_name"];
		$login_success_url = "./lecture.html";
		header("Location: {$login_success_url}");
		exit;
	}
$error_message = "※パスワードが間違っています。<br>　もう一度入力して下さい。";
}
?>