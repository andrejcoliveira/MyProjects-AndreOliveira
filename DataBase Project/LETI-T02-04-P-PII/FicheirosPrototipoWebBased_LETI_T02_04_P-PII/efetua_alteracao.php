<?php
	include_once("conexao.php");
?>
<html>
	<head>
		<meta charset="UTF-8">
		<title>BD Biblioteca - Publicação Alterada</title>
	</head>
	<body>
		<?php
			$id = $_POST['Id'];
			$nome = $_POST['nome'];
			$nome_abreviado = $_POST['nome_abreviado'];
			$data_publicacao = $_POST['data_publicacao'];
			$area_tematica = $_POST['select_area'];
			$sql = "UPDATE publicacao SET Nome= '$nome' , Nome_abreviado = '$nome_abreviado', Data_de_publicacao = '$data_publicacao', Area_Tematica_Id = $area_tematica WHERE Id = $id";
			if(mysqli_query($conn, $sql)){
				echo "<b>Publicação alterada com sucesso</b>";
			}else{
				echo "Error updating record: " . mysqli_error($conn);
			}
		?>
	<br><br>
	<a href="menu.html">voltar ao menu</a> | <a href="javascript:history.back()">voltar</a>
	</body>
</html>