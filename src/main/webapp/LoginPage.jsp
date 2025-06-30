<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background: #f0f2f5;
      font-family: Arial, sans-serif;
      display: flex;
      height: 100vh;
      justify-content: center;
      align-items: center;
    }

    .login-container {
      background: #fff;
      padding: 2rem;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      width: 300px;
    }

    .login-container h2 {
      margin-bottom: 1.5rem;
      text-align: center;
      color: #333;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 0.75rem;
      margin-bottom: 1rem;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 1rem;
    }

    button {
      width: 100%;
      padding: 0.75rem;
      background-color: #4a90e2;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 1rem;
      cursor: pointer;
    }

    button:hover {
      background-color: #357ab8;
    }
  </style>
</head>
<body>

  <div class="login-container">
    <h2>Room id</h2>
    <form action="/Java.Tomcat.RPS/RPSPage.jsp" method="POST">
      <input type="text" name="enterRoom" placeholder="room123" required>
      <button type="submit">Enter</button>
    </form>
  </div>

</body>
</html>
