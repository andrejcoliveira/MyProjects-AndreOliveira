drop table if exists PalavrasChaveDaPublicacao ;
drop table if exists PalavrasChaveDoArtigo ;
drop table if exists PalavrasChaveDoCapitulo ;
drop table if exists EmprestimoDoExemp ;
drop table if exists PublicacoesDoFeed ;
drop table if exists Publicacao ;
drop table if exists PalavraChave ;
drop table if exists Info ;
drop table if exists Livro ;
drop table if exists Periodico ;
drop table if exists Monografia ;
drop table if exists Revistas ;
drop table if exists Jornais ;
drop table if exists Mestrado ;
drop table if exists Doutoramento ;
drop table if exists Tese ;
drop table if exists RelatorioTecnico ;
drop table if exists TextoPedagogico ;
drop table if exists Artigo ;
drop table if exists Area ;
drop table if exists Capitulo ;
drop table if exists Utente ;
drop table if exists Emprestimo ;
drop table if exists Prolongamento ;
drop table if exists Multa ;
drop table if exists Documento ;
drop table if exists Passaporte ;
drop table if exists CC ;
drop table if exists Exemplar ;
drop table if exists Livros_nao_emp ;
drop table if exists Revistas_Emp ;
drop table if exists Extravio ;
drop table if exists Suspensao ;
drop table if exists Armarios ;
drop table if exists Prateleiras ;
drop table if exists Novo ;
drop table if exists Gasto ;
drop table if exists Extraviado ;
drop table if exists Inutilizado ;
drop table if exists Lista_de_leitura ;
drop table if exists Relevancia ;
drop table if exists Mais_Consultados ;
drop table if exists Recentes ;
drop table if exists Feed ;
drop table if exists Formulario ;
drop table if exists Importacao ;
drop table if exists Feed_editora ;
drop table if exists Feed_periodico ;
drop table if exists Periodicidade ;
drop table if exists SubArea ;
 
create table PalavrasChaveDaPublicacao
(
   Publicacao_ID_Publicacao_   int(15)   not null,
   PalavraChave_PalavraChave_ID_   int(10)   not null,
 
   constraint PK_PalavrasChaveDaPublicacao primary key (Publicacao_ID_Publicacao_, PalavraChave_PalavraChave_ID_)
);
 
create table PalavrasChaveDoArtigo
(
   PalavraChave_PalavraChave_ID_   int(10)   not null,
   Artigo_Artigo_ID_   integer   not null,
 
   constraint PK_PalavrasChaveDoArtigo primary key (PalavraChave_PalavraChave_ID_, Artigo_Artigo_ID_)
);
 
create table PalavrasChaveDoCapitulo
(
   PalavraChave_PalavraChave_ID_   int(10)   not null,
   Capitulo_Capitulo_ID_   integer   not null,
 
   constraint PK_PalavrasChaveDoCapitulo primary key (PalavraChave_PalavraChave_ID_, Capitulo_Capitulo_ID_)
);
 
create table EmprestimoDoExemp
(
   Emprestimo_ID_Emprestimo_   int(10)   not null,
   Exemplar_tag_RFID_   int(10)   not null,
 
   constraint PK_EmprestimoDoExemp primary key (Emprestimo_ID_Emprestimo_, Exemplar_tag_RFID_)
);
 
create table PublicacoesDoFeed
(
   Publicacao_ID_Publicacao_   int(15)   not null,
   Feed_Feed_ID_   int(10)   not null,
 
   constraint PK_PublicacoesDoFeed primary key (Publicacao_ID_Publicacao_, Feed_Feed_ID_)
);
 
create table Publicacao
(
   Info_Info_ID   integer   not null,
   SubArea_Area_ID_Area   int(20)   not null,
   SubArea_id_subarea   int(10)   not null,
   ID_Publicacao   int(15)   not null,
   Titulo   varchar(50)   null,
   Abreviatura   varchar(10)   null,
   SubTitulo   varchar(50)   null,
   Miniatura   varchar(255)   null,
 
   constraint PK_Publicacao primary key (ID_Publicacao)
);
 
create table PalavraChave
(
   Palavra   varchar(30)   null,
   PalavraChave_ID   int(10)   not null,
 
   constraint PK_PalavraChave primary key (PalavraChave_ID)
);
 
create table Info
(
   Publicacao_ID_Publicacao   int(15)   not null,
   Info_ID   integer   not null,
   Autores   Text   null,
   Editora   varchar(50)   null,
   Data   date   null,
   Descricao   text   null,
   Num_Paginas   Integer   null,
   Img_Ampliada   varchar(255)   null,
 
   constraint PK_Info primary key (Info_ID)
);
 
create table Livro
(
   Publicacao_ID_Publicacao   int(15)   not null,
   ISBN   Integer   not null,
 
   constraint PK_Livro primary key (ISBN)
);
 
create table Periodico
(
   Publicacao_ID_Publicacao   int(15)   not null,
   Periodicidade_Periodicidade_ID   integer   null,
   ISSN   int(10)   not null,
   Edicao   int(10)   null,
   NumEdicoesEmp   int(10)   null,
 
   constraint PK_Periodico primary key (ISSN)
);
 
create table Monografia
(
   Publicacao_ID_Publicacao   int(15)   not null,
 
   constraint PK_Monografia primary key (Publicacao_ID_Publicacao)
);
 
create table Revistas
(
   Periodico_ISSN   int(10)   not null,
 
   constraint PK_Revistas primary key (Periodico_ISSN)
);
 
create table Jornais
(
   Periodico_ISSN   int(10)   not null,
 
   constraint PK_Jornais primary key (Periodico_ISSN)
);
 
create table Mestrado
(
   Tese_Monografia_Publicacao_ID_Publicacao   int(15)   not null,
 
   constraint PK_Mestrado primary key (Tese_Monografia_Publicacao_ID_Publicacao)
);
 
create table Doutoramento
(
   Tese_Monografia_Publicacao_ID_Publicacao   int(15)   not null,
 
   constraint PK_Doutoramento primary key (Tese_Monografia_Publicacao_ID_Publicacao)
);
 
create table Tese
(
   Monografia_Publicacao_ID_Publicacao   int(15)   not null,
 
   constraint PK_Tese primary key (Monografia_Publicacao_ID_Publicacao)
);
 
create table RelatorioTecnico
(
   Monografia_Publicacao_ID_Publicacao   int(15)   not null,
 
   constraint PK_RelatorioTecnico primary key (Monografia_Publicacao_ID_Publicacao)
);
 
create table TextoPedagogico
(
   Monografia_Publicacao_ID_Publicacao   int(15)   not null,
 
   constraint PK_TextoPedagogico primary key (Monografia_Publicacao_ID_Publicacao)
);
 
create table Artigo
(
   Artigo_ID   integer   not null,
 
   constraint PK_Artigo primary key (Artigo_ID)
);
 
create table Area
(
   Nome   varchar(50)   null,
   ID_Area   int(20)   not null,
 
   constraint PK_Area primary key (ID_Area)
);
 
create table Capitulo
(
   Capitulo_ID   integer   not null,
 
   constraint PK_Capitulo primary key (Capitulo_ID)
);
 
create table Utente
(
   Emprestimo_ID_Emprestimo   int(10)   not null,
   Documento_Documento_ID   integer   not null,
   Suspensao_Suspensao_ID   integer   not null,
   Nome   varchar(50)   null,
   numero_utente   int(10)   not null,
   Morada   Text   null,
   Telefone   int(10)   null,
   Email   varchar(30)   null,
   TotalAPagar   int(10)   null,
 
   constraint PK_Utente primary key (numero_utente)
);
 
create table Emprestimo
(
   Data   date   null,
   ID_Emprestimo   int(10)   not null,
   NumProlongamentos   int(10)   null,
   Data_Devol   Date   null,
 
   constraint PK_Emprestimo primary key (ID_Emprestimo)
);
 
create table Prolongamento
(
   Emprestimo_ID_Emprestimo   int(10)   not null,
   Nova_Data   Date   null,
   Prolongamento_id   int(10)   not null,
 
   constraint PK_Prolongamento primary key (Prolongamento_id)
);
 
create table Multa
(
   Emprestimo_ID_Emprestimo   int(10)   not null,
   Dias_atraso   int(10)   null,
   Valor   int(10)   null,
   id_multa   int(10)   not null,
 
   constraint PK_Multa primary key (id_multa)
);
 
create table Documento
(
   Utente_numero_utente   int(10)   not null,
   Documento_ID   integer   not null,
 
   constraint PK_Documento primary key (Documento_ID)
);
 
create table Passaporte
(
   Documento_Documento_ID   integer   not null,
   ID   int(10)   not null,
 
   constraint PK_Passaporte primary key (ID)
);
 
create table CC
(
   Documento_Documento_ID   integer   not null,
   ID   int(10)   not null,
 
   constraint PK_CC primary key (ID)
);
 
create table Exemplar
(
   Publicacao_ID_Publicacao   int(15)   not null,
   tag_RFID   int(10)   not null,
 
   constraint PK_Exemplar primary key (tag_RFID)
);
 
create table Livros_nao_emp
(
   Exemplar_tag_RFID   int(10)   not null,
 
   constraint PK_Livros_nao_emp primary key (Exemplar_tag_RFID)
);
 
create table Revistas_Emp
(
   Exemplar_tag_RFID   int(10)   not null,
 
   constraint PK_Revistas_Emp primary key (Exemplar_tag_RFID)
);
 
create table Extravio
(
   Emprestimo_ID_Emprestimo   int(10)   not null,
   Valor   int(10)   null,
   id_extravio   int(10)   not null,
 
   constraint PK_Extravio primary key (id_extravio)
);
 
create table Suspensao
(
   Utente_numero_utente   int(10)   not null,
   Suspensao_ID   integer   not null,
   data_ini   Date   null,
   data_fim   Date   null,
 
   constraint PK_Suspensao primary key (Suspensao_ID)
);
 
create table Armarios
(
   Area_ID_Area   int(20)   not null,
   Letra   char   not null,
   Piso   int(10)   not null,
   Nivel_de_ocupacao   int(5)   null,
 
   constraint PK_Armarios primary key (Letra, Piso)
);
 
create table Prateleiras
(
   Numero   int(10)   not null,
   Nivel_ocupacao   int(5)   null,
 
   constraint PK_Prateleiras primary key (Numero)
);
 
create table Novo
(
   Exemplar_tag_RFID   int(10)   not null,
 
   constraint PK_Novo primary key (Exemplar_tag_RFID)
);
 
create table Gasto
(
   Exemplar_tag_RFID   int(10)   not null,
 
   constraint PK_Gasto primary key (Exemplar_tag_RFID)
);
 
create table Extraviado
(
   Exemplar_tag_RFID   int(10)   not null,
 
   constraint PK_Extraviado primary key (Exemplar_tag_RFID)
);
 
create table Inutilizado
(
   Exemplar_tag_RFID   int(10)   not null,
 
   constraint PK_Inutilizado primary key (Exemplar_tag_RFID)
);
 
create table Lista_de_leitura
(
   Utente_numero_utente   int(10)   not null,
   Nome   varchar(50)   null,
   Criterio   varchar(50)   null,
   ID_Lista_Leitura   int(11)   not null,
 
   constraint PK_Lista_de_leitura primary key (ID_Lista_Leitura)
);
 
create table Relevancia
(
   Area_ID_Area   int(20)   not null,
   Relevancia_ID   integer   not null,
 
   constraint PK_Relevancia primary key (Relevancia_ID)
);
 
create table Mais_Consultados
(
   Area_ID_Area   int(20)   not null,
   Mais_Consultados_ID   integer   not null,
 
   constraint PK_Mais_Consultados primary key (Mais_Consultados_ID)
);
 
create table Recentes
(
   Area_ID_Area   int(20)   not null,
   Recentes_ID   integer   not null,
 
   constraint PK_Recentes primary key (Recentes_ID)
);
 
create table Feed
(
   Feed_ID   int(10)   not null,
 
   constraint PK_Feed primary key (Feed_ID)
);
 
create table Formulario
(
   Feed_Feed_ID   int(10)   not null,
 
   constraint PK_Formulario primary key (Feed_Feed_ID)
);
 
create table Importacao
(
   Feed_Feed_ID   int(10)   not null,
 
   constraint PK_Importacao primary key (Feed_Feed_ID)
);
 
create table Feed_editora
(
   Feed_Feed_ID   int(10)   not null,
   link   varchar(255)   null,
 
   constraint PK_Feed_editora primary key (Feed_Feed_ID)
);
 
create table Feed_periodico
(
   Feed_editora_Feed_Feed_ID   int(10)   not null,
   Periodicidade_Periodicidade_ID   integer   not null,
   Feed_periodico_ID   integer   not null,
   link_p   varchar(255)   null,
 
   constraint PK_Feed_periodico primary key (Feed_editora_Feed_Feed_ID, Feed_periodico_ID)
);
 
create table Periodicidade
(
   Periodicidade_ID   integer   not null,
 
   constraint PK_Periodicidade primary key (Periodicidade_ID)
);
 
create table SubArea
(
   Area_ID_Area   int(20)   not null,
   id_subarea   int(10)   not null,
 
   constraint PK_SubArea primary key (Area_ID_Area, id_subarea)
);
 
alter table PalavrasChaveDaPublicacao
   add constraint FK_Publicacao_PalavrasChaveDaPublicacao_PalavraChave_ foreign key (Publicacao_ID_Publicacao_)
   references Publicacao(ID_Publicacao)
   on delete cascade
   on update cascade
; 
alter table PalavrasChaveDaPublicacao
   add constraint FK_PalavraChave_PalavrasChaveDaPublicacao_Publicacao_ foreign key (PalavraChave_PalavraChave_ID_)
   references PalavraChave(PalavraChave_ID)
   on delete cascade
   on update cascade
;
 
alter table PalavrasChaveDoArtigo
   add constraint FK_PalavraChave_PalavrasChaveDoArtigo_Artigo_ foreign key (PalavraChave_PalavraChave_ID_)
   references PalavraChave(PalavraChave_ID)
   on delete cascade
   on update cascade
; 
alter table PalavrasChaveDoArtigo
   add constraint FK_Artigo_PalavrasChaveDoArtigo_PalavraChave_ foreign key (Artigo_Artigo_ID_)
   references Artigo(Artigo_ID)
   on delete cascade
   on update cascade
;
 
alter table PalavrasChaveDoCapitulo
   add constraint FK_PalavraChave_PalavrasChaveDoCapitulo_Capitulo_ foreign key (PalavraChave_PalavraChave_ID_)
   references PalavraChave(PalavraChave_ID)
   on delete cascade
   on update cascade
; 
alter table PalavrasChaveDoCapitulo
   add constraint FK_Capitulo_PalavrasChaveDoCapitulo_PalavraChave_ foreign key (Capitulo_Capitulo_ID_)
   references Capitulo(Capitulo_ID)
   on delete cascade
   on update cascade
;
 
alter table EmprestimoDoExemp
   add constraint FK_Emprestimo_EmprestimoDoExemp_Exemplar_ foreign key (Emprestimo_ID_Emprestimo_)
   references Emprestimo(ID_Emprestimo)
   on delete cascade
   on update cascade
; 
alter table EmprestimoDoExemp
   add constraint FK_Exemplar_EmprestimoDoExemp_Emprestimo_ foreign key (Exemplar_tag_RFID_)
   references Exemplar(tag_RFID)
   on delete cascade
   on update cascade
;
 
alter table PublicacoesDoFeed
   add constraint FK_Publicacao_PublicacoesDoFeed_Feed_ foreign key (Publicacao_ID_Publicacao_)
   references Publicacao(ID_Publicacao)
   on delete cascade
   on update cascade
; 
alter table PublicacoesDoFeed
   add constraint FK_Feed_PublicacoesDoFeed_Publicacao_ foreign key (Feed_Feed_ID_)
   references Feed(Feed_ID)
   on delete cascade
   on update cascade
;
 
alter table Publicacao
   add constraint FK_Publicacao_InfoPubli_Info foreign key (Info_Info_ID)
   references Info(Info_ID)
   on delete restrict
   on update cascade
; 
alter table Publicacao
   add constraint FK_Publicacao_PubliArea_SubArea foreign key (SubArea_Area_ID_Area, SubArea_id_subarea)
   references SubArea(Area_ID_Area, id_subarea)
   on delete restrict
   on update cascade
;
 
 
alter table Info
   add constraint FK_Info_InfoPubli_Publicacao foreign key (Publicacao_ID_Publicacao)
   references Publicacao(ID_Publicacao)
   on delete restrict
   on update cascade
;
 
alter table Livro
   add constraint FK_Livro_Publicacao foreign key (Publicacao_ID_Publicacao)
   references Publicacao(ID_Publicacao)
   on delete cascade
   on update cascade
;
 
alter table Periodico
   add constraint FK_Periodico_Publicacao foreign key (Publicacao_ID_Publicacao)
   references Publicacao(ID_Publicacao)
   on delete cascade
   on update cascade
; 
alter table Periodico
   add constraint FK_Periodico_PeriodoDoPeriodico_Periodicidade foreign key (Periodicidade_Periodicidade_ID)
   references Periodicidade(Periodicidade_ID)
   on delete set null
   on update cascade
;
 
alter table Monografia
   add constraint FK_Monografia_Publicacao foreign key (Publicacao_ID_Publicacao)
   references Publicacao(ID_Publicacao)
   on delete cascade
   on update cascade
;
 
alter table Revistas
   add constraint FK_Revistas_Periodico foreign key (Periodico_ISSN)
   references Periodico(ISSN)
   on delete cascade
   on update cascade
;
 
alter table Jornais
   add constraint FK_Jornais_Periodico foreign key (Periodico_ISSN)
   references Periodico(ISSN)
   on delete cascade
   on update cascade
;
 
alter table Mestrado
   add constraint FK_Mestrado_Tese foreign key (Tese_Monografia_Publicacao_ID_Publicacao)
   references Tese(Monografia_Publicacao_ID_Publicacao)
   on delete cascade
   on update cascade
;
 
alter table Doutoramento
   add constraint FK_Doutoramento_Tese foreign key (Tese_Monografia_Publicacao_ID_Publicacao)
   references Tese(Monografia_Publicacao_ID_Publicacao)
   on delete cascade
   on update cascade
;
 
alter table Tese
   add constraint FK_Tese_Monografia foreign key (Monografia_Publicacao_ID_Publicacao)
   references Monografia(Publicacao_ID_Publicacao)
   on delete cascade
   on update cascade
;
 
alter table RelatorioTecnico
   add constraint FK_RelatorioTecnico_Monografia foreign key (Monografia_Publicacao_ID_Publicacao)
   references Monografia(Publicacao_ID_Publicacao)
   on delete cascade
   on update cascade
;
 
alter table TextoPedagogico
   add constraint FK_TextoPedagogico_Monografia foreign key (Monografia_Publicacao_ID_Publicacao)
   references Monografia(Publicacao_ID_Publicacao)
   on delete cascade
   on update cascade
;
 
 
 
 
alter table Utente
   add constraint FK_Utente_UtenteEmpre_Emprestimo foreign key (Emprestimo_ID_Emprestimo)
   references Emprestimo(ID_Emprestimo)
   on delete restrict
   on update cascade
; 
alter table Utente
   add constraint FK_Utente_Doc_Documento foreign key (Documento_Documento_ID)
   references Documento(Documento_ID)
   on delete restrict
   on update cascade
; 
alter table Utente
   add constraint FK_Utente_Susp_Suspensao foreign key (Suspensao_Suspensao_ID)
   references Suspensao(Suspensao_ID)
   on delete restrict
   on update cascade
;
 
 
alter table Prolongamento
   add constraint FK_Prolongamento_Prolo_Emprestimo foreign key (Emprestimo_ID_Emprestimo)
   references Emprestimo(ID_Emprestimo)
   on delete restrict
   on update cascade
;
 
alter table Multa
   add constraint FK_Multa_InfoMulta_Emprestimo foreign key (Emprestimo_ID_Emprestimo)
   references Emprestimo(ID_Emprestimo)
   on delete restrict
   on update cascade
;
 
alter table Documento
   add constraint FK_Documento_Doc_Utente foreign key (Utente_numero_utente)
   references Utente(numero_utente)
   on delete restrict
   on update cascade
;
 
alter table Passaporte
   add constraint FK_Passaporte_Documento foreign key (Documento_Documento_ID)
   references Documento(Documento_ID)
   on delete cascade
   on update cascade
;
 
alter table CC
   add constraint FK_CC_Documento foreign key (Documento_Documento_ID)
   references Documento(Documento_ID)
   on delete cascade
   on update cascade
;
 
alter table Exemplar
   add constraint FK_Exemplar_ExePubli_Publicacao foreign key (Publicacao_ID_Publicacao)
   references Publicacao(ID_Publicacao)
   on delete restrict
   on update cascade
;
 
alter table Livros_nao_emp
   add constraint FK_Livros_nao_emp_Exemplar foreign key (Exemplar_tag_RFID)
   references Exemplar(tag_RFID)
   on delete cascade
   on update cascade
;
 
alter table Revistas_Emp
   add constraint FK_Revistas_Emp_Exemplar foreign key (Exemplar_tag_RFID)
   references Exemplar(tag_RFID)
   on delete cascade
   on update cascade
;
 
alter table Extravio
   add constraint FK_Extravio_Extra_Emprestimo foreign key (Emprestimo_ID_Emprestimo)
   references Emprestimo(ID_Emprestimo)
   on delete restrict
   on update cascade
;
 
alter table Suspensao
   add constraint FK_Suspensao_Susp_Utente foreign key (Utente_numero_utente)
   references Utente(numero_utente)
   on delete restrict
   on update cascade
;
 
alter table Armarios
   add constraint FK_Armarios_AreaDoArmario_Area foreign key (Area_ID_Area)
   references Area(ID_Area)
   on delete restrict
   on update cascade
;
 
 
alter table Novo
   add constraint FK_Novo_Exemplar foreign key (Exemplar_tag_RFID)
   references Exemplar(tag_RFID)
   on delete cascade
   on update cascade
;
 
alter table Gasto
   add constraint FK_Gasto_Exemplar foreign key (Exemplar_tag_RFID)
   references Exemplar(tag_RFID)
   on delete cascade
   on update cascade
;
 
alter table Extraviado
   add constraint FK_Extraviado_Exemplar foreign key (Exemplar_tag_RFID)
   references Exemplar(tag_RFID)
   on delete cascade
   on update cascade
;
 
alter table Inutilizado
   add constraint FK_Inutilizado_Exemplar foreign key (Exemplar_tag_RFID)
   references Exemplar(tag_RFID)
   on delete cascade
   on update cascade
;
 
alter table Lista_de_leitura
   add constraint FK_Lista_de_leitura_ListaLeitura_Utente foreign key (Utente_numero_utente)
   references Utente(numero_utente)
   on delete restrict
   on update cascade
;
 
alter table Relevancia
   add constraint FK_Relevancia_LivrosMaisRelevantes_Area foreign key (Area_ID_Area)
   references Area(ID_Area)
   on delete restrict
   on update cascade
;
 
alter table Mais_Consultados
   add constraint FK_Mais_Consultados_LivrosMaisConsultados_Area foreign key (Area_ID_Area)
   references Area(ID_Area)
   on delete restrict
   on update cascade
;
 
alter table Recentes
   add constraint FK_Recentes_LivrosMaisRecentes_Area foreign key (Area_ID_Area)
   references Area(ID_Area)
   on delete restrict
   on update cascade
;
 
 
alter table Formulario
   add constraint FK_Formulario_Feed foreign key (Feed_Feed_ID)
   references Feed(Feed_ID)
   on delete cascade
   on update cascade
;
 
alter table Importacao
   add constraint FK_Importacao_Feed foreign key (Feed_Feed_ID)
   references Feed(Feed_ID)
   on delete cascade
   on update cascade
;
 
alter table Feed_editora
   add constraint FK_Feed_editora_Feed foreign key (Feed_Feed_ID)
   references Feed(Feed_ID)
   on delete cascade
   on update cascade
;
 
alter table Feed_periodico
   add constraint FK_Feed_periodico_FeedEditora_Feed_editora foreign key (Feed_editora_Feed_Feed_ID)
   references Feed_editora(Feed_Feed_ID)
   on delete cascade
   on update cascade
; 
alter table Feed_periodico
   add constraint FK_Feed_periodico_PeriodicidadeDoFeed_Periodicidade foreign key (Periodicidade_Periodicidade_ID)
   references Periodicidade(Periodicidade_ID)
   on delete restrict
   on update cascade
;
 
 
alter table SubArea
   add constraint FK_SubArea_SubArea_Area foreign key (Area_ID_Area)
   references Area(ID_Area)
   on delete cascade
   on update cascade
;
 
