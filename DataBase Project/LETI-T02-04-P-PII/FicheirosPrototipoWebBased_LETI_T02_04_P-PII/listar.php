<?php
	include_once("conexao.php");
?>
<html>
	<meta http-equiv="Content-Type" content="text/html";charset="UTF-8">
	<head>
		<title>BD Biblioteca - Listar</title>
	</head>
	<body background=#ffffff>
		<p><h3>Listagem de publicacoes</h3></p>
		<?php
			echo "<table cellpadding=5 cellspacing=5>\n";
			echo "<tr><td ><b>Id</b></td><td><b>Nome</b></td><td><b>Area Tematica </b></td><td><b>Capa</b></td><td><b>Data de Publicação</b><td><b>Nº de Empréstimos</b></td><tr>";
			$result_set = mysqli_query($conn, "SELECT * FROM publicacao");
			$tuplos=0;
			$tuplos = mysqli_num_rows($result_set);  
			for($registo=0; $registo<$tuplos; $registo++) {
				echo "<tr>\n";
				$row = mysqli_fetch_assoc($result_set);
				$id = $row["Id"];
				$nome = $row["Nome"];
				$Area_Tematica_Id = $row["Area_Tematica_Id"];
				$aux = mysqli_query($conn, "SELECT a.Nome_a FROM area_tematica a WHERE a.Id_a = $Area_Tematica_Id");
				$aux2 = mysqli_fetch_assoc($aux);
				$area_tematica = $aux2['Nome_a'];
				$relevancia = $row["relevancia"];
				$Data_de_publicacao = $row["Data_de_publicacao"];
				$capa = $row['Capa'];
				$emprestimos = $row['Qtd_Emprestimos'];
				printf("<td>$id</td><td>$nome</td><td>$area_tematica</td><td>$capa</td><td>$Data_de_publicacao</td><td>$emprestimos</ts><form action=\"apagar.php\" method=post><td><input type=hidden name=Id value=$id><input type=submit value=Apagar></td></form><form action=\"alterar.php\" method=post><td><input type=hidden name=Id value=$id><input type=submit value=Alterar></td></form><form action=\"ver_mais.php\" method=post><td><input type=hidden name=Id value=$id><input type=submit value=Mais></td></form>\n");
				echo "</tr>\n"; 
			}
		?>
		<br>
		<a href="menu.html">voltar ao menu</a>
	</body>
</html>