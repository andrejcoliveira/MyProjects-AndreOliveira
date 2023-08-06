<?php
	include_once("conexao.php");
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>BD Biblioteca - Alterar</title>
	</head>
	<body>
		<p><h3>Alterar publicação</h3></p>
		<form method="POST" action="efetua_alteracao.php">
			Id: <?php echo $_POST["Id"]; ?> <input type=hidden name = "Id" value = <?php echo $_POST['Id']; ?>><br><br>
			Nome: <input type="text" name="nome" placeholder="Insira o nome completo..."><br><br>
			Nome abreviado: <input type="text" name="nome_abreviado" placeholder="Insira o Nome Abreviado"><br><br>
			Data de Publicacao: <input type="date" name="data_publicacao"><br><br>
			Área Temática: 
				<select name="select_area">
					<option>Selecione...</option>
					<?php
						$result = "SELECT * FROM area_tematica";
						$resultado = mysqli_query($conn, $result);
						while($row = mysqli_fetch_assoc($resultado)){ ?>
							<option value="<?php echo $row['Id_a']; ?>"><?php echo $row['Nome_a']; ?></option> <?php
						}
					?>
				</select><br><br>
			<input type="submit" value="Alterar">
		</form>
		<a href="menu.html">voltar ao menu</a> | <a href="javascript:history.back()">voltar</a>
</body>
</html>

