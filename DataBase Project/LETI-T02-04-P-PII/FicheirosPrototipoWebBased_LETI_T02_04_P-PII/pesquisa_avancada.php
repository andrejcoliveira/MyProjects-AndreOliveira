<?php
	include_once("conexao.php");
?>
<html>
	<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
	<head>
		<title>BD Biblioteca - Pesquisa Básica</title>
	</head>
	<?php
		$sql = "SELECT * FROM publicacao p, palavra_chave_descreve_publicacao pcd, area_tematica a";
		if(isset($_POST['pesquisar'])){
			$termo = mysqli_real_escape_string($conn, $_POST['pesquisa']);
			
			$sql .= " WHERE p.Nome = '{$termo}'";
			
			$sql .= " OR (p.Id = pcd.Publicacao_Id_ AND pcd.Palavra_Chave_ = '{$termo}')";
			
			$sql .= " OR (a.Nome_a = '{$termo}' AND p.Area_Tematica_Id = a.Id_a)";
			
			$sql .= " OR p.relevancia = '{$termo}'";
			if(!(ctype_space($_POST['data']))){
				$data = $_POST['data'];
				$sql .= " OR p.Data_de_publicacao = '{$data}'";
			}	
			
		}
		$sql .= " GROUP BY p.Nome ORDER BY p.Id";
		$result_set = mysqli_query($conn, $sql);
	?>
	<body background=#ffffff>
		<h3>Por favor, insira um Nome, Tag, Área Temática, Relevância e/ou Data de Publicação </h3>
		<form method="POST" action="pesquisa_avancada.php">
			Pesquisar: <input type="text" name="pesquisa" placeholder="Pesquisar..."><br><br>
			Data: <input type="date" name="data"><br><br>
			<input type="submit" name="pesquisar" value="Pesquisar">
		</form>
		<?php
			echo "<table cellpadding=5 cellspacing=5 >\n";
			$tuplos=0;
			$tuplos = mysqli_num_rows($result_set);
			if($tuplos == 0){
				echo "Não foi encontrado nenhum registo <br>";
			}else{
				echo "<tr><td ><b>Id</b></td><td><b>Nome</b></td><td><b>Area Tematica</b></td><td><b>Capa</b></td><td><b>Data de Publicação</b></td><td><b>Nº de Empréstimos</b></td><tr>";
			}
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
				printf("<td>$id</td><td>$nome</td><td>$area_tematica</td><td>$capa</td><td>$Data_de_publicacao</td><td>$emprestimos</ts><form action=\"apagar.php\" method=post><td><input type=hidden name=Id value=$id><input type=submit value=Apagar></td></form><form action=\"alterar.php\" method=post><td><input type=hidden name=Id value=$id><input type=submit value=Alterar></td></form><form action=\"ver_mais.php\" method=post><td><input type=hidden name=Id value=$id><input type=submit value=Mais></td></form>\n");			echo "</tr>\n"; 
				echo "</tr>\n"; 
			}
		?>
		<a href="menu.html">voltar ao menu</a>
	</body>
</html>