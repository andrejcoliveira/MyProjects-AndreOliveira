-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 28-Out-2021 às 18:58
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
-- Banco de dados: `projeto.1`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `area`
--

CREATE TABLE `area` (
  `Nome` varchar(50) DEFAULT NULL,
  `ID_Area` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `armarios`
--

CREATE TABLE `armarios` (
  `Area_ID_Area` int(20) NOT NULL,
  `Letra` char(1) NOT NULL,
  `Piso` int(10) NOT NULL,
  `Nivel_de_ocupacao` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `artigo`
--

CREATE TABLE `artigo` (
  `Artigo_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `capitulo`
--

CREATE TABLE `capitulo` (
  `Capitulo_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cc`
--

CREATE TABLE `cc` (
  `Documento_Documento_ID` int(11) NOT NULL,
  `ID` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `documento`
--

CREATE TABLE `documento` (
  `Utente_numero_utente` int(10) NOT NULL,
  `Documento_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `doutoramento`
--

CREATE TABLE `doutoramento` (
  `Tese_Monografia_Publicacao_ID_Publicacao` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `emprestimo`
--

CREATE TABLE `emprestimo` (
  `Data` date DEFAULT NULL,
  `ID_Emprestimo` int(10) NOT NULL,
  `NumProlongamentos` int(10) DEFAULT NULL,
  `Data_Devol` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `emprestimodoexemp`
--

CREATE TABLE `emprestimodoexemp` (
  `Emprestimo_ID_Emprestimo_` int(10) NOT NULL,
  `Exemplar_tag_RFID_` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `exemplar`
--

CREATE TABLE `exemplar` (
  `Publicacao_ID_Publicacao` int(15) NOT NULL,
  `tag_RFID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `extraviado`
--

CREATE TABLE `extraviado` (
  `Exemplar_tag_RFID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `extravio`
--

CREATE TABLE `extravio` (
  `Emprestimo_ID_Emprestimo` int(10) NOT NULL,
  `Valor` int(10) DEFAULT NULL,
  `id_extravio` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `feed`
--

CREATE TABLE `feed` (
  `Feed_ID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `feed_editora`
--

CREATE TABLE `feed_editora` (
  `Feed_Feed_ID` int(10) NOT NULL,
  `link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `feed_periodico`
--

CREATE TABLE `feed_periodico` (
  `Feed_editora_Feed_Feed_ID` int(10) NOT NULL,
  `Periodicidade_Periodicidade_ID` int(11) NOT NULL,
  `Feed_periodico_ID` int(11) NOT NULL,
  `link_p` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `formulario`
--

CREATE TABLE `formulario` (
  `Feed_Feed_ID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `gasto`
--

CREATE TABLE `gasto` (
  `Exemplar_tag_RFID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `importacao`
--

CREATE TABLE `importacao` (
  `Feed_Feed_ID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `info`
--

CREATE TABLE `info` (
  `Publicacao_ID_Publicacao` int(15) NOT NULL,
  `Info_ID` int(11) NOT NULL,
  `Autores` text DEFAULT NULL,
  `Editora` varchar(50) DEFAULT NULL,
  `Data` date DEFAULT NULL,
  `Descricao` text DEFAULT NULL,
  `Num_Paginas` int(11) DEFAULT NULL,
  `Img_Ampliada` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `inutilizado`
--

CREATE TABLE `inutilizado` (
  `Exemplar_tag_RFID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `jornais`
--

CREATE TABLE `jornais` (
  `Periodico_ISSN` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `lista_de_leitura`
--

CREATE TABLE `lista_de_leitura` (
  `Utente_numero_utente` int(10) NOT NULL,
  `Nome` varchar(50) NOT NULL,
  `Criterio` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `livro`
--

CREATE TABLE `livro` (
  `Publicacao_ID_Publicacao` int(15) NOT NULL,
  `ISBN` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `livros_nao_emp`
--

CREATE TABLE `livros_nao_emp` (
  `Exemplar_tag_RFID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `mais_consultados`
--

CREATE TABLE `mais_consultados` (
  `Area_ID_Area` int(20) NOT NULL,
  `Mais_Consultados_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `mestrado`
--

CREATE TABLE `mestrado` (
  `Tese_Monografia_Publicacao_ID_Publicacao` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `monografia`
--

CREATE TABLE `monografia` (
  `Publicacao_ID_Publicacao` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `multa`
--

CREATE TABLE `multa` (
  `Emprestimo_ID_Emprestimo` int(10) NOT NULL,
  `Dias_atraso` int(10) DEFAULT NULL,
  `Valor` int(10) DEFAULT NULL,
  `id_multa` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `novo`
--

CREATE TABLE `novo` (
  `Exemplar_tag_RFID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `palavrachave`
--

CREATE TABLE `palavrachave` (
  `Palavra` varchar(30) DEFAULT NULL,
  `PalavraChave_ID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `palavraschavedapublicacao`
--

CREATE TABLE `palavraschavedapublicacao` (
  `Publicacao_ID_Publicacao_` int(15) NOT NULL,
  `PalavraChave_PalavraChave_ID_` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `palavraschavedoartigo`
--

CREATE TABLE `palavraschavedoartigo` (
  `PalavraChave_PalavraChave_ID_` int(10) NOT NULL,
  `Artigo_Artigo_ID_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `palavraschavedocapitulo`
--

CREATE TABLE `palavraschavedocapitulo` (
  `PalavraChave_PalavraChave_ID_` int(10) NOT NULL,
  `Capitulo_Capitulo_ID_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `passaporte`
--

CREATE TABLE `passaporte` (
  `Documento_Documento_ID` int(11) NOT NULL,
  `ID` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `periodicidade`
--

CREATE TABLE `periodicidade` (
  `Periodicidade_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `periodico`
--

CREATE TABLE `periodico` (
  `Publicacao_ID_Publicacao` int(15) NOT NULL,
  `Periodicidade_Periodicidade_ID` int(11) DEFAULT NULL,
  `ISSN` int(10) NOT NULL,
  `Edicao` int(10) DEFAULT NULL,
  `NumEdicoesEmp` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `prateleiras`
--

CREATE TABLE `prateleiras` (
  `Numero` int(10) NOT NULL,
  `Nivel_ocupacao` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `prolongamento`
--

CREATE TABLE `prolongamento` (
  `Emprestimo_ID_Emprestimo` int(10) NOT NULL,
  `Nova_Data` date DEFAULT NULL,
  `Prolongamento_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `publicacao`
--

CREATE TABLE `publicacao` (
  `Info_Info_ID` int(11) NOT NULL,
  `SubArea_Area_ID_Area` int(20) NOT NULL,
  `SubArea_id_subarea` int(10) NOT NULL,
  `ID_Publicacao` int(15) NOT NULL,
  `Titulo` varchar(50) DEFAULT NULL,
  `Abreviatura` varchar(10) DEFAULT NULL,
  `SubTitulo` varchar(50) DEFAULT NULL,
  `Miniatura` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `publicacoesdofeed`
--

CREATE TABLE `publicacoesdofeed` (
  `Publicacao_ID_Publicacao_` int(15) NOT NULL,
  `Feed_Feed_ID_` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `recentes`
--

CREATE TABLE `recentes` (
  `Area_ID_Area` int(20) NOT NULL,
  `Recentes_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `relatoriotecnico`
--

CREATE TABLE `relatoriotecnico` (
  `Monografia_Publicacao_ID_Publicacao` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `relevancia`
--

CREATE TABLE `relevancia` (
  `Area_ID_Area` int(20) NOT NULL,
  `Relevancia_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `revistas`
--

CREATE TABLE `revistas` (
  `Periodico_ISSN` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `revistas_emp`
--

CREATE TABLE `revistas_emp` (
  `Exemplar_tag_RFID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `subarea`
--

CREATE TABLE `subarea` (
  `Area_ID_Area` int(20) NOT NULL,
  `id_subarea` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `suspensao`
--

CREATE TABLE `suspensao` (
  `Utente_numero_utente` int(10) NOT NULL,
  `Suspensao_ID` int(11) NOT NULL,
  `data_ini` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tese`
--

CREATE TABLE `tese` (
  `Monografia_Publicacao_ID_Publicacao` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `textopedagogico`
--

CREATE TABLE `textopedagogico` (
  `Monografia_Publicacao_ID_Publicacao` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Estrutura da tabela `utente`
--

CREATE TABLE `utente` (
  `Emprestimo_ID_Emprestimo` int(10) NOT NULL,
  `Documento_Documento_ID` int(11) NOT NULL,
  `Suspensao_Suspensao_ID` int(11) NOT NULL,
  `Nome` varchar(50) DEFAULT NULL,
  `numero_utente` int(10) NOT NULL,
  `Morada` text DEFAULT NULL,
  `Telefone` int(10) DEFAULT NULL,
  `Email` varchar(30) DEFAULT NULL,
  `TotalAPagar` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`ID_Area`);

--
-- Índices para tabela `armarios`
--
ALTER TABLE `armarios`
  ADD PRIMARY KEY (`Letra`,`Piso`),
  ADD KEY `FK_Armarios_AreaDoArmario_Area` (`Area_ID_Area`);

--
-- Índices para tabela `artigo`
--
ALTER TABLE `artigo`
  ADD PRIMARY KEY (`Artigo_ID`);

--
-- Índices para tabela `capitulo`
--
ALTER TABLE `capitulo`
  ADD PRIMARY KEY (`Capitulo_ID`);

--
-- Índices para tabela `cc`
--
ALTER TABLE `cc`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_CC_Documento` (`Documento_Documento_ID`);

--
-- Índices para tabela `documento`
--
ALTER TABLE `documento`
  ADD PRIMARY KEY (`Documento_ID`),
  ADD KEY `FK_Documento_Doc_Utente` (`Utente_numero_utente`);

--
-- Índices para tabela `doutoramento`
--
ALTER TABLE `doutoramento`
  ADD PRIMARY KEY (`Tese_Monografia_Publicacao_ID_Publicacao`);

--
-- Índices para tabela `emprestimo`
--
ALTER TABLE `emprestimo`
  ADD PRIMARY KEY (`ID_Emprestimo`);

--
-- Índices para tabela `emprestimodoexemp`
--
ALTER TABLE `emprestimodoexemp`
  ADD PRIMARY KEY (`Emprestimo_ID_Emprestimo_`,`Exemplar_tag_RFID_`),
  ADD KEY `FK_Exemplar_EmprestimoDoExemp_Emprestimo_` (`Exemplar_tag_RFID_`);

--
-- Índices para tabela `exemplar`
--
ALTER TABLE `exemplar`
  ADD PRIMARY KEY (`tag_RFID`),
  ADD KEY `FK_Exemplar_ExePubli_Publicacao` (`Publicacao_ID_Publicacao`);

--
-- Índices para tabela `extraviado`
--
ALTER TABLE `extraviado`
  ADD PRIMARY KEY (`Exemplar_tag_RFID`);

--
-- Índices para tabela `extravio`
--
ALTER TABLE `extravio`
  ADD PRIMARY KEY (`id_extravio`),
  ADD KEY `FK_Extravio_Extra_Emprestimo` (`Emprestimo_ID_Emprestimo`);

--
-- Índices para tabela `feed`
--
ALTER TABLE `feed`
  ADD PRIMARY KEY (`Feed_ID`);

--
-- Índices para tabela `feed_editora`
--
ALTER TABLE `feed_editora`
  ADD PRIMARY KEY (`Feed_Feed_ID`);

--
-- Índices para tabela `feed_periodico`
--
ALTER TABLE `feed_periodico`
  ADD PRIMARY KEY (`Feed_editora_Feed_Feed_ID`,`Feed_periodico_ID`),
  ADD KEY `FK_Feed_periodico_PeriodicidadeDoFeed_Periodicidade` (`Periodicidade_Periodicidade_ID`);

--
-- Índices para tabela `formulario`
--
ALTER TABLE `formulario`
  ADD PRIMARY KEY (`Feed_Feed_ID`);

--
-- Índices para tabela `gasto`
--
ALTER TABLE `gasto`
  ADD PRIMARY KEY (`Exemplar_tag_RFID`);

--
-- Índices para tabela `importacao`
--
ALTER TABLE `importacao`
  ADD PRIMARY KEY (`Feed_Feed_ID`);

--
-- Índices para tabela `info`
--
ALTER TABLE `info`
  ADD PRIMARY KEY (`Info_ID`),
  ADD KEY `FK_Info_InfoPubli_Publicacao` (`Publicacao_ID_Publicacao`);

--
-- Índices para tabela `inutilizado`
--
ALTER TABLE `inutilizado`
  ADD PRIMARY KEY (`Exemplar_tag_RFID`);

--
-- Índices para tabela `jornais`
--
ALTER TABLE `jornais`
  ADD PRIMARY KEY (`Periodico_ISSN`);

--
-- Índices para tabela `lista_de_leitura`
--
ALTER TABLE `lista_de_leitura`
  ADD PRIMARY KEY (`Nome`),
  ADD KEY `FK_Lista_de_leitura_ListaLeitura_Utente` (`Utente_numero_utente`);

--
-- Índices para tabela `livro`
--
ALTER TABLE `livro`
  ADD PRIMARY KEY (`ISBN`),
  ADD KEY `FK_Livro_Publicacao` (`Publicacao_ID_Publicacao`);

--
-- Índices para tabela `livros_nao_emp`
--
ALTER TABLE `livros_nao_emp`
  ADD PRIMARY KEY (`Exemplar_tag_RFID`);

--
-- Índices para tabela `mais_consultados`
--
ALTER TABLE `mais_consultados`
  ADD PRIMARY KEY (`Mais_Consultados_ID`),
  ADD KEY `FK_Mais_Consultados_LivrosMaisConsultados_Area` (`Area_ID_Area`);

--
-- Índices para tabela `mestrado`
--
ALTER TABLE `mestrado`
  ADD PRIMARY KEY (`Tese_Monografia_Publicacao_ID_Publicacao`);

--
-- Índices para tabela `monografia`
--
ALTER TABLE `monografia`
  ADD PRIMARY KEY (`Publicacao_ID_Publicacao`);

--
-- Índices para tabela `multa`
--
ALTER TABLE `multa`
  ADD PRIMARY KEY (`id_multa`),
  ADD KEY `FK_Multa_InfoMulta_Emprestimo` (`Emprestimo_ID_Emprestimo`);

--
-- Índices para tabela `novo`
--
ALTER TABLE `novo`
  ADD PRIMARY KEY (`Exemplar_tag_RFID`);

--
-- Índices para tabela `palavrachave`
--
ALTER TABLE `palavrachave`
  ADD PRIMARY KEY (`PalavraChave_ID`);

--
-- Índices para tabela `palavraschavedapublicacao`
--
ALTER TABLE `palavraschavedapublicacao`
  ADD PRIMARY KEY (`Publicacao_ID_Publicacao_`,`PalavraChave_PalavraChave_ID_`),
  ADD KEY `FK_PalavraChave_PalavrasChaveDaPublicacao_Publicacao_` (`PalavraChave_PalavraChave_ID_`);

--
-- Índices para tabela `palavraschavedoartigo`
--
ALTER TABLE `palavraschavedoartigo`
  ADD PRIMARY KEY (`PalavraChave_PalavraChave_ID_`,`Artigo_Artigo_ID_`),
  ADD KEY `FK_Artigo_PalavrasChaveDoArtigo_PalavraChave_` (`Artigo_Artigo_ID_`);

--
-- Índices para tabela `palavraschavedocapitulo`
--
ALTER TABLE `palavraschavedocapitulo`
  ADD PRIMARY KEY (`PalavraChave_PalavraChave_ID_`,`Capitulo_Capitulo_ID_`),
  ADD KEY `FK_Capitulo_PalavrasChaveDoCapitulo_PalavraChave_` (`Capitulo_Capitulo_ID_`);

--
-- Índices para tabela `passaporte`
--
ALTER TABLE `passaporte`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_Passaporte_Documento` (`Documento_Documento_ID`);

--
-- Índices para tabela `periodicidade`
--
ALTER TABLE `periodicidade`
  ADD PRIMARY KEY (`Periodicidade_ID`);

--
-- Índices para tabela `periodico`
--
ALTER TABLE `periodico`
  ADD PRIMARY KEY (`ISSN`),
  ADD KEY `FK_Periodico_PeriodoDoPeriodico_Periodicidade` (`Periodicidade_Periodicidade_ID`),
  ADD KEY `FK_Periodico_Publicacao` (`Publicacao_ID_Publicacao`);

--
-- Índices para tabela `prateleiras`
--
ALTER TABLE `prateleiras`
  ADD PRIMARY KEY (`Numero`);

--
-- Índices para tabela `prolongamento`
--
ALTER TABLE `prolongamento`
  ADD PRIMARY KEY (`Prolongamento_id`),
  ADD KEY `FK_Prolongamento_Prolo_Emprestimo` (`Emprestimo_ID_Emprestimo`);

--
-- Índices para tabela `publicacao`
--
ALTER TABLE `publicacao`
  ADD PRIMARY KEY (`ID_Publicacao`),
  ADD KEY `FK_Publicacao_PubliArea_SubArea` (`SubArea_Area_ID_Area`,`SubArea_id_subarea`),
  ADD KEY `FK_Publicacao_InfoPubli_Info` (`Info_Info_ID`);

--
-- Índices para tabela `publicacoesdofeed`
--
ALTER TABLE `publicacoesdofeed`
  ADD PRIMARY KEY (`Publicacao_ID_Publicacao_`,`Feed_Feed_ID_`),
  ADD KEY `FK_Feed_PublicacoesDoFeed_Publicacao_` (`Feed_Feed_ID_`);

--
-- Índices para tabela `recentes`
--
ALTER TABLE `recentes`
  ADD PRIMARY KEY (`Recentes_ID`),
  ADD KEY `FK_Recentes_LivrosMaisRecentes_Area` (`Area_ID_Area`);

--
-- Índices para tabela `relatoriotecnico`
--
ALTER TABLE `relatoriotecnico`
  ADD PRIMARY KEY (`Monografia_Publicacao_ID_Publicacao`);

--
-- Índices para tabela `relevancia`
--
ALTER TABLE `relevancia`
  ADD PRIMARY KEY (`Relevancia_ID`),
  ADD KEY `FK_Relevancia_LivrosMaisRelevantes_Area` (`Area_ID_Area`);

--
-- Índices para tabela `revistas`
--
ALTER TABLE `revistas`
  ADD PRIMARY KEY (`Periodico_ISSN`);

--
-- Índices para tabela `revistas_emp`
--
ALTER TABLE `revistas_emp`
  ADD PRIMARY KEY (`Exemplar_tag_RFID`);

--
-- Índices para tabela `subarea`
--
ALTER TABLE `subarea`
  ADD PRIMARY KEY (`Area_ID_Area`,`id_subarea`);

--
-- Índices para tabela `suspensao`
--
ALTER TABLE `suspensao`
  ADD PRIMARY KEY (`Suspensao_ID`),
  ADD KEY `FK_Suspensao_Susp_Utente` (`Utente_numero_utente`);

--
-- Índices para tabela `tese`
--
ALTER TABLE `tese`
  ADD PRIMARY KEY (`Monografia_Publicacao_ID_Publicacao`);

--
-- Índices para tabela `textopedagogico`
--
ALTER TABLE `textopedagogico`
  ADD PRIMARY KEY (`Monografia_Publicacao_ID_Publicacao`);

--
-- Índices para tabela `utente`
--
ALTER TABLE `utente`
  ADD PRIMARY KEY (`numero_utente`),
  ADD KEY `FK_Utente_Doc_Documento` (`Documento_Documento_ID`),
  ADD KEY `FK_Utente_Susp_Suspensao` (`Suspensao_Suspensao_ID`),
  ADD KEY `FK_Utente_UtenteEmpre_Emprestimo` (`Emprestimo_ID_Emprestimo`);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `armarios`
--
ALTER TABLE `armarios`
  ADD CONSTRAINT `FK_Armarios_AreaDoArmario_Area` FOREIGN KEY (`Area_ID_Area`) REFERENCES `area` (`ID_Area`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `cc`
--
ALTER TABLE `cc`
  ADD CONSTRAINT `FK_CC_Documento` FOREIGN KEY (`Documento_Documento_ID`) REFERENCES `documento` (`Documento_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `documento`
--
ALTER TABLE `documento`
  ADD CONSTRAINT `FK_Documento_Doc_Utente` FOREIGN KEY (`Utente_numero_utente`) REFERENCES `utente` (`numero_utente`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `doutoramento`
--
ALTER TABLE `doutoramento`
  ADD CONSTRAINT `FK_Doutoramento_Tese` FOREIGN KEY (`Tese_Monografia_Publicacao_ID_Publicacao`) REFERENCES `tese` (`Monografia_Publicacao_ID_Publicacao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `emprestimodoexemp`
--
ALTER TABLE `emprestimodoexemp`
  ADD CONSTRAINT `FK_Emprestimo_EmprestimoDoExemp_Exemplar_` FOREIGN KEY (`Emprestimo_ID_Emprestimo_`) REFERENCES `emprestimo` (`ID_Emprestimo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Exemplar_EmprestimoDoExemp_Emprestimo_` FOREIGN KEY (`Exemplar_tag_RFID_`) REFERENCES `exemplar` (`tag_RFID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `exemplar`
--
ALTER TABLE `exemplar`
  ADD CONSTRAINT `FK_Exemplar_ExePubli_Publicacao` FOREIGN KEY (`Publicacao_ID_Publicacao`) REFERENCES `publicacao` (`ID_Publicacao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `extraviado`
--
ALTER TABLE `extraviado`
  ADD CONSTRAINT `FK_Extraviado_Exemplar` FOREIGN KEY (`Exemplar_tag_RFID`) REFERENCES `exemplar` (`tag_RFID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `extravio`
--
ALTER TABLE `extravio`
  ADD CONSTRAINT `FK_Extravio_Extra_Emprestimo` FOREIGN KEY (`Emprestimo_ID_Emprestimo`) REFERENCES `emprestimo` (`ID_Emprestimo`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `feed_editora`
--
ALTER TABLE `feed_editora`
  ADD CONSTRAINT `FK_Feed_editora_Feed` FOREIGN KEY (`Feed_Feed_ID`) REFERENCES `feed` (`Feed_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `feed_periodico`
--
ALTER TABLE `feed_periodico`
  ADD CONSTRAINT `FK_Feed_periodico_FeedEditora_Feed_editora` FOREIGN KEY (`Feed_editora_Feed_Feed_ID`) REFERENCES `feed_editora` (`Feed_Feed_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Feed_periodico_PeriodicidadeDoFeed_Periodicidade` FOREIGN KEY (`Periodicidade_Periodicidade_ID`) REFERENCES `periodicidade` (`Periodicidade_ID`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `formulario`
--
ALTER TABLE `formulario`
  ADD CONSTRAINT `FK_Formulario_Feed` FOREIGN KEY (`Feed_Feed_ID`) REFERENCES `feed` (`Feed_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `gasto`
--
ALTER TABLE `gasto`
  ADD CONSTRAINT `FK_Gasto_Exemplar` FOREIGN KEY (`Exemplar_tag_RFID`) REFERENCES `exemplar` (`tag_RFID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `importacao`
--
ALTER TABLE `importacao`
  ADD CONSTRAINT `FK_Importacao_Feed` FOREIGN KEY (`Feed_Feed_ID`) REFERENCES `feed` (`Feed_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `info`
--
ALTER TABLE `info`
  ADD CONSTRAINT `FK_Info_InfoPubli_Publicacao` FOREIGN KEY (`Publicacao_ID_Publicacao`) REFERENCES `publicacao` (`ID_Publicacao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `inutilizado`
--
ALTER TABLE `inutilizado`
  ADD CONSTRAINT `FK_Inutilizado_Exemplar` FOREIGN KEY (`Exemplar_tag_RFID`) REFERENCES `exemplar` (`tag_RFID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `jornais`
--
ALTER TABLE `jornais`
  ADD CONSTRAINT `FK_Jornais_Periodico` FOREIGN KEY (`Periodico_ISSN`) REFERENCES `periodico` (`ISSN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `lista_de_leitura`
--
ALTER TABLE `lista_de_leitura`
  ADD CONSTRAINT `FK_Lista_de_leitura_ListaLeitura_Utente` FOREIGN KEY (`Utente_numero_utente`) REFERENCES `utente` (`numero_utente`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `livro`
--
ALTER TABLE `livro`
  ADD CONSTRAINT `FK_Livro_Publicacao` FOREIGN KEY (`Publicacao_ID_Publicacao`) REFERENCES `publicacao` (`ID_Publicacao`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `livros_nao_emp`
--
ALTER TABLE `livros_nao_emp`
  ADD CONSTRAINT `FK_Livros_nao_emp_Exemplar` FOREIGN KEY (`Exemplar_tag_RFID`) REFERENCES `exemplar` (`tag_RFID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `mais_consultados`
--
ALTER TABLE `mais_consultados`
  ADD CONSTRAINT `FK_Mais_Consultados_LivrosMaisConsultados_Area` FOREIGN KEY (`Area_ID_Area`) REFERENCES `area` (`ID_Area`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `mestrado`
--
ALTER TABLE `mestrado`
  ADD CONSTRAINT `FK_Mestrado_Tese` FOREIGN KEY (`Tese_Monografia_Publicacao_ID_Publicacao`) REFERENCES `tese` (`Monografia_Publicacao_ID_Publicacao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `monografia`
--
ALTER TABLE `monografia`
  ADD CONSTRAINT `FK_Monografia_Publicacao` FOREIGN KEY (`Publicacao_ID_Publicacao`) REFERENCES `publicacao` (`ID_Publicacao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `multa`
--
ALTER TABLE `multa`
  ADD CONSTRAINT `FK_Multa_InfoMulta_Emprestimo` FOREIGN KEY (`Emprestimo_ID_Emprestimo`) REFERENCES `emprestimo` (`ID_Emprestimo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `novo`
--
ALTER TABLE `novo`
  ADD CONSTRAINT `FK_Novo_Exemplar` FOREIGN KEY (`Exemplar_tag_RFID`) REFERENCES `exemplar` (`tag_RFID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `palavraschavedapublicacao`
--
ALTER TABLE `palavraschavedapublicacao`
  ADD CONSTRAINT `FK_PalavraChave_PalavrasChaveDaPublicacao_Publicacao_` FOREIGN KEY (`PalavraChave_PalavraChave_ID_`) REFERENCES `palavrachave` (`PalavraChave_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Publicacao_PalavrasChaveDaPublicacao_PalavraChave_` FOREIGN KEY (`Publicacao_ID_Publicacao_`) REFERENCES `publicacao` (`ID_Publicacao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `palavraschavedoartigo`
--
ALTER TABLE `palavraschavedoartigo`
  ADD CONSTRAINT `FK_Artigo_PalavrasChaveDoArtigo_PalavraChave_` FOREIGN KEY (`Artigo_Artigo_ID_`) REFERENCES `artigo` (`Artigo_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PalavraChave_PalavrasChaveDoArtigo_Artigo_` FOREIGN KEY (`PalavraChave_PalavraChave_ID_`) REFERENCES `palavrachave` (`PalavraChave_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `palavraschavedocapitulo`
--
ALTER TABLE `palavraschavedocapitulo`
  ADD CONSTRAINT `FK_Capitulo_PalavrasChaveDoCapitulo_PalavraChave_` FOREIGN KEY (`Capitulo_Capitulo_ID_`) REFERENCES `capitulo` (`Capitulo_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PalavraChave_PalavrasChaveDoCapitulo_Capitulo_` FOREIGN KEY (`PalavraChave_PalavraChave_ID_`) REFERENCES `palavrachave` (`PalavraChave_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `passaporte`
--
ALTER TABLE `passaporte`
  ADD CONSTRAINT `FK_Passaporte_Documento` FOREIGN KEY (`Documento_Documento_ID`) REFERENCES `documento` (`Documento_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `periodico`
--
ALTER TABLE `periodico`
  ADD CONSTRAINT `FK_Periodico_PeriodoDoPeriodico_Periodicidade` FOREIGN KEY (`Periodicidade_Periodicidade_ID`) REFERENCES `periodicidade` (`Periodicidade_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Periodico_Publicacao` FOREIGN KEY (`Publicacao_ID_Publicacao`) REFERENCES `publicacao` (`ID_Publicacao`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `prolongamento`
--
ALTER TABLE `prolongamento`
  ADD CONSTRAINT `FK_Prolongamento_Prolo_Emprestimo` FOREIGN KEY (`Emprestimo_ID_Emprestimo`) REFERENCES `emprestimo` (`ID_Emprestimo`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `publicacao`
--
ALTER TABLE `publicacao`
  ADD CONSTRAINT `FK_Publicacao_InfoPubli_Info` FOREIGN KEY (`Info_Info_ID`) REFERENCES `info` (`Info_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Publicacao_PubliArea_SubArea` FOREIGN KEY (`SubArea_Area_ID_Area`,`SubArea_id_subarea`) REFERENCES `subarea` (`Area_ID_Area`, `id_subarea`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `publicacoesdofeed`
--
ALTER TABLE `publicacoesdofeed`
  ADD CONSTRAINT `FK_Feed_PublicacoesDoFeed_Publicacao_` FOREIGN KEY (`Feed_Feed_ID_`) REFERENCES `feed` (`Feed_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Publicacao_PublicacoesDoFeed_Feed_` FOREIGN KEY (`Publicacao_ID_Publicacao_`) REFERENCES `publicacao` (`ID_Publicacao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `recentes`
--
ALTER TABLE `recentes`
  ADD CONSTRAINT `FK_Recentes_LivrosMaisRecentes_Area` FOREIGN KEY (`Area_ID_Area`) REFERENCES `area` (`ID_Area`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `relatoriotecnico`
--
ALTER TABLE `relatoriotecnico`
  ADD CONSTRAINT `FK_RelatorioTecnico_Monografia` FOREIGN KEY (`Monografia_Publicacao_ID_Publicacao`) REFERENCES `monografia` (`Publicacao_ID_Publicacao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `relevancia`
--
ALTER TABLE `relevancia`
  ADD CONSTRAINT `FK_Relevancia_LivrosMaisRelevantes_Area` FOREIGN KEY (`Area_ID_Area`) REFERENCES `area` (`ID_Area`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `revistas`
--
ALTER TABLE `revistas`
  ADD CONSTRAINT `FK_Revistas_Periodico` FOREIGN KEY (`Periodico_ISSN`) REFERENCES `periodico` (`ISSN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `revistas_emp`
--
ALTER TABLE `revistas_emp`
  ADD CONSTRAINT `FK_Revistas_Emp_Exemplar` FOREIGN KEY (`Exemplar_tag_RFID`) REFERENCES `exemplar` (`tag_RFID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `subarea`
--
ALTER TABLE `subarea`
  ADD CONSTRAINT `FK_SubArea_SubArea_Area` FOREIGN KEY (`Area_ID_Area`) REFERENCES `area` (`ID_Area`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `suspensao`
--
ALTER TABLE `suspensao`
  ADD CONSTRAINT `FK_Suspensao_Susp_Utente` FOREIGN KEY (`Utente_numero_utente`) REFERENCES `utente` (`numero_utente`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tese`
--
ALTER TABLE `tese`
  ADD CONSTRAINT `FK_Tese_Monografia` FOREIGN KEY (`Monografia_Publicacao_ID_Publicacao`) REFERENCES `monografia` (`Publicacao_ID_Publicacao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `textopedagogico`
--
ALTER TABLE `textopedagogico`
  ADD CONSTRAINT `FK_TextoPedagogico_Monografia` FOREIGN KEY (`Monografia_Publicacao_ID_Publicacao`) REFERENCES `monografia` (`Publicacao_ID_Publicacao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `utente`
--
ALTER TABLE `utente`
  ADD CONSTRAINT `FK_Utente_Doc_Documento` FOREIGN KEY (`Documento_Documento_ID`) REFERENCES `documento` (`Documento_ID`),
  ADD CONSTRAINT `FK_Utente_Susp_Suspensao` FOREIGN KEY (`Suspensao_Suspensao_ID`) REFERENCES `suspensao` (`Suspensao_ID`),
  ADD CONSTRAINT `FK_Utente_UtenteEmpre_Emprestimo` FOREIGN KEY (`Emprestimo_ID_Emprestimo`) REFERENCES `emprestimo` (`ID_Emprestimo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
