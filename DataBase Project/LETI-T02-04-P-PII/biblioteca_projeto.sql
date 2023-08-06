-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 14-Dez-2021 às 23:09
-- Versão do servidor: 10.4.21-MariaDB
-- versão do PHP: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `biblioteca_projeto`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `areasListaLeitura` (IN `listaUtenteID` INT(11) ZEROFILL)  BEGIN
	SELECT a.Nome, COUNT(p.Id)
    FROM lista_de_leitura ll,  edicao_de_livro el, livro_em_lista_leitura le, publicacao p, area_tematica a,  livro l
    WHERE ll.Utente_Numero = listaUtenteID AND p.Area_Tematica_Id = a.Id AND le.Edicao_de_Livro_Livro_Id_ = l.Id AND el.Livro_Id = l.Id AND el.Publicacao_Id = p.Id
    AND le.Lista_de_leitura_Utente_Numero_ = listaUtenteID
    GROUP BY a.Nome;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `atualizaMultas` ()  BEGIN
	DECLARE valor double(10,2);
    DECLARE num_dias int ;
    DECLARE dataEmp date;
   	SET valor = 10;
    
    SELECT e.Data_de_devolucao_limite INTO dataEmp FROM emprestimo_com_multa em, emprestimo e WHERE em.Numero = e.Numero;
    
    SET num_dias = datediff(curdate(), dataEmp);
    
    IF(num_dias > 0) THEN 
    	UPDATE emprestimo_com_multa em
    	SET em.Valor_actual_por_atraso = num_dias*valor;
    END IF;
    
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listaExemplares` (IN `publicacaoID` INT(11) UNSIGNED)  BEGIN
	SELECT p.Nome, e.Nr
    FROM publicacao p, exemplar e
    WHERE p.Id = publicacaoID AND p.Id = e.Publicacao_Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `suspendeUtente` (IN `utenteID` INT(11) ZEROFILL)  BEGIN
	IF (SELECT COUNT(*) FROM emprestimo e WHERE curdate() - INTERVAL 1 MONTH > e.Data_de_devolucao_limite AND e.Utente_Numero = utenteID) > 0 THEN 
    	    	INSERT INTO utente_suspenso(Numero, Data_inicio, Data_Fim) VALUES (utenteID, curdate(), curdate() + INTERVAL 1 MONTH);
   END IF;
END$$

--
-- Funções
--
CREATE DEFINER=`root`@`localhost` FUNCTION `validaEmprestimo` (`exemplarID` INT(11) ZEROFILL) RETURNS TINYINT(1) BEGIN
    DECLARE publicacaoID int;
    SELECT e.Publicacao_Id INTO publicacaoID FROM exemplar e WHERE e.Nr = exemplarID; 
	IF (SELECT e.Pode_ser_emprestado FROM exemplar e WHERE e.Nr = exemplarID) = 1 AND (SELECT COUNT(*) FROM reserva r 
                                             WHERE r.Publicacao_Id_ = publicacaoID 
                                             AND r.Data_e_Hora >= (curdate() - INTERVAL 1 MONTH)) = 0 THEN
	return(true);
	ELSE
	return(false);
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `andar`
--

CREATE TABLE `andar` (
  `Numero` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `area_tematica`
--

CREATE TABLE `area_tematica` (
  `Id` int(11) NOT NULL,
  `Nome_a` varchar(50) NOT NULL,
  `Area_Tematica_superior_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `area_tematica`
--

INSERT INTO `area_tematica` (`Id`, `Nome_a`, `Area_Tematica_superior_Id`) VALUES
(6, 'Ciências', NULL),
(5, 'Economia', 2),
(9, 'Excel', 1),
(10, 'Fisica', 6),
(2, 'Gestão', NULL),
(4, 'História', NULL),
(1, 'Informática', NULL),
(8, 'Matemática', 6),
(7, 'POO', 1),
(3, 'Sistemas Operativos', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `armario`
--

CREATE TABLE `armario` (
  `Andar_Numero` tinyint(4) NOT NULL,
  `Espaco_de_arrumacao_Id` int(11) NOT NULL,
  `Letra` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `autor`
--

CREATE TABLE `autor` (
  `id` int(11) NOT NULL,
  `Nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `autoria_de_livro`
--

CREATE TABLE `autoria_de_livro` (
  `Autor_id_` int(11) NOT NULL,
  `Livro_Id_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `autoria_de_monografia`
--

CREATE TABLE `autoria_de_monografia` (
  `Autor_id_` int(11) NOT NULL,
  `Monografia_Id_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `auxiliar`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `auxiliar` (
`Nome` varchar(255)
,`Data_de_publicacao` date
,`Tipo_de_publicacao` varchar(10)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `capitulo_ou_artigo`
--

CREATE TABLE `capitulo_ou_artigo` (
  `Publicacao_Id` int(11) NOT NULL,
  `Numero` tinyint(4) NOT NULL,
  `Nome` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `edicao_de_livro`
--

CREATE TABLE `edicao_de_livro` (
  `Livro_Id` int(11) NOT NULL,
  `Publicacao_Id` int(11) NOT NULL,
  `Numero` tinyint(4) NOT NULL,
  `ISBN` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `edicao_de_livro`
--

INSERT INTO `edicao_de_livro` (`Livro_Id`, `Publicacao_Id`, `Numero`, `ISBN`) VALUES
(2, 2, 2, 12345678),
(3, 3, 3, 33333),
(4, 4, 4, 44444),
(5, 5, 5, 55555),
(7, 7, 7, 77777),
(8, 8, 8, 88888),
(9, 9, 9, 99999),
(10, 10, 10, 101010),
(11, 11, 11, 111111),
(12, 12, 12, 121212),
(13, 13, 13, 131313),
(14, 14, 14, 141414);

--
-- Acionadores `edicao_de_livro`
--
DELIMITER $$
CREATE TRIGGER `validaLivros` BEFORE INSERT ON `edicao_de_livro` FOR EACH ROW BEGIN
    IF (new.Publicacao_ID IN (SELECT ep.Publicacao_Id FROM edicao_de_periodico ep)) OR (new.Publicacao_ID IN (SELECT ep.Publicacao_Id FROM monografia m)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Já existe uma publicacao com esse ID';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `edicao_de_periodico`
--

CREATE TABLE `edicao_de_periodico` (
  `Periodico_Editora_ou_Periodico_Id` int(11) NOT NULL,
  `Publicacao_Id` int(11) NOT NULL,
  `Numero` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `edicao_de_periodico`
--

INSERT INTO `edicao_de_periodico` (`Periodico_Editora_ou_Periodico_Id`, `Publicacao_Id`, `Numero`) VALUES
(1, 3, 1),
(2, 4, 2);

--
-- Acionadores `edicao_de_periodico`
--
DELIMITER $$
CREATE TRIGGER `novaEdicao` AFTER INSERT ON `edicao_de_periodico` FOR EACH ROW BEGIN
	UPDATE exemplar e
    SET e.Pode_ser_emprestado = 1
    WHERE e.Pode_ser_emprestado = 0 AND e.Nr < new.Numero AND e.Publicacao_Id = new.Publicacao_Id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validaPeriodico` BEFORE INSERT ON `edicao_de_periodico` FOR EACH ROW BEGIN
    IF (new.Publicacao_ID IN (SELECT el.Publicacao_Id FROM edicao_de_livro el)) OR (new.Publicacao_ID IN (SELECT ep.Publicacao_Id FROM monografia m)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Já existe uma publicacao com esse ID';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `editora`
--

CREATE TABLE `editora` (
  `Editora_ou_Periodico_Id` int(11) NOT NULL,
  `Nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `editora`
--

INSERT INTO `editora` (`Editora_ou_Periodico_Id`, `Nome`) VALUES
(1, 'Editora1'),
(2, 'Editora2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `editora_ou_periodico`
--

CREATE TABLE `editora_ou_periodico` (
  `Id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `editora_ou_periodico`
--

INSERT INTO `editora_ou_periodico` (`Id`) VALUES
(1),
(2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `emprestimo`
--

CREATE TABLE `emprestimo` (
  `Numero` int(11) NOT NULL,
  `Data_hora` datetime NOT NULL,
  `Publicacao_Id` int(11) NOT NULL,
  `Exemplar_Nr` tinyint(4) NOT NULL,
  `Utente_Numero` int(11) NOT NULL,
  `Data_de_devolucao_limite` date NOT NULL,
  `Qtd_de_prolongamentos` tinyint(4) DEFAULT NULL,
  `Data_de_devolucao` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `emprestimo`
--

INSERT INTO `emprestimo` (`Numero`, `Data_hora`, `Publicacao_Id`, `Exemplar_Nr`, `Utente_Numero`, `Data_de_devolucao_limite`, `Qtd_de_prolongamentos`, `Data_de_devolucao`) VALUES
(1, '2021-04-14 17:18:49', 2, 1, 1, '2021-12-01', 0, '2021-12-15 17:18:49'),
(2, '2021-12-07 17:18:49', 3, 3, 2, '2021-12-09', 0, '2021-12-08 17:18:49'),
(3, '2021-12-07 18:52:58', 5, 5, 2, '2021-12-24', NULL, '2021-12-07 18:52:58'),
(5, '2021-04-05 17:53:49', 5, 5, 2, '2021-12-15', NULL, '2021-12-07 18:53:48'),
(7, '2021-04-05 17:53:49', 7, 7, 2, '2021-12-28', 0, '2021-12-07 18:53:48'),
(9, '2021-04-21 17:54:59', 9, 9, 2, '2021-12-25', NULL, NULL),
(10, '2021-12-07 18:54:59', 2, 10, 2, '2021-12-30', NULL, '2021-12-07 18:54:59'),
(11, '2021-12-07 18:52:58', 4, 4, 1, '2021-12-16', 0, '2021-12-07 18:52:58'),
(12, '2021-12-12 11:45:53', 2, 10, 1, '2021-12-23', NULL, '2021-12-12 11:45:53');

--
-- Acionadores `emprestimo`
--
DELIMITER $$
CREATE TRIGGER `adicionaEmprestimo` AFTER INSERT ON `emprestimo` FOR EACH ROW BEGIN	
    UPDATE publicacao p
    SET p.Qtd_Emprestimos = p.Qtd_Emprestimos + 1
    WHERE p.Id = new.Publicacao_Id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `emprestimos_semestre`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `emprestimos_semestre` (
`Nome` varchar(255)
,`Numero_de_emprestimos` bigint(21)
,`Nome_a` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `emprestimo_com_multa`
--

CREATE TABLE `emprestimo_com_multa` (
  `Numero` int(11) NOT NULL,
  `Valor_actual_por_atraso` decimal(5,2) DEFAULT NULL,
  `Valor_por_extravio` decimal(5,2) DEFAULT NULL,
  `Valor_total` decimal(5,2) DEFAULT NULL,
  `Multa_paga` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `emprestimo_com_multa`
--

INSERT INTO `emprestimo_com_multa` (`Numero`, `Valor_actual_por_atraso`, `Valor_por_extravio`, `Valor_total`, `Multa_paga`) VALUES
(1, '90.00', '55.00', NULL, 0);

--
-- Acionadores `emprestimo_com_multa`
--
DELIMITER $$
CREATE TRIGGER `suspendeUtente` AFTER UPDATE ON `emprestimo_com_multa` FOR EACH ROW BEGIN
	DECLARE num_utente int;
    SELECT e.Utente_Numero INTO num_utente FROM emprestimo e WHERE e.Numero = new.Numero; 
	IF(new.Valor_por_extravio > 0 OR new.Valor_por_extravio <> NULL) THEN
    	INSERT INTO utente_suspenso(Numero, Data_inicio, Data_Fim) VALUES (num_utente, curdate(), curdate() + INTERVAL 1 MONTH);
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `espaco_de_arrumacao`
--

CREATE TABLE `espaco_de_arrumacao` (
  `Id` int(11) NOT NULL,
  `Nivel_de_ocupacao` tinyint(4) DEFAULT NULL,
  `Area_Tematica_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `estado_de_conservacao`
--

CREATE TABLE `estado_de_conservacao` (
  `Nome` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `exemplar`
--

CREATE TABLE `exemplar` (
  `Publicacao_Id` int(11) NOT NULL,
  `Nr` tinyint(4) NOT NULL,
  `Codigo_de_barras` int(11) DEFAULT NULL,
  `Data_de_aquisicao` date DEFAULT NULL,
  `RFID` int(11) DEFAULT NULL,
  `Pode_ser_emprestado` tinyint(1) DEFAULT NULL,
  `Estado_de_conservacao_Nome` varchar(20) DEFAULT NULL,
  `Localizacao_Andar_Numero` tinyint(4) DEFAULT NULL,
  `Localizacao_Armario_Letra` char(1) DEFAULT NULL,
  `Localizacao_Prateleira_Numero` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `exemplar`
--

INSERT INTO `exemplar` (`Publicacao_Id`, `Nr`, `Codigo_de_barras`, `Data_de_aquisicao`, `RFID`, `Pode_ser_emprestado`, `Estado_de_conservacao_Nome`, `Localizacao_Andar_Numero`, `Localizacao_Armario_Letra`, `Localizacao_Prateleira_Numero`) VALUES
(2, 1, 1, '2021-12-02', NULL, 0, NULL, NULL, NULL, NULL),
(2, 10, 1010101010, '2021-12-01', 1010101010, 1, NULL, NULL, NULL, NULL),
(3, 3, 3, '2021-12-02', NULL, 1, NULL, NULL, NULL, NULL),
(4, 4, 44444444, '2021-12-01', 44444444, 1, NULL, NULL, NULL, NULL),
(5, 5, 5555555, '2021-12-01', 5555555, NULL, NULL, NULL, NULL, NULL),
(7, 7, 7777777, '2021-12-01', 7777777, NULL, NULL, NULL, NULL, NULL),
(8, 8, 8888888, '2021-12-01', 8888888, NULL, NULL, NULL, NULL, NULL),
(9, 9, 999999, '2021-12-01', 999999, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `feed`
--

CREATE TABLE `feed` (
  `Endereco` varchar(255) NOT NULL,
  `Editora_ou_Periodico_Id` int(11) NOT NULL,
  `Periodicidade_Nome` varchar(50) DEFAULT NULL,
  `Area_Tematica_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `lista_de_leitura`
--

CREATE TABLE `lista_de_leitura` (
  `Utente_Numero` int(11) NOT NULL,
  `Nome` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `lista_de_leitura`
--

INSERT INTO `lista_de_leitura` (`Utente_Numero`, `Nome`) VALUES
(1, 'Lista do Utente 1'),
(2, 'Lista do Utente 2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `livro`
--

CREATE TABLE `livro` (
  `Id` int(11) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `Editora_Nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `livro`
--

INSERT INTO `livro` (`Id`, `Nome`, `Editora_Nome`) VALUES
(1, 'Livro1', 'Editora1'),
(2, 'Livro2', 'Editora1'),
(3, 'Livro3', 'Editora1'),
(4, 'Livro4', 'Editora1'),
(5, 'Livro5', 'Editora1'),
(6, 'Livro6', 'Editora1'),
(7, 'Livro7', 'Editora1'),
(8, 'Livro8', 'Editora1'),
(9, 'Livro9', 'Editora1'),
(10, 'Livro10', 'Editora1'),
(11, 'Livro11', 'Editora1'),
(12, 'Livro12', 'Editora2'),
(13, 'Livro13', 'Editora1'),
(14, 'Livro14', 'Editora2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `livro_em_lista_leitura`
--

CREATE TABLE `livro_em_lista_leitura` (
  `Edicao_de_Livro_Livro_Id_` int(11) NOT NULL,
  `Edicao_de_Livro_Numero_` tinyint(4) NOT NULL,
  `Lista_de_leitura_Utente_Numero_` int(11) NOT NULL,
  `Lista_de_leitura_Nome_` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `livro_em_lista_leitura`
--

INSERT INTO `livro_em_lista_leitura` (`Edicao_de_Livro_Livro_Id_`, `Edicao_de_Livro_Numero_`, `Lista_de_leitura_Utente_Numero_`, `Lista_de_leitura_Nome_`) VALUES
(2, 2, 1, 'Lista do Utente 1'),
(2, 2, 2, 'Lista do Utente 2'),
(3, 3, 1, 'Lista do Utente 1'),
(4, 4, 1, 'Lista do Utente 1'),
(5, 5, 1, 'Lista do Utente 1'),
(7, 7, 1, 'Lista do Utente 1'),
(8, 8, 1, 'Lista do Utente 1'),
(9, 9, 1, 'Lista do Utente 1'),
(10, 10, 1, 'Lista do Utente 1'),
(11, 11, 1, 'Lista do Utente 1'),
(12, 12, 1, 'Lista do Utente 1'),
(13, 13, 1, 'Lista do Utente 1'),
(14, 14, 1, 'Lista do Utente 1');

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `maisrelevantes`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `maisrelevantes` (
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `monografia`
--

CREATE TABLE `monografia` (
  `Publicacao_Id` int(11) NOT NULL,
  `Tipo_de_monografia_Nome` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `monografia`
--

INSERT INTO `monografia` (`Publicacao_Id`, `Tipo_de_monografia_Nome`) VALUES
(7, 'Relatório'),
(5, 'Texto pedagógico');

--
-- Acionadores `monografia`
--
DELIMITER $$
CREATE TRIGGER `validaMonografia` BEFORE INSERT ON `monografia` FOR EACH ROW BEGIN
    IF (new.Publicacao_ID IN (SELECT el.Publicacao_Id FROM edicao_de_livro el)) OR (new.Publicacao_ID IN (SELECT ep.Publicacao_Id FROM edicao_de_periodico ep)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Já existe uma publicacao com esse ID';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `num_areas_por_lista_leitura`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `num_areas_por_lista_leitura` (
`Nome` varchar(255)
,`lista_de_leitura` varchar(255)
,`num_areas` bigint(21)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `palavra_chave_descreve_publicacao`
--

CREATE TABLE `palavra_chave_descreve_publicacao` (
  `Palavra_chave_` varchar(50) NOT NULL,
  `Publicacao_Id_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `palavra_chave_descreve_publicacao`
--

INSERT INTO `palavra_chave_descreve_publicacao` (`Palavra_chave_`, `Publicacao_Id_`) VALUES
('Dois', 2),
('Quatro', 4),
('Três', 3),
('Um', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `palavra_chave_tag`
--

CREATE TABLE `palavra_chave_tag` (
  `Palavra` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `palavra_chave_tag`
--

INSERT INTO `palavra_chave_tag` (`Palavra`) VALUES
('Dois'),
('Quatro'),
('Três'),
('Um');

-- --------------------------------------------------------

--
-- Estrutura da tabela `periodicidade`
--

CREATE TABLE `periodicidade` (
  `Nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `periodicidade`
--

INSERT INTO `periodicidade` (`Nome`) VALUES
('Anual'),
('Diária'),
('Mensal'),
('Semanal'),
('Semestral'),
('Trimestral');

-- --------------------------------------------------------

--
-- Estrutura da tabela `periodico`
--

CREATE TABLE `periodico` (
  `Editora_Nome` varchar(50) NOT NULL,
  `Editora_ou_Periodico_Id` int(11) NOT NULL,
  `Periodicidade_Nome` varchar(50) NOT NULL,
  `ISSN` int(11) DEFAULT NULL,
  `Sigla` char(8) DEFAULT NULL,
  `Nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `periodico`
--

INSERT INTO `periodico` (`Editora_Nome`, `Editora_ou_Periodico_Id`, `Periodicidade_Nome`, `ISSN`, `Sigla`, `Nome`) VALUES
('Editora1', 1, 'Anual', 123451, 'ABC', 'ABC'),
('Editora1', 2, 'Diária', 123452, 'DEF', 'DEF');

-- --------------------------------------------------------

--
-- Estrutura da tabela `prateleira`
--

CREATE TABLE `prateleira` (
  `Andar_Numero` tinyint(4) NOT NULL,
  `Armario_Letra` char(1) NOT NULL,
  `Espaco_de_arrumacao_Id` int(11) NOT NULL,
  `Numero` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `publicacao`
--

CREATE TABLE `publicacao` (
  `Id` int(11) NOT NULL,
  `Nome` varchar(255) NOT NULL,
  `Nome_abreviado` varchar(100) DEFAULT NULL,
  `Codigo` int(11) NOT NULL,
  `Data_de_publicacao` date DEFAULT NULL,
  `Ano_de_publicacao` smallint(6) DEFAULT NULL,
  `Nr_Pags` smallint(6) DEFAULT NULL,
  `Capa` varchar(255) DEFAULT NULL,
  `Capa_em_miniatura` varchar(255) DEFAULT NULL,
  `Qtd_Emprestimos` smallint(6) DEFAULT 0,
  `Qtd_Acessos` smallint(6) DEFAULT 0,
  `Data_de_aquisicao` date DEFAULT NULL,
  `Area_Tematica_Id` int(11) DEFAULT NULL,
  `relevancia` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `publicacao`
--

INSERT INTO `publicacao` (`Id`, `Nome`, `Nome_abreviado`, `Codigo`, `Data_de_publicacao`, `Ano_de_publicacao`, `Nr_Pags`, `Capa`, `Capa_em_miniatura`, `Qtd_Emprestimos`, `Qtd_Acessos`, `Data_de_aquisicao`, `Area_Tematica_Id`, `relevancia`) VALUES
(1, 'Introduction to Analisys', 'IA', 11111, '2021-12-13', 2021, 25, NULL, NULL, 50, 25, '2021-12-01', 6, 3),
(2, 'Publicação2', 'Publi2', 2, '2021-11-01', 2021, 54, NULL, NULL, 11, 56, '2021-11-04', 4, 1),
(3, 'Publicação3', 'Publi3', 3, '2021-06-07', 2021, 58, NULL, NULL, 5, 89, '2021-12-01', 3, 4),
(4, 'Publicação4', 'Publi4', 4, '2021-01-10', 2021, 55, NULL, NULL, 55, 120, '2020-09-21', 8, 1),
(5, 'Publicação5', 'Publi5', 5, '2014-12-17', 2014, 188, NULL, NULL, 2, 5, '2018-12-13', 3, 5),
(7, 'Publicação7', 'Publi7', 7, '2012-04-05', 2012, 555, NULL, NULL, 1, 13, '2015-12-02', 4, 3),
(8, 'Publicação8', 'Publi8', 8, '2015-12-10', 2015, 55, NULL, NULL, 75, 155, '2021-12-01', 2, 4),
(9, 'Publicação9', 'Publi9', 9, '2015-12-15', 2015, 55, NULL, NULL, 55, 65, '2021-12-02', 8, 3),
(10, 'Publicação10', 'Publi10', 10, '2015-12-30', 2015, 999, NULL, NULL, 33, 11, '2016-12-15', 1, 3),
(11, 'Publicação11', 'Publi11', 111111, '2021-11-01', 2021, 1000, NULL, NULL, 25, 125, '2021-12-01', 5, 5),
(12, 'Publicação12', 'Publi12', 121212, '2021-12-01', 2021, 145, NULL, NULL, 100, 2, '2021-12-09', 7, 2),
(13, 'Publicação13', 'Publi13', 131313, '2021-12-01', 2021, 125, NULL, NULL, 100, 56, '2021-12-01', 9, 3),
(14, 'Publicação14', 'Publi14', 141414, '2021-12-01', 2021, 500, NULL, NULL, 63, 58, '2021-12-01', 10, 5),
(15, 'Publicação15', 'Publi15', 151515, '2021-05-01', 2021, 55, 'z', 'z', 5, 10, '2021-09-02', 2, 3),
(16, 'Publicação16', 'Publi16', 161616, '2021-12-07', 2021, 55, 'z', 'z', 55, 22, '2021-12-07', 4, 5),
(17, 'Publicação17', 'Publi17', 171717, '2021-12-01', 2021, 55, 'z', 'z', 55, 22, '2021-12-13', 4, 5),
(18, 'Introdução ao Matlab', 'IM', 181818, '2021-12-01', 2021, 500, 'Imagem', 'Imagem', 55, 22, '2021-12-13', 4, 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `publicacao_digital`
--

CREATE TABLE `publicacao_digital` (
  `Publicacao_Id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `publicacao_fisica`
--

CREATE TABLE `publicacao_fisica` (
  `Publicacao_Id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `publicacao_fisica`
--

INSERT INTO `publicacao_fisica` (`Publicacao_Id`) VALUES
(2),
(3),
(4),
(5),
(7),
(8),
(9),
(10);

-- --------------------------------------------------------

--
-- Estrutura da tabela `reserva`
--

CREATE TABLE `reserva` (
  `Publicacao_Id_` int(11) NOT NULL,
  `Utente_Numero_` int(11) NOT NULL,
  `Data_e_Hora` datetime DEFAULT NULL,
  `Exemplar_escolhido_Publicacao_Id` int(11) DEFAULT NULL,
  `Exemplar_Nr` tinyint(4) DEFAULT NULL
) ;

--
-- Extraindo dados da tabela `reserva`
--

INSERT INTO `reserva` (`Publicacao_Id_`, `Utente_Numero_`, `Data_e_Hora`, `Exemplar_escolhido_Publicacao_Id`, `Exemplar_Nr`) VALUES
(2, 1, '2020-11-01 11:05:19', 2, 1),
(3, 1, '2021-12-02 12:05:19', 3, 3),
(4, 1, '2021-12-08 20:48:24', 4, 4);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `reservas_6_meses`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `reservas_6_meses` (
`Publicacao_Id_` int(11)
,`Nome` varchar(255)
,`Numero_de_reservas` bigint(21)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `revista`
--

CREATE TABLE `revista` (
  `Periodico_Editora_ou_Periodico_Id` int(11) NOT NULL,
  `Qtd_edicoes_nao_emprestaveis` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_de_monografia`
--

CREATE TABLE `tipo_de_monografia` (
  `Nome` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `tipo_de_monografia`
--

INSERT INTO `tipo_de_monografia` (`Nome`) VALUES
('Dissertação de Doutoramento'),
('Dissertação de Mestrado'),
('Relatório'),
('Texto pedagógico');

-- --------------------------------------------------------

--
-- Estrutura da tabela `utente`
--

CREATE TABLE `utente` (
  `Numero` int(11) NOT NULL,
  `Nome` varchar(255) NOT NULL,
  `Telefone` int(11) NOT NULL,
  `Morada` varchar(255) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Tipo_Doc_Identificacao` char(4) NOT NULL,
  `Nr_Doc_Identificacao` int(11) NOT NULL
) ;

--
-- Extraindo dados da tabela `utente`
--

INSERT INTO `utente` (`Numero`, `Nome`, `Telefone`, `Morada`, `Email`, `Tipo_Doc_Identificacao`, `Nr_Doc_Identificacao`) VALUES
(1, 'Utente1', 1, '1', '1@gmail.com', 'CC', 1),
(2, 'Utente2', 2, '2', '2@gmail.com', 'CC', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `utente_suspenso`
--

CREATE TABLE `utente_suspenso` (
  `Numero` int(11) NOT NULL,
  `Data_inicio` date NOT NULL,
  `Data_fim` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Extraindo dados da tabela `utente_suspenso`
--

INSERT INTO `utente_suspenso` (`Numero`, `Data_inicio`, `Data_fim`) VALUES
(1, '2021-12-12', '2022-01-12');

-- --------------------------------------------------------

--
-- Estrutura para vista `auxiliar`
--
DROP TABLE IF EXISTS `auxiliar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `auxiliar`  AS SELECT `p`.`Nome` AS `Nome`, `p`.`Data_de_publicacao` AS `Data_de_publicacao`, 'Livro' AS `Tipo_de_publicacao` FROM (`publicacao` `p` join `edicao_de_livro` `el`) WHERE `p`.`Id` = `el`.`Publicacao_Id` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `emprestimos_semestre`
--
DROP TABLE IF EXISTS `emprestimos_semestre`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `emprestimos_semestre`  AS SELECT `p`.`Nome` AS `Nome`, count(`e`.`Numero`) AS `Numero_de_emprestimos`, `a`.`Nome_a` AS `Nome_a` FROM ((`publicacao` `p` join `area_tematica` `a`) join `emprestimo` `e`) WHERE `p`.`Area_Tematica_Id` = `a`.`Id` AND `e`.`Publicacao_Id` = `p`.`Id` GROUP BY `a`.`Nome_a` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `maisrelevantes`
--
DROP TABLE IF EXISTS `maisrelevantes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `maisrelevantes`  AS SELECT max(`p`.`relevancia`) AS `Publicaçao_Mais_Relevante`, `at`.`Nome` AS `Area_Tematica` FROM (`publicacao` `p` join `area_tematica` `at`) WHERE `p`.`Area_Tematica_Id` = `at`.`Id` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `num_areas_por_lista_leitura`
--
DROP TABLE IF EXISTS `num_areas_por_lista_leitura`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `num_areas_por_lista_leitura`  AS SELECT `u`.`Nome` AS `Nome`, `ll`.`Nome` AS `lista_de_leitura`, count(distinct `a`.`Nome_a`) AS `num_areas` FROM ((((((`utente` `u` join `lista_de_leitura` `ll`) join `edicao_de_livro` `el`) join `livro_em_lista_leitura` `le`) join `publicacao` `p`) join `area_tematica` `a`) join `livro` `l`) WHERE `u`.`Numero` = `ll`.`Utente_Numero` AND `le`.`Lista_de_leitura_Utente_Numero_` = `u`.`Numero` AND `el`.`Publicacao_Id` = `p`.`Id` AND `a`.`Id` = `p`.`Area_Tematica_Id` AND `l`.`Id` = `le`.`Edicao_de_Livro_Livro_Id_` AND `l`.`Id` = `el`.`Livro_Id` GROUP BY `ll`.`Nome` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `reservas_6_meses`
--
DROP TABLE IF EXISTS `reservas_6_meses`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `reservas_6_meses`  AS SELECT `r`.`Publicacao_Id_` AS `Publicacao_Id_`, `p`.`Nome` AS `Nome`, count(`r`.`Publicacao_Id_`) AS `Numero_de_reservas` FROM (`reserva` `r` join `publicacao` `p`) WHERE `r`.`Publicacao_Id_` = `p`.`Id` AND `r`.`Data_e_Hora` >= curdate() - interval 6 month GROUP BY `r`.`Publicacao_Id_` ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `andar`
--
ALTER TABLE `andar`
  ADD PRIMARY KEY (`Numero`),
  ADD UNIQUE KEY `Numero` (`Numero`);

--
-- Índices para tabela `area_tematica`
--
ALTER TABLE `area_tematica`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Id` (`Id`),
  ADD UNIQUE KEY `AK_Nome_em_Area_superior` (`Nome_a`,`Area_Tematica_superior_Id`),
  ADD KEY `FK_Area_Tematica_noname_Area_Tematica` (`Area_Tematica_superior_Id`);

--
-- Índices para tabela `armario`
--
ALTER TABLE `armario`
  ADD PRIMARY KEY (`Andar_Numero`,`Letra`),
  ADD UNIQUE KEY `AK_Armario_Espaco_de_arrumacao` (`Espaco_de_arrumacao_Id`);

--
-- Índices para tabela `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `Nome` (`Nome`);

--
-- Índices para tabela `autoria_de_livro`
--
ALTER TABLE `autoria_de_livro`
  ADD PRIMARY KEY (`Autor_id_`,`Livro_Id_`),
  ADD KEY `FK_Livro_Autoria_de_Livro_Autor_` (`Livro_Id_`);

--
-- Índices para tabela `autoria_de_monografia`
--
ALTER TABLE `autoria_de_monografia`
  ADD PRIMARY KEY (`Autor_id_`,`Monografia_Id_`),
  ADD KEY `FK_Monografia_Autoria_de_Monografia_Autor_` (`Monografia_Id_`);

--
-- Índices para tabela `capitulo_ou_artigo`
--
ALTER TABLE `capitulo_ou_artigo`
  ADD PRIMARY KEY (`Publicacao_Id`,`Numero`),
  ADD UNIQUE KEY `Capitulo_ou_Artigo___Unique_Numero_em_Publicacao` (`Publicacao_Id`,`Numero`),
  ADD UNIQUE KEY `Capitulo_ou_Artigo___Unique_Nome_em_Publicacao` (`Publicacao_Id`,`Nome`);

--
-- Índices para tabela `edicao_de_livro`
--
ALTER TABLE `edicao_de_livro`
  ADD PRIMARY KEY (`Livro_Id`,`Numero`),
  ADD UNIQUE KEY `ISBN` (`ISBN`),
  ADD KEY `FK_Edicao_de_Livro_Publicacao` (`Publicacao_Id`);

--
-- Índices para tabela `edicao_de_periodico`
--
ALTER TABLE `edicao_de_periodico`
  ADD PRIMARY KEY (`Periodico_Editora_ou_Periodico_Id`,`Numero`),
  ADD KEY `FK_Edicao_de_Periodico_Publicacao` (`Publicacao_Id`);

--
-- Índices para tabela `editora`
--
ALTER TABLE `editora`
  ADD PRIMARY KEY (`Nome`),
  ADD UNIQUE KEY `Editora_ou_Periodico_Id` (`Editora_ou_Periodico_Id`),
  ADD UNIQUE KEY `Nome` (`Nome`);

--
-- Índices para tabela `editora_ou_periodico`
--
ALTER TABLE `editora_ou_periodico`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Id` (`Id`);

--
-- Índices para tabela `emprestimo`
--
ALTER TABLE `emprestimo`
  ADD PRIMARY KEY (`Numero`),
  ADD UNIQUE KEY `Numero` (`Numero`),
  ADD KEY `FK_Emprestimo_noname_Exemplar` (`Publicacao_Id`,`Exemplar_Nr`),
  ADD KEY `FK_Emprestimo_noname_Utente` (`Utente_Numero`);

--
-- Índices para tabela `emprestimo_com_multa`
--
ALTER TABLE `emprestimo_com_multa`
  ADD PRIMARY KEY (`Numero`);

--
-- Índices para tabela `espaco_de_arrumacao`
--
ALTER TABLE `espaco_de_arrumacao`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `FK_Espaco_de_arrumacao_noname_Area_Tematica` (`Area_Tematica_Id`);

--
-- Índices para tabela `estado_de_conservacao`
--
ALTER TABLE `estado_de_conservacao`
  ADD PRIMARY KEY (`Nome`),
  ADD UNIQUE KEY `Nome` (`Nome`);

--
-- Índices para tabela `exemplar`
--
ALTER TABLE `exemplar`
  ADD PRIMARY KEY (`Publicacao_Id`,`Nr`),
  ADD UNIQUE KEY `Codigo_de_barras` (`Codigo_de_barras`),
  ADD UNIQUE KEY `RFID` (`RFID`),
  ADD KEY `FK_Exemplar_noname_Estado_de_conservacao` (`Estado_de_conservacao_Nome`),
  ADD KEY `FK_Exemplar_noname_Prateleira` (`Localizacao_Andar_Numero`,`Localizacao_Armario_Letra`,`Localizacao_Prateleira_Numero`);

--
-- Índices para tabela `feed`
--
ALTER TABLE `feed`
  ADD PRIMARY KEY (`Endereco`),
  ADD UNIQUE KEY `Endereco` (`Endereco`),
  ADD KEY `FK_Feed_noname_Area_Tematica` (`Area_Tematica_Id`),
  ADD KEY `FK_Feed_noname_Editora_ou_Periodico` (`Editora_ou_Periodico_Id`),
  ADD KEY `FK_Feed_noname_Periodicidade` (`Periodicidade_Nome`);

--
-- Índices para tabela `lista_de_leitura`
--
ALTER TABLE `lista_de_leitura`
  ADD PRIMARY KEY (`Utente_Numero`,`Nome`);

--
-- Índices para tabela `livro`
--
ALTER TABLE `livro`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `FK_Livro_noname_Editora` (`Editora_Nome`);

--
-- Índices para tabela `livro_em_lista_leitura`
--
ALTER TABLE `livro_em_lista_leitura`
  ADD PRIMARY KEY (`Edicao_de_Livro_Livro_Id_`,`Edicao_de_Livro_Numero_`,`Lista_de_leitura_Utente_Numero_`,`Lista_de_leitura_Nome_`),
  ADD KEY `FK_Lista_de_leitura_Livro_em_Lista_leitura_Edicao_de_Livro_` (`Lista_de_leitura_Utente_Numero_`,`Lista_de_leitura_Nome_`);

--
-- Índices para tabela `monografia`
--
ALTER TABLE `monografia`
  ADD PRIMARY KEY (`Publicacao_Id`),
  ADD KEY `FK_Monografia_noname_Tipo_de_monografia` (`Tipo_de_monografia_Nome`);

--
-- Índices para tabela `palavra_chave_descreve_publicacao`
--
ALTER TABLE `palavra_chave_descreve_publicacao`
  ADD PRIMARY KEY (`Palavra_chave_`,`Publicacao_Id_`),
  ADD KEY `FK_Publicacao_Palavra_chave_descreve_Publicacao_` (`Publicacao_Id_`);

--
-- Índices para tabela `palavra_chave_tag`
--
ALTER TABLE `palavra_chave_tag`
  ADD PRIMARY KEY (`Palavra`);

--
-- Índices para tabela `periodicidade`
--
ALTER TABLE `periodicidade`
  ADD PRIMARY KEY (`Nome`),
  ADD UNIQUE KEY `Nome` (`Nome`);

--
-- Índices para tabela `periodico`
--
ALTER TABLE `periodico`
  ADD PRIMARY KEY (`Editora_ou_Periodico_Id`),
  ADD UNIQUE KEY `Nome` (`Nome`),
  ADD KEY `FK_Periodico_noname_Editora` (`Editora_Nome`),
  ADD KEY `FK_Periodico_noname_Periodicidade` (`Periodicidade_Nome`);

--
-- Índices para tabela `prateleira`
--
ALTER TABLE `prateleira`
  ADD PRIMARY KEY (`Andar_Numero`,`Armario_Letra`,`Numero`),
  ADD UNIQUE KEY `AK_Prateleira_Espaco_de_arrumacao` (`Espaco_de_arrumacao_Id`);

--
-- Índices para tabela `publicacao`
--
ALTER TABLE `publicacao`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Nome` (`Nome`),
  ADD UNIQUE KEY `Codigo` (`Codigo`),
  ADD KEY `FK_Publicacao_Publicacao_em_Area_Area_Tematica` (`Area_Tematica_Id`);

--
-- Índices para tabela `publicacao_digital`
--
ALTER TABLE `publicacao_digital`
  ADD PRIMARY KEY (`Publicacao_Id`),
  ADD UNIQUE KEY `Publicacao_Id` (`Publicacao_Id`);

--
-- Índices para tabela `publicacao_fisica`
--
ALTER TABLE `publicacao_fisica`
  ADD PRIMARY KEY (`Publicacao_Id`),
  ADD UNIQUE KEY `Publicacao_Id` (`Publicacao_Id`);

--
-- Índices para tabela `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`Publicacao_Id_`,`Utente_Numero_`),
  ADD KEY `FK_Reserva_noname_Exemplar` (`Exemplar_escolhido_Publicacao_Id`,`Exemplar_Nr`),
  ADD KEY `FK_Utente_Reserva_Publicacao_fisica_` (`Utente_Numero_`);

--
-- Índices para tabela `revista`
--
ALTER TABLE `revista`
  ADD PRIMARY KEY (`Periodico_Editora_ou_Periodico_Id`);

--
-- Índices para tabela `tipo_de_monografia`
--
ALTER TABLE `tipo_de_monografia`
  ADD PRIMARY KEY (`Nome`),
  ADD UNIQUE KEY `Nome` (`Nome`);

--
-- Índices para tabela `utente`
--
ALTER TABLE `utente`
  ADD PRIMARY KEY (`Numero`),
  ADD UNIQUE KEY `Numero` (`Numero`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD UNIQUE KEY `AK_Nr_doc_id_and_Tipo_doc_id` (`Tipo_Doc_Identificacao`,`Nr_Doc_Identificacao`);

--
-- Índices para tabela `utente_suspenso`
--
ALTER TABLE `utente_suspenso`
  ADD PRIMARY KEY (`Numero`);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `area_tematica`
--
ALTER TABLE `area_tematica`
  ADD CONSTRAINT `FK_Area_Tematica_noname_Area_Tematica` FOREIGN KEY (`Area_Tematica_superior_Id`) REFERENCES `area_tematica` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `armario`
--
ALTER TABLE `armario`
  ADD CONSTRAINT `FK_Armario_Espaco_de_arrumacao` FOREIGN KEY (`Espaco_de_arrumacao_Id`) REFERENCES `espaco_de_arrumacao` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Armario_noname_Andar` FOREIGN KEY (`Andar_Numero`) REFERENCES `andar` (`Numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `autoria_de_livro`
--
ALTER TABLE `autoria_de_livro`
  ADD CONSTRAINT `FK_Autor_Autoria_de_Livro_Livro_` FOREIGN KEY (`Autor_id_`) REFERENCES `autor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Livro_Autoria_de_Livro_Autor_` FOREIGN KEY (`Livro_Id_`) REFERENCES `livro` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `autoria_de_monografia`
--
ALTER TABLE `autoria_de_monografia`
  ADD CONSTRAINT `FK_Autor_Autoria_de_Monografia_Monografia_` FOREIGN KEY (`Autor_id_`) REFERENCES `autor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Monografia_Autoria_de_Monografia_Autor_` FOREIGN KEY (`Monografia_Id_`) REFERENCES `monografia` (`Publicacao_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `capitulo_ou_artigo`
--
ALTER TABLE `capitulo_ou_artigo`
  ADD CONSTRAINT `FK_Capitulo_ou_Artigo_noname_Publicacao` FOREIGN KEY (`Publicacao_Id`) REFERENCES `publicacao` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `edicao_de_livro`
--
ALTER TABLE `edicao_de_livro`
  ADD CONSTRAINT `FK_Edicao_de_Livro_Publicacao` FOREIGN KEY (`Publicacao_Id`) REFERENCES `publicacao` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Edicao_de_Livro_noname_Livro` FOREIGN KEY (`Livro_Id`) REFERENCES `livro` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `edicao_de_periodico`
--
ALTER TABLE `edicao_de_periodico`
  ADD CONSTRAINT `FK_Edicao_de_Periodico_Publicacao` FOREIGN KEY (`Publicacao_Id`) REFERENCES `publicacao` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Edicao_de_Periodico_noname_Periodico` FOREIGN KEY (`Periodico_Editora_ou_Periodico_Id`) REFERENCES `periodico` (`Editora_ou_Periodico_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `editora`
--
ALTER TABLE `editora`
  ADD CONSTRAINT `FK_Editora_Editora_ou_Periodico` FOREIGN KEY (`Editora_ou_Periodico_Id`) REFERENCES `editora_ou_periodico` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `emprestimo`
--
ALTER TABLE `emprestimo`
  ADD CONSTRAINT `FK_Emprestimo_noname_Exemplar` FOREIGN KEY (`Publicacao_Id`,`Exemplar_Nr`) REFERENCES `exemplar` (`Publicacao_Id`, `Nr`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Emprestimo_noname_Utente` FOREIGN KEY (`Utente_Numero`) REFERENCES `utente` (`Numero`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `emprestimo_com_multa`
--
ALTER TABLE `emprestimo_com_multa`
  ADD CONSTRAINT `FK_Emprestimo_com_multa_Emprestimo` FOREIGN KEY (`Numero`) REFERENCES `emprestimo` (`Numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `espaco_de_arrumacao`
--
ALTER TABLE `espaco_de_arrumacao`
  ADD CONSTRAINT `FK_Espaco_de_arrumacao_noname_Area_Tematica` FOREIGN KEY (`Area_Tematica_Id`) REFERENCES `area_tematica` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `exemplar`
--
ALTER TABLE `exemplar`
  ADD CONSTRAINT `FK_Exemplar_noname_Estado_de_conservacao` FOREIGN KEY (`Estado_de_conservacao_Nome`) REFERENCES `estado_de_conservacao` (`Nome`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Exemplar_noname_Prateleira` FOREIGN KEY (`Localizacao_Andar_Numero`,`Localizacao_Armario_Letra`,`Localizacao_Prateleira_Numero`) REFERENCES `prateleira` (`Andar_Numero`, `Armario_Letra`, `Numero`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Exemplar_noname_Publicacao_fisica` FOREIGN KEY (`Publicacao_Id`) REFERENCES `publicacao_fisica` (`Publicacao_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `feed`
--
ALTER TABLE `feed`
  ADD CONSTRAINT `FK_Feed_noname_Area_Tematica` FOREIGN KEY (`Area_Tematica_Id`) REFERENCES `area_tematica` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Feed_noname_Editora_ou_Periodico` FOREIGN KEY (`Editora_ou_Periodico_Id`) REFERENCES `editora_ou_periodico` (`Id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Feed_noname_Periodicidade` FOREIGN KEY (`Periodicidade_Nome`) REFERENCES `periodicidade` (`Nome`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `lista_de_leitura`
--
ALTER TABLE `lista_de_leitura`
  ADD CONSTRAINT `FK_Lista_de_leitura_noname_Utente` FOREIGN KEY (`Utente_Numero`) REFERENCES `utente` (`Numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `livro`
--
ALTER TABLE `livro`
  ADD CONSTRAINT `FK_Livro_noname_Editora` FOREIGN KEY (`Editora_Nome`) REFERENCES `editora` (`Nome`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `livro_em_lista_leitura`
--
ALTER TABLE `livro_em_lista_leitura`
  ADD CONSTRAINT `FK_Edicao_de_Livro_Livro_em_Lista_leitura_Lista_de_leitura_` FOREIGN KEY (`Edicao_de_Livro_Livro_Id_`,`Edicao_de_Livro_Numero_`) REFERENCES `edicao_de_livro` (`Livro_Id`, `Numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Lista_de_leitura_Livro_em_Lista_leitura_Edicao_de_Livro_` FOREIGN KEY (`Lista_de_leitura_Utente_Numero_`,`Lista_de_leitura_Nome_`) REFERENCES `lista_de_leitura` (`Utente_Numero`, `Nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `monografia`
--
ALTER TABLE `monografia`
  ADD CONSTRAINT `FK_Monografia_Publicacao` FOREIGN KEY (`Publicacao_Id`) REFERENCES `publicacao` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Monografia_noname_Tipo_de_monografia` FOREIGN KEY (`Tipo_de_monografia_Nome`) REFERENCES `tipo_de_monografia` (`Nome`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `palavra_chave_descreve_publicacao`
--
ALTER TABLE `palavra_chave_descreve_publicacao`
  ADD CONSTRAINT `FK_Palavra_chave_tag_Palavra_chave_descreve_Publicacao_` FOREIGN KEY (`Palavra_chave_`) REFERENCES `palavra_chave_tag` (`Palavra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Publicacao_Palavra_chave_descreve_Publicacao_` FOREIGN KEY (`Publicacao_Id_`) REFERENCES `publicacao` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `periodico`
--
ALTER TABLE `periodico`
  ADD CONSTRAINT `FK_Periodico_Editora_ou_Periodico` FOREIGN KEY (`Editora_ou_Periodico_Id`) REFERENCES `editora_ou_periodico` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Periodico_noname_Editora` FOREIGN KEY (`Editora_Nome`) REFERENCES `editora` (`Nome`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Periodico_noname_Periodicidade` FOREIGN KEY (`Periodicidade_Nome`) REFERENCES `periodicidade` (`Nome`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `prateleira`
--
ALTER TABLE `prateleira`
  ADD CONSTRAINT `FK_Prateleira_Espaco_de_arrumacao` FOREIGN KEY (`Espaco_de_arrumacao_Id`) REFERENCES `espaco_de_arrumacao` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Prateleira_noname_Armario` FOREIGN KEY (`Andar_Numero`,`Armario_Letra`) REFERENCES `armario` (`Andar_Numero`, `Letra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `publicacao`
--
ALTER TABLE `publicacao`
  ADD CONSTRAINT `FK_Publicacao_Publicacao_em_Area_Area_Tematica` FOREIGN KEY (`Area_Tematica_Id`) REFERENCES `area_tematica` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `publicacao_digital`
--
ALTER TABLE `publicacao_digital`
  ADD CONSTRAINT `FK_Publicacao_digital_Publicacao` FOREIGN KEY (`Publicacao_Id`) REFERENCES `publicacao` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `publicacao_fisica`
--
ALTER TABLE `publicacao_fisica`
  ADD CONSTRAINT `FK_Publicacao_fisica_Publicacao` FOREIGN KEY (`Publicacao_Id`) REFERENCES `publicacao` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `FK_Publicacao_fisica_Reserva_Utente_` FOREIGN KEY (`Publicacao_Id_`) REFERENCES `publicacao_fisica` (`Publicacao_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Reserva_noname_Exemplar` FOREIGN KEY (`Exemplar_escolhido_Publicacao_Id`,`Exemplar_Nr`) REFERENCES `exemplar` (`Publicacao_Id`, `Nr`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Utente_Reserva_Publicacao_fisica_` FOREIGN KEY (`Utente_Numero_`) REFERENCES `utente` (`Numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `revista`
--
ALTER TABLE `revista`
  ADD CONSTRAINT `FK_Revista_Periodico` FOREIGN KEY (`Periodico_Editora_ou_Periodico_Id`) REFERENCES `periodico` (`Editora_ou_Periodico_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `utente_suspenso`
--
ALTER TABLE `utente_suspenso`
  ADD CONSTRAINT `FK_Utente_Suspenso_Utente` FOREIGN KEY (`Numero`) REFERENCES `utente` (`Numero`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
