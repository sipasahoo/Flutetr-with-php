<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "flutter_php";
$table = "table_user";
// we will get actions from the app to do operations in the database...
$action = $_POST["action"];
// Create Connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check Connection
if ($conn->connect_error) {
    die("Connection Failed: " . $conn->connect_error);
    return;
}

if ("ADD_USER" == $action) {
    // App will be posting these values to this server
    $user_name = $_POST["user_name"];
    $user_email = $_POST["user_email"];
    $user_password = md5($_POST["user_password"]);
    $current_date = date('Y-m-d H:i:s');
    $sql = "INSERT INTO $table (user_name, user_email,user_password,created_date) VALUES ('$user_name', '$user_email','$user_password','$current_date')";
    $result = $conn->query($sql);
    echo "success";
    $conn->close();
    return;
}
if ($action == "GET_ALL") {
    $sql = "select * from table_user";
    $result = $conn->query($sql);
    $response = array();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            array_push($response, $row);
        }
    }
    echo json_encode($response);
}
if ($action == "GET_EXIST_USER") {
    $email = $_POST["email"];
    $sql = "select * from table_user WHERE user_email='$email'";
    $result = $conn->query($sql);
    $response = array();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            array_push($response, $row);
        }
    }
    echo json_encode($response);
}
if ($action == "GET_LOGIN_USER") {
    $email = $_POST["email"];
    $password = md5($_POST["password"]);
    $sql = "select * from table_user WHERE user_email='$email' AND user_password='$password'";
    $result = $conn->query($sql);
    $response = array();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            array_push($response, $row);
        }
    }
    echo json_encode($response);
}
