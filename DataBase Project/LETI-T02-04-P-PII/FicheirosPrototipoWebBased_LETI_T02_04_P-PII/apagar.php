<?php
	include_once("conexao.php");
?>
	
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<title>BD Biblioteca - Apagar</title>
	</head>
	<body background=#ffffff>
		<p><h3>Apagar publicação </h3></p>

		<?php
			$id = $_POST["Id"];
			$sql = "DELETE FROM publicacao WHERE Id = $id";
			if(mysqli_query($conn, $sql)){
			echo "Publicação eliminada com sucesso";
			}else{
				echo "Error deleting record: " . mysqli_error($conn);
			}
		?>
		<br>
		<br><br>
		<a href="listar.php">voltar</a> | <a href="menu.html">voltar ao menu</a>
	</body>
</html>
