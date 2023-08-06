<?php
	include_once("conexao.php");
?>
<html>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<head>
		<title>BD Biblioteca Universitária - Introduzir</title>
	</head>
	<body background=#ffffff>
		<h3><center>Introduzir Nova Publicação<center></h3>
		<?php
			$id = $_POST["Id"];
			$nome = $_POST["Nome"];
			$nome_abreviado = $_POST["Nome_abreviado"];
			$codigo = $_POST["Codigo"];
			$data_de_publicacao = $_POST["Data_de_Publicacao"];
			$ano_de_publicacao = $_POST["Ano_de_Publicacao"];
			$nr_pags = $_POST["Nr_Pags"];
			$capa = $_POST["Capa"];
			$capa_em_miniatura = $_POST["Capa_em_Miniatura"];
			$qtd_emprestimos = $_POST["Qtd_Emprestimos"];
			$qtd_acessos = $_POST["Qtd_Acessos"];
			$data_de_aquisicao = $_POST["Data_de_aquisicao"];
			$area_tematica_id = $_POST["Id_area"];
			$relevancia = $_POST["relevancia"];
			$sql = "INSERT INTO publicacao (Id, Nome, Nome_abreviado, Codigo, Data_de_publicacao, Ano_de_publicacao, Nr_Pags, Capa, Capa_em_miniatura, Qtd_emprestimos, Qtd_Acessos, Data_de_aquisicao, Area_Tematica_Id, relevancia) VALUES ($id, '$nome', '$nome_abreviado', $codigo, '$data_de_publicacao', $ano_de_publicacao, $nr_pags, '$capa', '$capa_em_miniatura', $qtd_emprestimos, $qtd_acessos, '$data_de_aquisicao', $area_tematica_id, $relevancia)";
			if(mysqli_query($conn, $sql)){
				echo "Publicação $nome introduzida com sucesso";
			}else{
				echo "Error introducing record: " . mysqli_error($conn);
			}
		?>
		<br>
		<a href="menu.html">voltar ao menu</a> | <a href="introduzir.html">voltar</a>
	</body>
</html>