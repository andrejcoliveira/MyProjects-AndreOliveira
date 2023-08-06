<?php
	include_once("conexao.php");
	$id = $_POST['Id'];
?>
<html>
	<meta http-equiv="Content-Type" content="text/html";charset="UTF-8">
	<head>
		<title>BD Biblioteca - Ver Mais</title>
	</head>
	<body background=#ffffff>
		<h1><center>Detalhes de Publicação</center></h1>
		<?php
			$result_set = mysqli_query($conn, "SELECT * FROM publicacao WHERE Id = $id"); 
			$row = mysqli_fetch_assoc($result_set);
			$id = $row["Id"];
			$nome = $row["Nome"];
			$nome_abreviado = $row["Nome_abreviado"];
			$codigo = $row['Codigo'];
			$Data_de_publicacao = $row["Data_de_publicacao"];
			$ano = $row["Ano_de_publicacao"];
			$pags = $row["Nr_Pags"];
			$capa = $row["Capa"];
			$capa_em_mini = $row["Capa_em_miniatura"];
			$Qtd_Emprestimos = $row['Qtd_Emprestimos'];
			$qtd_acessos = $row['Qtd_Acessos'];
			$data_aquisicao = $row['Data_de_aquisicao'];
			$Area_Tematica_Id = $row["Area_Tematica_Id"];
			$aux = mysqli_query($conn, "SELECT a.Nome_a FROM area_tematica a WHERE a.Id = $Area_Tematica_Id");
			$aux2 = mysqli_fetch_assoc($aux);
			$area_tematica = $aux2['Nome_a'];
			$relevancia = $row["relevancia"];
			echo "<b>Id</b>: $id<br><br>";
			echo "<b>Nome</b>: $nome <br><br>";
			echo "<b>Nome Abreviado</b>: $nome_abreviado<br><br>";
			echo "<b>Código</b>: $codigo <br><br>";
			echo "<b>Data de publicação</b>: $Data_de_publicacao <br><br>";
			echo "<b>Ano de publicação</b>: $ano <br><br>";
			echo "<b>Nº de Páginas</b>: $pags <br><br>";
			echo "<b>Capa</b>: $capa <br><br>";
			echo "<b>Capa em Miniatura</b>: $capa_em_mini <br><br>";
			echo "<b>Quantidade de Empréstimos</b>: $Qtd_Emprestimos <br><br>";
			echo "<b>Quantidade de Acessos</b>: $qtd_acessos <br><br>";
			echo "<b>Data de Aquisição</b>: $data_aquisicao <br><br>";
			echo "<b>Area Temática</b>: $area_tematica <br><br>";
			echo "<b>Relevância</b>: $relevancia <br><br>";
		?>
		<br>
		<a href="menu.html">voltar ao menu</a> | <a href="javascript:history.back()">Voltar</a>
	</body>
</html>