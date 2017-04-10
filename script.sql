USE [Alicorp]
GO
/****** Object:  Schema [common]    Script Date: 10/04/2017 01:59:35 p.m. ******/
CREATE SCHEMA [common]
GO
/****** Object:  Schema [Desvinculaciones]    Script Date: 10/04/2017 01:59:35 p.m. ******/
CREATE SCHEMA [Desvinculaciones]
GO
/****** Object:  Schema [ods]    Script Date: 10/04/2017 01:59:35 p.m. ******/
CREATE SCHEMA [ods]
GO
/****** Object:  Schema [seleccion]    Script Date: 10/04/2017 01:59:35 p.m. ******/
CREATE SCHEMA [seleccion]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSISTENCIA_DE_DATOS]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSISTENCIA_DE_DATOS] (@rutaDestino nvarchar(100) = "D:\Users\SOrdayaL\Documents\Reporte de posiciones\", @rutaPosicion nvarchar(100) = "P:\22. Gestión de Información\Maestros\",
												  @archPosicion nvarchar(100) = "UD_MAEPOSICION.xlsx", @archTemplate nvarchar(100) = "Template_posiciones.xlsx", 
												  @rutaTemplate nvarchar(100) = "D:\Users\SOrdayaL\Documents\Pruebas Data Tools\")
AS
BEGIN
	DECLARE @executionID bigint
	EXEC  SSISDB.catalog.create_execution 'Reporte de consistencia de datos', 'Reporte de cambios en posicion', 'Package.dtsx', NULL, 1, @executionID out


	EXEC SSISDB.catalog.set_execution_parameter_value @executionID, 30, 'RutaDestino', @rutaDestino
	EXEC SSISDB.catalog.set_execution_parameter_value @executionID, 30, 'RutaPosicion', @rutaPosicion
	EXEC SSISDB.catalog.set_execution_parameter_value @executionID, 30, 'ArchPosicion', @archPosicion
	EXEC SSISDB.catalog.set_execution_parameter_value @executionID, 30, 'ArchTemplate', @archTemplate 
	EXEC SSISDB.catalog.set_execution_parameter_value @executionID, 30, 'RutaTemplate', @rutaTemplate

	EXEC SSISDB.catalog.start_execution @executionID
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_EXPATRIADOS_Y_NO_RELEV_P_NOMINA]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_EXPATRIADOS_Y_NO_RELEV_P_NOMINA]

AS
BEGIN
	------- EXPATRIADOS -------

	-- Oscar Lezama
	UPDATE ODS.HM_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '14804' and codsociedad = 101 AND CODMES >= 201701 

	-- Rubén Ferro
	UPDATE ODS.HM_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '17799' and codsociedad = 101 AND CODMES >= 201702 

	-- Hernan Gonzalez-Polar
	UPDATE ODS.HM_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '16161' and codsociedad = 101 AND CODMES >= 201604 

	-- Fabricio Vargas
	UPDATE ODS.HM_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '1300241' and codsociedad in (737, 752) AND CODMES >= 201401 

	-- Cesar Zamudio
	UPDATE ODS.HM_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '1300255' and codsociedad in (737, 752) AND CODMES >= 201201 

	-- Carlos Ching
	UPDATE ODS.HM_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '1300046' and codsociedad in (737, 752) AND CODMES >= 201603 

	-- Carlos Quispe
	UPDATE ODS.HM_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '11646' and codsociedad = 101 AND CODMES >= 201701 

	-- Gabriel Seracchioli
	UPDATE ODS.HM_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '20079' and codsociedad = 120 AND CODMES >= 201604 

    ------AREA DE NOMINA NO RELEVANTE-------------------------------

	UPDATE ODS.HM_PERSONAL
	SET FLGACTIVO = 'N',flgCese = 'N',MotivoRenuncia = NULL, SubMotivoRenuncia = NULL
	WHERE codANomina = '99' AND
	codSociedad IN (736,738,101,752,737)

	-------------------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[SP_EXPATRIADOS_Y_NO_RELEV_P_NOMINA_MD_PERSONAL]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_EXPATRIADOS_Y_NO_RELEV_P_NOMINA_MD_PERSONAL]

AS
BEGIN
	------- EXPATRIADOS -------

	-- Oscar Lezama
	UPDATE ODS.MD_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '14804' and codsociedad = 101 AND GETDATE() >= '01/01/2017' 

	-- Rubén Ferro
	UPDATE ODS.MD_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '17799' and codsociedad = 101 AND GETDATE() >= '02/01/2017' 

	-- Hernan Gonzalez-Polar
	UPDATE ODS.MD_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '16161' and codsociedad = 101 AND GETDATE() >= '04/01/2016' 

	-- Fabricio Vargas
	UPDATE ODS.MD_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '1300241' and codsociedad in (737, 752) AND GETDATE() >= '01/01/2014' 

	-- Cesar Zamudio
	UPDATE ODS.MD_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '1300255' and codsociedad in (737, 752) AND GETDATE() >= '01/01/2012' 

	-- Carlos Ching
	UPDATE ODS.MD_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '1300046' and codsociedad in (737, 752) AND GETDATE() >= '03/01/2016' 

	-- Carlos Quispe
	UPDATE ODS.MD_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '11646' and codsociedad = 101 AND GETDATE() >= '01/01/2017' 

	-- Gabriel Seracchioli
	UPDATE ODS.MD_PERSONAL SET flgactivo = 'N'
	WHERE codEmpleado = '20079' and codsociedad = 120 AND GETDATE() >= '04/01/2016' 

	------AREA DE NOMINA NO RELEVANTE-------------------------------

	UPDATE ODS.MD_PERSONAL
	SET FLGACTIVO = 'N', MotivoRenuncia = NULL, SubMotivoRenuncia = NULL
	WHERE codANomina = '99' AND
	codSociedad IN (736,738,101,752,737)

	-------------------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_HM_ARG]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_HM_ARG]
AS
BEGIN

DECLARE @CODMES INT
SELECT @CODMES = (SELECT MAX(CODMES) FROM ODS.UM_ARG_BASICOS)

DELETE FROM ODS.UM_ARG_BASICOS
WHERE dbo.FN_TOCODMES(EGRESO) <> @CODMES
AND EGRESO IS NOT NULL

DELETE FROM ODS.UM_ARG_BASICOS
WHERE dbo.FN_TOCODMES(INGRESO) > @CODMES

DELETE FROM ODS.UM_ARG_ORGANIZACION
WHERE dbo.FN_TOCODMES(FECHA) > @CODMES
select distinct codvp,desvp from ods.MD_PERSONAL

UPDATE ODS.UM_ARG_ORGANIZACION
SET FECHA = convert(datetime,CONVERT(varchar,codmes)+'01',104)
WHERE FECHA IS NULL

DELETE FROM ODS.UM_PERSONAL

INSERT INTO ODS.UM_PERSONAL
SELECT
B.CODMES,
B.Legajo,
RTRIM(B.Nombres),
RTRIM(B.Apellido),
RTRIM(B.Empresa),
RTRIM(B.Empresa),
RTRIM(O.Personal),
RTRIM(O.[Personal Desc]),
RTRIM(B.[Posic#SAP]),
RTRIM(O.[Puesto Desc]),
RTRIM(O.[C#Costo]),
RTRIM(O.[C#Costo Desc]),
RTRIM(O.Personal),
RTRIM(O.[Personal Desc]),
RTRIM(B.[     Modalidad Contratac#               ]),
RTRIM(O.Puesto),
RTRIM(O.[Puesto Desc]),
NULL,
N.[Niv#Organiz(larga)],
'10000623',
'V.P. CONSUMO MASIVO INTERNACIONAL',
RTRIM(O.A#Neg),
RTRIM(O.[Area Neg#Descrip         ]),
RTRIM(O.Depto),
RTRIM(O.[Depto Descrip#                ]),
RTRIM(O.[Planta    ]),
RTRIM(O.[Planta Desc                             ]),
RTRIM(O.[Planta    ]),
RTRIM(O.[Planta Desc                             ]),
RTRIM(O.[Planta    ]),
RTRIM(O.[Planta Desc                             ]),
NULL,
NULL,
RTRIM(J.[Jefe        ]),
RTRIM(J.[Apellido y Nombres                               ]),
'N.D.',
B.[Número   ],
'N.D',
RTRIM(B.[     Nacionalid]),
RTRIM(B.[     Nacionalid]),
RTRIM(B.[  Sexo ]),
RTRIM(B.[   Estado Civil   ]),
CONVERT(DATETIME,B.Nacimiento),
CONVERT(DATETIME,B.Ingreso),
CONVERT(DATETIME,B.Egreso),
CONVERT(DATETIME,B.Egreso),
CONVERT(DATETIME,B.Ingreso),
RTRIM(B.[   Tipo Egreso              ]),
RTRIM(B.[    Motivo Egreso       ]),
'N',
'S',
'N',
NULL,
NULL,
NULL,
J.[Correo                                                      ],
NULL,
NULL,
GETDATE()
FROM ODS.UM_ARG_BASICOS B
LEFT JOIN (
		    SELECT O.Legajo,O.Personal,O.[Personal Desc],O.Puesto,O.[Puesto Desc],O.[C#Costo],O.[C#Costo Desc],
			 O.[A#Neg],O.[Area Neg#Descrip         ],O.Depto,O.[Depto Descrip#                ],O.[Planta    ],O.[Planta Desc                             ]
			 FROM  ODS.UM_ARG_ORGANIZACION O
		   INNER JOIN (SELECT LEGAJO,MAX(FECHA) FECHA FROM ODS.UM_ARG_ORGANIZACION GROUP BY LEGAJO) O2
			ON  O2.LEGAJO = O.LEGAJO AND O2.FECHA = O.FECHA						
			) O ON B.LEGAJO = O.LEGAJO
LEFT JOIN ODS.UM_ARG_NIVELES N ON N.[N° Pers#] = B.[Legajo      ]
LEFT JOIN (
			SELECT DISTINCT J2.[Legajo      ],J2.[Jefe        ],J2.[Apellido y Nombres                               ],J2.[Correo                                                      ]
			 FROM ODS.UM_ARG_JEFES J2 			
		   ) J ON J.[Legajo      ] = B.[Legajo      ]

--UPDATE ODS.UM_PERSONAL 
--SET FLGACTIVO = 'N'
--WHERE FECBAJA  < EOMONTH(convert(datetime,CONVERT(varchar,CODMES)+'01',104))
--AND FECBAJA IS NOT NULL

--UPDATE ODS.UM_PERSONAL 
--SET FLGCESE = 'S'
--WHERE dbo.FN_TOCODMES(FECBAJA) = CODMES
--AND FECBAJA IS NOT NULL

DELETE FROM ODS.HM_ARG_PERSONAL
WHERE CODMES = @CODMES

INSERT INTO ODS.HM_ARG_PERSONAL
SELECT U.* FROM ODS.UM_PERSONAL U


END




GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_HM_GLOBAL]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_HM_GLOBAL]
AS
BEGIN

UPDATE ODS.HM_GLO_PERSONAL 
SET codempleado = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(codempleado,'S/N','0'),'-',''),'E','1'),'P','2')))

UPDATE ODS.HM_GLO_PERSONAL 
SET CODJEFE = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(CODJEFE,'S/N','0'),'-',''),'E','1'),'P','2')))

-----------------------------------------------------------------------------------------------------------------------
--VALIDAR LOS VALORES DE AREA DE PERSONAL Y MOTIVO DE RENUNCIA PARA QUE SEAN LOS MISMOS QUE SE USAN EN LAS OTRAS AREAS
--Y OTRAS SOCIEDADES DE ALICORP
-----------------------------------------------------------------------------------------------------------------------

DELETE FROM ODS.HM_PERSONAL 
WHERE CODSOCIEDAD = '199'


INSERT INTO ODS.HM_PERSONAL
SELECT
UD1.CODMES,
UD1.CODEMPLEADO codEmpleado,
ISNULL(UD1.ApellidosyNombres,'') nombres,
' ' ,
'199' AS codSociedad,
'GLOBAL' desSociedad,
NULL codAreaPersonal,
RTRIM(LTRIM(UD1.desAreaPersonal)) desAreaPersonal,
NULL codPosicion,
RTRIM(LTRIM(UD1.DesPosicion)) desPosicion,
RTRIM(LTRIM(UD1.codCECO)) codCECO,
RTRIM(LTRIM(UD1.desCECO)) desCECO,
NULL codANomina,
RTRIM(LTRIM(UD1.desAreaPersonal)) desANomina,
CASE UD1.desAreaPersonal 
WHEN 'EMPLEADO CONTRATADO' THEN 'limitado'
WHEN 'EMPLEADO ESTABLE' THEN 'Ilimitado'
WHEN 'OBRERO CONTRATADO' THEN 'limitado'
WHEN 'OBRERO ESTABLE' THEN 'Ilimitado'
WHEN 'PRACTICANTE' THEN 'Modalidad formativa'
END  clasecontrato,
NULL codFuncion,
NULL desFuncion,
NULL desNivelOrg,
NULL desSubNivelOrg,
NULL codVP,
'V.P. CONSUMO MASIVO PERU' desVP,
'00001' codDireGer,
'Gerencia General Global' desDireGer,
NULL codUO,
RTRIM(LTRIM(UD1.DESAREA)) desUO,
NULL codSubDivision,
NULL desSubDivision,
NULL codEdificio,
RTRIM(LTRIM(UD1.DESLUGARTRABAJO)) desEdificio,
NULL codOficina,
'Global Perú' desOficina,
'PERÚ',
'Global Perú',
RTRIM(LTRIM(UD1.CODJEFE)) codjefe,
NULL desJefe,
NULL,
NULL,
NULL,
NULL,
Ud1.NACIONALIDADD desnacionalidad,
Ud1.SEXO,
Ud1.ESTADOCIVIL,
Ud1.FECNACIMIENTO,
convert(datetime,UD1.FECINGRESO,104) fecingplanilla,
convert(datetime,UD1.FECBAJA,104) fecbaja,
convert(datetime,UD1.FECBAJA,104) fecFinContrato,
convert(datetime,UD1.FECINGRESO,104) fecinggrupo,
RTRIM(LTRIM(UD1.DESMOTIVOCESE)) MotivoRenuncia,
RTRIM(LTRIM(UD1.DESMOTIVOCESE)) MotivoRenuncia,
'N',
'S',
'N',
NULL,
NULL,
NULL,
RTRIM(LTRIM(UD1.email)) emaill,
RTRIM(LTRIM(UD1.[anexo])) anexo,
NULL,
GETDATE()
FROM  ODS.HM_GLO_PERSONAL UD1

END;


GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_HM_PERSONAL]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_HM_PERSONAL]
AS
BEGIN

DELETE FROM ODS.UM_PERSONAL

UPDATE ODS.UM_MAEPERSONAL 
SET [Nombre de pila trabajador] = [Nombre trabajador] WHERE ([Nombre de pila trabajador] IS NULL OR RTRIM(LTRIM([Nombre de pila trabajador]))='')

INSERT INTO ODS.UM_PERSONAL
SELECT
UD1.CODMES,
UD1.[N° Pers#] codEmpleado,
RTRIM(LTRIM(UD1.[Nombre trabajador])) nombres,
RTRIM(LTRIM(UD1.[Apellido paterno trabajador])) + ' ' + RTRIM(LTRIM(UD1.[Apellido materno trabajador])) apellidos,
RTRIM(LTRIM(UD1.[Soc#])) AS codSociedad,
RTRIM(LTRIM(UD1.[División de personal])) desSociedad,
RTRIM(LTRIM(UD1.[Area Pers#])) codAreaPersonal,
RTRIM(LTRIM(UD1.[Área de personal])) desAreaPersonal,
RTRIM(LTRIM(UD1.[Posición])) codPosicion,
RTRIM(LTRIM(UD1.[Descripción Posición])) desPosicion,
RTRIM(LTRIM(UD1.[Ce#Coste])) codCECO,
RTRIM(LTRIM(UD1.[Centro de coste])) desCECO,
RTRIM(LTRIM(UD1.[ANom#])) codANomina,
RTRIM(LTRIM(UD1.[Área de nómina])) desANomina,
RTRIM(LTRIM(UD1.[Clase Contrato])) clasecontrato,
RTRIM(LTRIM(UD1.[Cod#Func])) codFuncion,
RTRIM(LTRIM(UD1.[Función])) desFuncion,
RTRIM(LTRIM(UD1.[Niv#Organiz(corta)])) desNivelOrg,
RTRIM(LTRIM(UD1.[Niv#Organiz(larga)])) desSubNivelOrg,
RTRIM(LTRIM(UD1.[Vice#ALI])) codVP,
RTRIM(LTRIM(UD1.[Vice#ALI(larga)])) desVP,
RTRIM(LTRIM(UD1.[Dir/Ger#])) codDireGer,
RTRIM(LTRIM(UD1.[Dir/Ger#(larga)])) desDireGer,
RTRIM(LTRIM(UD1.[Unid#Org#])) codUO,
RTRIM(LTRIM(UD1.[Unidad organizativa])) desUO,
RTRIM(LTRIM(UD1.[Sub#Div#])) codSubDivision,
RTRIM(LTRIM(UD1.[Subdivisión de personal])) desSubDivision,
RTRIM(LTRIM(UD1.[Cód# Edificio])) codEdificio,
RTRIM(LTRIM(UD1.[Edificio])) desEdificio,
RTRIM(LTRIM(UD1.[Cod# Oficina])) codOficina,
RTRIM(LTRIM(UD1.[Oficina])) desOficina,
NULL,
NULL,
RTRIM(LTRIM(UD1.[Cod#Jefe])) codjefe,
RTRIM(LTRIM(UD1.[Nombre Jefe])) desJefe,
RTRIM(LTRIM(UD1.[Días Lab#Sem#])) horario,
RTRIM(LTRIM(UD1.[DNI])) dni,
RTRIM(LTRIM(UD1.[Carné Extranjería])) cExtranjeria,
RTRIM(LTRIM(UD1.[País nacimiento])) paisnacimiento,
RTRIM(LTRIM(UD1.[Nacionalidad])) desnacionalidad,
RTRIM(LTRIM(UD1.[Sexo])),
RTRIM(LTRIM(UD1.Est#Civil)) desestadocivil,
convert(datetime,UD1.[Fec#Nac#],104) fecnacimiento,
convert(datetime,UD1.FI#Planilla,104) fecingplanilla,
convert(datetime,UD1.Fec#Baja,104) fecbaja,
convert(datetime,UD1.[Fin Cont#],104) fecFinContrato,
convert(datetime,UD1.FI#Grupo,104) fecinggrupo,
NULL MotivoRenuncia,
RTRIM(LTRIM(UD1.[Submotivo medida Cont#])) SubMotivoRenuncia,
'N',
'S',
'N',
RTRIM(LTRIM(UD1.[Cód# SSFF])) codDestaca,
RTRIM(LTRIM(UD1.[JOBCODE(corta)])) JobCode,
RTRIM(LTRIM(UD1.[Número MOVISTAR])) numRPM,
RTRIM(LTRIM(UD1.[e-mail])) emaill,
RTRIM(LTRIM(UD1.[anexo])) anexo,
RTRIM(LTRIM(UD1.[Usuario de RED])) codUsuarioRed,
GETDATE()
FROM  ODS.UM_MAEPERSONAL UD1
WHERE UD1.[Soc#] IN ('101','103','105','106','107','108','737','164','112','110','738','703','752','736','730','731') 
 AND UD1.[Area Pers#] NOT IN ('J1','H1','D1')


DECLARE @CODMES INT
SELECT @CODMES = (SELECT MAX(CODMES) FROM ODS.UM_PERSONAL)

DELETE FROM ODS.HM_PERSONAL
WHERE CODMES = @CODMES

INSERT INTO ODS.HM_PERSONAL
SELECT U.* FROM ODS.UM_PERSONAL U


---- ARGENTINA


---- INICIO UPDATE HM ARGENTINA

UPDATE ods.HM_ARG_PERSONAL
SET codAreaPersonal = (SELECT DISTINCT codAreaPersonal FROM ODS.HM_ARG_PERSONAL P WHERE P.CodEmpleado = ODS.HM_ARG_PERSONAL.codEmpleado AND P.codAreaPersonal IS NOT NULL),
	desAreaPersonal = (SELECT DISTINCT desAreaPersonal FROM ODS.HM_ARG_PERSONAL P WHERE P.CodEmpleado = ODS.HM_ARG_PERSONAL.codEmpleado AND P.desAreaPersonal IS NOT NULL)
WHERE (codAreaPersonal IS NULL OR desAreaPersonal IS NULL)

UPDATE ods.HM_ARG_PERSONAL
SET codANomina = codAreaPersonal,
	desANomina =  desAreaPersonal 
WHERE (codANomina IS NULL OR desANomina IS NULL)


DELETE FROM ODS.HM_PERSONAL
WHERE codSociedad IN (SELECT distinct codSociedad From ODS.HM_ARG_PERSONAL)

INSERT INTO ODS.HM_PERSONAL
SELECT * FROM ODS.HM_ARG_PERSONAL

---- FIN UPDATE HM ARGENTINA

------ GLOBAL
EXEC SP_INSERT_HM_GLOBAL

END
--- FIN UPDATE ---



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_MD_ARG]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_MD_ARG]
AS
BEGIN

DELETE FROM ODS.MD_ARG_BASICOS
WHERE (EGRESO) <> dbo.FN_TOCODMES(GETDATE()) 
AND EGRESO IS NOT NULL

DELETE FROM ODS.MD_ARG_BASICOS
WHERE dbo.FN_TOCODMES(INGRESO) > dbo.FN_TOCODMES(GETDATE()) 

DELETE FROM ODS.MD_ARG_ORGANIZACION
WHERE dbo.FN_TOCODMES(FECHA) > dbo.FN_TOCODMES(GETDATE()) 


UPDATE ODS.MD_ARG_ORGANIZACION
SET FECHA = CONVERT(DATETIME,CONVERT(varchar,dbo.FN_TOCODMES(GETDATE()) )+'01',104)
WHERE FECHA IS NULL


DELETE FROM ODS.MD_ARG_PERSONAL

INSERT INTO ODS.MD_ARG_PERSONAL
SELECT
B.Legajo,
RTRIM(B.Nombres),
RTRIM(B.Apellido),
RTRIM(B.Empresa),
RTRIM(B.Empresa),
RTRIM(O.Personal),
RTRIM(O.[Personal Desc]),
RTRIM(B.[Posic#SAP]),
RTRIM(O.[Puesto Desc]),
RTRIM(O.[C#Costo]),
RTRIM(O.[C#Costo Desc]),
RTRIM(O.Personal),
RTRIM(O.[Personal Desc]),
RTRIM(B.[     Modalidad Contratac#               ]),
RTRIM(O.Puesto),
RTRIM(O.[Puesto Desc]),
NULL,
N.[Niv#Organiz(larga)],
'10000623',
'V.P. CONSUMO MASIVO INTERNACIONAL',
RTRIM(O.A#Neg),
RTRIM(O.[Area Neg#Descrip         ]),
RTRIM(O.Depto),
RTRIM(O.[Depto Descrip#                ]),
RTRIM(O.[Planta    ]),
RTRIM(O.[Planta Desc                             ]),
RTRIM(O.[Planta    ]),
RTRIM(O.[Planta Desc                             ]),
RTRIM(O.[Planta    ]),
RTRIM(O.[Planta Desc                             ]),
NULL,
NULL,
RTRIM(J.[Jefe        ]),
RTRIM(J.[Apellido y Nombres                               ]),
'N.D.',
B.[Número   ],
'N.D',
RTRIM(B.[     Nacionalid]),
RTRIM(B.[     Nacionalid]),
RTRIM(B.[  Sexo ]),
RTRIM(B.[   Estado Civil   ]),
CONVERT(DATETIME,B.Nacimiento),
CONVERT(DATETIME,B.Ingreso),
CONVERT(DATETIME,B.Egreso),
CONVERT(DATETIME,B.Egreso),
CONVERT(DATETIME,B.Ingreso),
RTRIM(B.[   Tipo Egreso              ]),
RTRIM(B.[    Motivo Egreso       ]),
'S',
'N',
NULL,
NULL,
NULL,
J.[Correo                                                      ],
NULL,
NULL,
GETDATE()
FROM ODS.MD_ARG_BASICOS B
LEFT JOIN (
		    SELECT O.Legajo,O.Personal,O.[Personal Desc],O.Puesto,O.[Puesto Desc],O.[C#Costo],O.[C#Costo Desc],
			 O.[A#Neg],O.[Area Neg#Descrip         ],O.Depto,O.[Depto Descrip#                ],O.[Planta    ],O.[Planta Desc                             ]
			 FROM  ODS.MD_ARG_ORGANIZACION O
		   INNER JOIN (SELECT LEGAJO,MAX(FECHA) FECHA FROM ODS.MD_ARG_ORGANIZACION GROUP BY LEGAJO) O2
			ON  O2.LEGAJO = O.LEGAJO AND O2.FECHA = O.FECHA						
			) O ON B.LEGAJO = O.LEGAJO
LEFT JOIN ODS.MD_ARG_NIVELES N ON N.[N° Pers#] = B.[Legajo      ]
LEFT JOIN (
			SELECT DISTINCT J2.[Legajo      ],J2.[Jefe        ],J2.[Apellido y Nombres                               ],J2.[Correo                                                      ]
			 FROM ODS.MD_ARG_JEFES J2 			
		   ) J ON J.[Legajo      ] = B.[Legajo      ]


END




GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_MD_GLOBAL]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_MD_GLOBAL]
AS
BEGIN

DELETE FROM ODS.MD_PERSONAL
WHERE CODSOCIEDAD = '199'


INSERT INTO ODS.MD_PERSONAL
SELECT
UD1.CODEMPLEADO codEmpleado,
ISNULL(UD1.ApellidosyNombres,'') nombres,
' ' ,
'199' AS codSociedad,
'GLOBAL' desSociedad,
NULL codAreaPersonal,
RTRIM(LTRIM(UD1.desAreaPersonal)) desAreaPersonal,
NULL codPosicion,
RTRIM(LTRIM(UD1.DesPosicion)) desPosicion,
RTRIM(LTRIM(UD1.codCECO)) codCECO,
RTRIM(LTRIM(UD1.desCECO)) desCECO,
NULL codANomina,
RTRIM(LTRIM(UD1.desAreaPersonal)) desANomina,
CASE UD1.desAreaPersonal 
WHEN 'EMPLEADO CONTRATADO' THEN 'limitado'
WHEN 'EMPLEADO ESTABLE' THEN 'Ilimitado'
WHEN 'OBRERO CONTRATADO' THEN 'limitado'
WHEN 'OBRERO ESTABLE' THEN 'Ilimitado'
WHEN 'PRACTICANTE' THEN 'Modalidad formativa'
END  clasecontrato,
NULL codFuncion,
NULL desFuncion,
NULL desNivelOrg,
NULL desSubNivelOrg,
NULL codVP,
'V.P. CONSUMO MASIVO PERU' desVP,
'00001' codDireGer,
'Gerencia General Global' desDireGer,
NULL codUO,
RTRIM(LTRIM(UD1.DESAREA)) desUO,
NULL codSubDivision,
NULL desSubDivision,
NULL codEdificio,
RTRIM(LTRIM(UD1.DESLUGARTRABAJO)) desEdificio,
NULL codOficina,
'Global Perú' desOficina,
'PERÚ',
'Global Perú',
RTRIM(LTRIM(UD1.CODJEFE)) codjefe,
NULL desJefe,
NULL,
NULL,
NULL,
NULL,
Ud1.NACIONALIDADD desnacionalidad,
Ud1.SEXO,
Ud1.ESTADOCIVIL,
Ud1.FECNACIMIENTO,
convert(datetime,UD1.FECINGRESO,104) fecingplanilla,
convert(datetime,UD1.FECBAJA,104) fecbaja,
convert(datetime,UD1.FECBAJA,104) fecFinContrato,
convert(datetime,UD1.FECINGRESO,104) fecinggrupo,
RTRIM(LTRIM(UD1.DESMOTIVOCESE)) MotivoRenuncia,
RTRIM(LTRIM(UD1.DESMOTIVOCESE)) MotivoRenuncia,
'S',
'N',
NULL,
NULL,
NULL,
RTRIM(LTRIM(UD1.email)) emaill,
RTRIM(LTRIM(UD1.[anexo])) anexo,
NULL,
GETDATE()
FROM  ODS.HM_GLO_PERSONAL UD1
WHERE UD1.CODMES = (SELECT MAX(CODMES) FROM ODS.HM_GLO_PERSONAL)
END;


GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_MD_PERSONAL]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [SP_INSERT_MD_PERSONAL]
CREATE PROCEDURE [dbo].[SP_INSERT_MD_PERSONAL]
AS
BEGIN

UPDATE ODS.UD_MAEPERSONAL 
SET [Nombre de pila trabajador] = [Nombre trabajador] WHERE ([Nombre de pila trabajador] IS NULL OR RTRIM(LTRIM([Nombre de pila trabajador]))='')

TRUNCATE TABLE ODS.MD_PERSONAL

INSERT INTO ODS.MD_PERSONAL
SELECT
UD1.[N° Pers#] codEmpleado,
RTRIM(LTRIM(UD1.[Nombre trabajador])) nombres,
RTRIM(LTRIM(UD1.[Apellido paterno trabajador])) + ' ' + RTRIM(LTRIM(UD1.[Apellido materno trabajador])) apellidos,
RTRIM(LTRIM(UD1.[Soc#])) AS codSociedad,
ISNULL(RTRIM(LTRIM(UD1.[División de personal])),'N.D.') desSociedad,
RTRIM(LTRIM(UD1.[Area Pers#])) codAreaPersonal,
RTRIM(LTRIM(UD1.[Área de personal])) desAreaPersonal,
RTRIM(LTRIM(UD1.[Posición])) codPosicion,
RTRIM(LTRIM(UD1.[Descripción Posición])) desPosicion,
RTRIM(LTRIM(UD1.[Ce#Coste])) codCECO,
RTRIM(LTRIM(UD1.[Centro de coste])) desCECO,
RTRIM(LTRIM(UD1.[ANom#])) codANomina,
RTRIM(LTRIM(UD1.[Área de nómina])) desANomina,
RTRIM(LTRIM(UD1.[Clase Contrato])) clasecontrato,
RTRIM(LTRIM(UD1.[Cod#Func])) codFuncion,
RTRIM(LTRIM(UD1.[Función])) desFuncion,
RTRIM(LTRIM(UD1.[Niv#Organiz(corta)])) desNivelOrg,
RTRIM(LTRIM(UD1.[Niv#Organiz(larga)])) desSubNivelOrg,
RTRIM(LTRIM(UD1.[Vice#ALI])) codVP,
RTRIM(LTRIM(UD1.[Vice#ALI(larga)])) desVP,
RTRIM(LTRIM(UD1.[Dir/Ger#])) codDireGer,
RTRIM(LTRIM(UD1.[Dir/Ger#(larga)])) desDireGer,
RTRIM(LTRIM(UD1.[Unid#Org#])) codUO,
RTRIM(LTRIM(UD1.[Unidad organizativa])) desUO,
RTRIM(LTRIM(UD1.[Sub#Div#])) codSubDivision,
RTRIM(LTRIM(UD1.[Subdivisión de personal])) desSubDivision,
RTRIM(LTRIM(UD1.[Cód# Edificio])) codEdificio,
RTRIM(LTRIM(UD1.[Edificio])) desEdificio,
RTRIM(LTRIM(UD1.[Cod# Oficina])) codOficina,
RTRIM(LTRIM(UD1.[Oficina])) desOficina,
NULL,
NULL,
RTRIM(LTRIM(UD1.[Cod#Jefe])) codjefe,
RTRIM(LTRIM(UD1.[Nombre Jefe])) desJefe,
RTRIM(LTRIM(UD1.[Días Lab#Sem#])) horario,
RTRIM(LTRIM(UD1.[DNI])) dni,
RTRIM(LTRIM(UD1.[Carné Extranjería])) cExtranjeria,
RTRIM(LTRIM(UD1.[País nacimiento])) paisnacimiento,
RTRIM(LTRIM(UD1.[Nacionalidad])) desnacionalidad,
RTRIM(LTRIM(UD1.[Sexo])),
RTRIM(LTRIM(UD1.Est#Civil)) desestadocivil,
convert(datetime,UD1.[Fec#Nac#],104) fecnacimiento,
convert(datetime,UD1.FI#Planilla,104) fecingplanilla,
convert(datetime,UD1.Fec#Baja,104) fecbaja,
convert(datetime,UD1.[Fin Cont#],104) FinContrato,
convert(datetime,UD1.FI#Grupo,104) fecinggrupo,
NULL MotivoRenuncia,
RTRIM(LTRIM(UD1.[Submotivo medida Cont#])) SubMotivoRenuncia,
'S',
'N',
RTRIM(LTRIM(UD1.[Cód# SSFF])) codDestaca,
RTRIM(LTRIM(UD1.[JOBCODE(corta)])) JobCode,
RTRIM(LTRIM(UD1.[Número MOVISTAR])) numRPM,
RTRIM(LTRIM(UD1.[e-mail])) emaill,
RTRIM(LTRIM(UD1.[anexo])) anexo,
RTRIM(LTRIM(UD1.[Usuario de RED])) codUsuarioRed,
GETDATE()
FROM  ODS.UD_MAEPERSONAL UD1
WHERE UD1.[Soc#] IN ('101','103','105','106','107','108','737','164','112','110','738','703','752','736','730','731') 
 AND UD1.[Area Pers#] NOT IN ('J1','H1','D1')

-- ARGENTINA
EXEC SP_INSERT_MD_ARG

UPDATE ods.MD_ARG_PERSONAL
SET codAreaPersonal = (SELECT DISTINCT codAreaPersonal FROM ODS.HM_ARG_PERSONAL P WHERE P.CodEmpleado = ODS.MD_ARG_PERSONAL.codEmpleado AND P.codAreaPersonal IS NOT NULL),
	desAreaPersonal = (SELECT DISTINCT desAreaPersonal FROM ODS.HM_ARG_PERSONAL P WHERE P.CodEmpleado = ODS.MD_ARG_PERSONAL.codEmpleado AND P.desAreaPersonal IS NOT NULL)
WHERE (codAreaPersonal IS NULL OR desAreaPersonal IS NULL)

UPDATE ods.MD_ARG_PERSONAL
SET codANomina = codAreaPersonal,
	desANomina =  desAreaPersonal 
WHERE (codANomina IS NULL OR desANomina IS NULL)


DELETE FROM ODS.MD_PERSONAL
WHERE codSociedad IN (SELECT distinct codSociedad From ODS.MD_ARG_PERSONAL)

INSERT INTO ODS.MD_PERSONAL
SELECT * FROM ODS.MD_ARG_PERSONAL

-- GLOBAL
EXEC SP_INSERT_MD_GLOBAL

UPDATE ODS.MD_PERSONAL 
SET FLGACTIVO = 'N' 
WHERE (FECINGPLANILLA > GETDATE())
	OR
	 (datediff(day,fecbaja,getdate())>0)

END;



GO
/****** Object:  StoredProcedure [dbo].[SP_JERARQUIA]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_JERARQUIA] (@codpersona int) 
AS
BEGIN


WITH DirectReports (codPersona,codJefe,Nombres,Posicion,fecingplanilla,fecbaja,desVP,desDireGer,codCECO,desCECO,codSociedad,codAreaPersonal,desAreaPersonal,codPosicion,desPosicion,codUO,desUO,desjefe,desSubDivision,desEdificio,desOficina,desSubNivelOrg,Predio,Level)
AS
(
-- Anchor member definition                                 
    SELECT l.codEmpleado,l.codjefe,l.apellidos + ' ' + l.nombres AS EMPLEADO,
       L.desPosicion,l.fecingplanilla,l.fecbaja, L.desVP,l.desDireGer,l.codCECO,l.desCECO,l.codSociedad,
          l.codAreaPersonal,l.desAreaPersonal,l.codPosicion,l.desPosicion,l.codUO,l.desUO,l.desJefe,l.desSubDivision,
          l.desEdificio,l.desOficina,l.desSubNivelOrg, l.Predio
           ,0 AS Level
    FROM ods.MD_PERSONAL l WHERE L.codEmpleado = @codpersona      
             and l.flgactivo  = 'S' 
    UNION ALL
-- Recursive member definition
    SELECT l.codEmpleado,l.codjefe,l.apellidos + ' ' + l.nombres AS EMPLEADO,
       L.desPosicion,l.fecingplanilla,l.fecbaja, L.desVP,l.desDireGer,l.codCECO,l.desCECO,l.codSociedad,
          l.codAreaPersonal,l.desAreaPersonal,l.codPosicion,l.desPosicion,l.codUO,l.desUO,l.desJefe,l.desSubDivision,
          l.desEdificio,l.desOficina,l.desSubNivelOrg, l.Predio
          , Level + 1 
    FROM ods.MD_PERSONAL l   
    INNER JOIN DirectReports d ON l.codJefe = d.codPersona
           WHERE l.flgactivo  = 'S'
)


SELECT * INTO #NIVELES FROM DirectReports
--select * from #NIVELES

SELECT --D.Level,
A.codEmpleado,
CASE D.Level
--when 0 then '' + D.Nombres
WHEN 1 THEN '    ' + D.Nombres
WHEN 2 THEN '        ' +D.Nombres
WHEN 3 THEN '            ' +D.Nombres
WHEN 4 THEN '                ' +D.Nombres
WHEN 5 THEN '                    ' +D.Nombres
WHEN 6 THEN '                        ' +D.Nombres
WHEN 7 THEN '                            ' +D.Nombres
ELSE D.Nombres END AS Nombres , d.fecingplanilla 'Fecha Ing/ Planilla Alicorp',
case when d.fecbaja is null then ' ' else d.fecbaja  end  'Fecha Fin Contrato', --OJO
d.desVP'Vicepresidencia/Dirección',d.desDireGer'Rep. Vicepresidencia',
d.codCECO,d.desCECO,d.codSociedad,d.codAreaPersonal,d.desAreaPersonal,
--case when d.desPosicion LIKE 'ASISTENTE DE GERENCIA%' then 0 else 1 end ordenAsistentes,
d.codPosicion,d.desPosicion,d.codUO,d.desUO,d.codJefe,d.desJefe,d.desSubDivision,
          d.desEdificio,d.desOficina,d.desSubNivelOrg, d.Predio 
FROM SP_GETARBOL(@codpersona) A
LEFT JOIN #NIVELES D ON A.CodEmpleado = D.codPersona
--where  codAreaPersonal in ('e0') or d.predio in ('Chimbote', 'Ica', 'Piura', 'Trujillo', 'Tumbes') or codSociedad = 199
-- order by d.Level, d.desVP,d.codUO


END;


--exec dbo.SP_JERARQUIA 11949

GO
/****** Object:  StoredProcedure [dbo].[SP_JERARQUIA_CODMES]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_JERARQUIA_CODMES] (@codpersona int, @anio varchar(4), @mes varchar(2)) 
AS
BEGIN


WITH DirectReports (codPersona,codJefe,Nombres,Posicion,fecingplanilla,fecbaja,desVP,desDireGer,codCECO,desCECO,codSociedad,codAreaPersonal,desAreaPersonal,codPosicion,desPosicion,codUO,desUO,desjefe,desSubDivision,desEdificio,desOficina,desSubNivelOrg,Predio,Level)
AS
(
-- Anchor member definition                                 
    SELECT l.codEmpleado,l.codjefe,l.apellidos + ' ' + l.nombres AS EMPLEADO,
       L.desPosicion,l.fecingplanilla,l.fecbaja, L.desVP,l.desDireGer,l.codCECO,l.desCECO,l.codSociedad,
          l.codAreaPersonal,l.desAreaPersonal,l.codPosicion,l.desPosicion,l.codUO,l.desUO,l.desJefe,l.desSubDivision,
          l.desEdificio,l.desOficina,l.desSubNivelOrg, l.Predio
           ,0 AS Level
    FROM ods.HM_PERSONAL l WHERE L.codEmpleado = @codpersona and CODMES = @anio + @mes     
             and l.flgactivo  = 'S' 
    UNION ALL
-- Recursive member definition
    SELECT l.codEmpleado,l.codjefe,l.apellidos + ' ' + l.nombres AS EMPLEADO,
       L.desPosicion,l.fecingplanilla,l.fecbaja, L.desVP,l.desDireGer,l.codCECO,l.desCECO,l.codSociedad,
          l.codAreaPersonal,l.desAreaPersonal,l.codPosicion,l.desPosicion,l.codUO,l.desUO,l.desJefe,l.desSubDivision,
          l.desEdificio,l.desOficina,l.desSubNivelOrg, l.Predio
          , Level + 1 
    FROM ods.HM_PERSONAL l   
    INNER JOIN DirectReports d ON l.codJefe = d.codPersona
           WHERE l.flgactivo  = 'S' and CODMES = @anio + @mes 
)


SELECT * INTO #NIVELES FROM DirectReports
--select * from #NIVELES

SELECT --D.Level,
A.codEmpleado,
CASE D.Level
--when 0 then '' + D.Nombres
WHEN 1 THEN '    ' + D.Nombres
WHEN 2 THEN '        ' +D.Nombres
WHEN 3 THEN '            ' +D.Nombres
WHEN 4 THEN '                ' +D.Nombres
WHEN 5 THEN '                    ' +D.Nombres
WHEN 6 THEN '                        ' +D.Nombres
WHEN 7 THEN '                            ' +D.Nombres
ELSE D.Nombres END AS Nombres , d.fecingplanilla 'Fecha Ing/ Planilla Alicorp',
case when d.fecbaja is null then ' ' else d.fecbaja  end  'Fecha Fin Contrato', --OJO
d.desVP'Vicepresidencia/Dirección',d.desDireGer'Rep. Vicepresidencia',
d.codCECO,d.desCECO,d.codSociedad,d.codAreaPersonal,d.desAreaPersonal,
--case when d.desPosicion LIKE 'ASISTENTE DE GERENCIA%' then 0 else 1 end ordenAsistentes,
d.codPosicion,d.desPosicion,d.codUO,d.desUO,d.codJefe,d.desJefe,d.desSubDivision,
          d.desEdificio,d.desOficina,d.desSubNivelOrg, d.Predio 
FROM SP_GETARBOL_CODMES(@codpersona, @anio, @mes) A
LEFT JOIN #NIVELES D ON A.CodEmpleado = D.codPersona
--where  codAreaPersonal in ('e0') or d.predio in ('Chimbote', 'Ica', 'Piura', 'Trujillo', 'Tumbes') or codSociedad = 199
-- order by d.Level, d.desVP,d.codUO


END;


--exec dbo.SP_JERARQUIA 11949

GO
/****** Object:  StoredProcedure [dbo].[SP_JERARQUIA_POSICIONES]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_JERARQUIA_POSICIONES] (@CodPosicion int) 
AS
BEGIN


WITH DirectReports (codPosicion,desPosicion,desSociedad,desVP,desDireGer,codUO,desUO,codCECO,desCECO,desSubNivelOrg,codAreaPersonal,desAreaPersonal,
       desSubDivision,codPosicionJefe,Level)
AS
(
       -- Anchor member definition                                 
    SELECT l.codPosicion, l.desPosicion,l.desSociedad,l.desVP,l.desDireGer,l.codUO,l.desUO,l.codCECO,l.desCECO,l.desSubNivelOrg,
       l.codAreaPersonal,l.desAreaPersonal,l.desSubDivision,l.codposicionjefe,0 AS Level
    FROM ODS.MD_POSICION l        
       WHERE L.codPosicion = @CodPosicion             
    UNION ALL
       -- Recursive member definition
      SELECT l.codPosicion, l.desPosicion,l.desSociedad,l.desVP,l.desDireGer,l.codUO,l.desUO,l.codCECO,l.desCECO,l.desSubNivelOrg,
       l.codAreaPersonal,l.desAreaPersonal,l.desSubDivision,l.codPosicionJefe,Level + 1 
    FROM ODS.MD_POSICION l   
    INNER JOIN DirectReports d ON l.codPosicionJefe = d.codPosicion                   
)

SELECT 
       l.codPosicion, l.desPosicion,p.codEmpleado,p.apellidos + ' ' + p.nombres 'nombreyapellidos',l.desSociedad,l.desVP,l.desDireGer,l.codUO,l.desUO,l.codCECO,l.desCECO,l.desSubNivelOrg,
       l.codAreaPersonal,l.desAreaPersonal,l.desSubDivision,l.codPosicionJefe,q.desPosicion 'nombreposicionjefe',P.codjefe,q.apellidos + ' ' + q.nombres 'desjefe',l.Level,P.desEdificio,p.desOficina
	   --l.codAreaPersonal,l.desAreaPersonal,l.desSubDivision,l.codPosicionJefe,P.codjefe,P.desJefe,l.Level,P.desEdificio,p.desOficina
INTO #NIVELES FROM DirectReports l
LEFT JOIN ODS.MD_PERSONAL P ON l.codPosicion = P.codPosicion AND P.flgactivo = 'S'
LEFT JOIN ODS.MD_PERSONAL Q on p.codjefe = q.codEmpleado
 
 --select * from ods.MD_PERSONAL 
SELECT 
A.Posicion Posicion,
CASE D.Level
--when 0 then '' + D.Nombres
WHEN 1 THEN '     ' + D.desPosicion
WHEN 2 THEN '          ' +D.desPosicion
WHEN 3 THEN '               ' +D.desPosicion
WHEN 4 THEN '                    ' +D.desPosicion
WHEN 5 THEN '                         ' +D.desPosicion
WHEN 6 THEN '                              ' +D.desPosicion
WHEN 7 THEN '                                   ' +D.desPosicion
ELSE D.desPosicion END AS 'Descripción de Posición',
CASE WHEN d.codEmpleado IS NULL THEN '0' ELSE d.codEmpleado END 'Código Colaborador',CASE WHEN d.nombreyapellidos IS NULL THEN 'VACANTE' ELSE d.nombreyapellidos END 'Nombre Colaborador', 
d.desSociedad 'Sociedad',d.desSubNivelOrg 'Nivel Organizacional',d.desVP 'Vicepresidencia',d.desDireGer 'Dirección',
case when d.CodPosicionJefe is null then '' else d.CodPosicionJefe end 'Código Posición Jefe',
case when d.nombreposicionjefe is null then '' else d.nombreposicionjefe end 'Nombre Posición Jefe',
--case when d.PosicionJefe is null then '' else d.PosicionJefe  end 'Nombre Posición Jefe',
case when d.CodJefe is null then '' else d.CodJefe end 'Código Jefe',
case when d.desjefe is null then '' else d.desjefe end 'Nombre Jefe',
d.codUO 'Código Unidad Organizativa',d.desUO 'Unidad Organizativa',d.codCeco 'Código Centro de Costo',d.desCeco 'Centro de Costo',
d.desAreaPersonal 'Área de Personal',d.desSubDivision 'Predio / Subdivisión',D.desEdificio 'Edificio', d.desOficina 'Oficina'
FROM SP_GETARBOL_POSICIONES(@CodPosicion) A
LEFT JOIN #NIVELES D ON A.Posicion = D.codPosicion

--where d.Sociedad in ('101-ALICORP')


END;


--select * from ods.MD_PERSONAL where nombreyapellidos like '%DAMM%'
--EXEC SP_JERARQUIA_POSICIONES 10100299
--exec SP_JERARQUIA_POSICIONES 10101856
--EXEC SP_JERARQUIA_POSICIONES 10000005
--select * from ods.MD_PERSONAL where codPosicion =10100181

--select * from ods.MD_POSICION where codPosicion = 10005791

--select * from SP_GETARBOL_POSICIONES(10101856)

--SELECT L.Posición
--    FROM DBO.VUD_MAEPOSICIONES L WHERE l.[Código Posición Jefe] = 10102536
--           --AND L.flgactivo = 'S'

--10100902
--10102482
--10102536

--select * from [ods].[MD_POSICION] where codposicion=10005791







GO
/****** Object:  StoredProcedure [dbo].[SP_JERARQUIA_POSICIONES_CODMES]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_JERARQUIA_POSICIONES_CODMES] (@CodPosicion int, @anio varchar(4), @mes varchar(2)) 
AS
BEGIN


WITH DirectReports (codPosicion,desPosicion,desSociedad,desVP,desDireGer,codUO,desUO,codCECO,desCECO,desSubNivelOrg,codAreaPersonal,desAreaPersonal,
       desSubDivision,codPosicionJefe,Level)
AS
(
       -- Anchor member definition                                 
    SELECT l.codPosicion, l.desPosicion,l.desSociedad,l.desVP,l.desDireGer,l.codUO,l.desUO,l.codCECO,l.desCECO,l.desSubNivelOrg,
       l.codAreaPersonal,l.desAreaPersonal,l.desSubDivision,l.codposicionjefe,0 AS Level
    FROM ODS.MD_POSICION l        
       WHERE L.codPosicion = @CodPosicion             
    UNION ALL
       -- Recursive member definition
      SELECT l.codPosicion, l.desPosicion,l.desSociedad,l.desVP,l.desDireGer,l.codUO,l.desUO,l.codCECO,l.desCECO,l.desSubNivelOrg,
       l.codAreaPersonal,l.desAreaPersonal,l.desSubDivision,l.codPosicionJefe,Level + 1 
    FROM ODS.MD_POSICION l   
    INNER JOIN DirectReports d ON l.codPosicionJefe = d.codPosicion                   
)

SELECT 
       l.codPosicion, l.desPosicion,p.codEmpleado,p.apellidos + ' ' + p.nombres 'nombreyapellidos',l.desSociedad,l.desVP,l.desDireGer,l.codUO,l.desUO,l.codCECO,l.desCECO,l.desSubNivelOrg,
       l.codAreaPersonal,l.desAreaPersonal,l.desSubDivision,l.codPosicionJefe,q.desPosicion 'nombreposicionjefe',P.codjefe,q.apellidos + ' ' + q.nombres 'desjefe',l.Level,P.desEdificio,p.desOficina
	   --l.codAreaPersonal,l.desAreaPersonal,l.desSubDivision,l.codPosicionJefe,P.codjefe,P.desJefe,l.Level,P.desEdificio,p.desOficina
INTO #NIVELES FROM DirectReports l
LEFT JOIN ODS.HM_PERSONAL P ON l.codPosicion = P.codPosicion AND P.flgactivo = 'S'
LEFT JOIN ODS.HM_PERSONAL Q on p.codjefe = q.codEmpleado
where p.codmes = @anio + @mes and q.CODMES = @anio + @mes
 
 --select * from ods.MD_PERSONAL 
SELECT 
A.Posicion Posicion,
CASE D.Level
--when 0 then '' + D.Nombres
WHEN 1 THEN '     ' + D.desPosicion
WHEN 2 THEN '          ' +D.desPosicion
WHEN 3 THEN '               ' +D.desPosicion
WHEN 4 THEN '                    ' +D.desPosicion
WHEN 5 THEN '                         ' +D.desPosicion
WHEN 6 THEN '                              ' +D.desPosicion
WHEN 7 THEN '                                   ' +D.desPosicion
ELSE D.desPosicion END AS 'Descripción de Posición',
CASE WHEN d.codEmpleado IS NULL THEN '0' ELSE d.codEmpleado END 'Código Colaborador',CASE WHEN d.nombreyapellidos IS NULL THEN 'VACANTE' ELSE d.nombreyapellidos END 'Nombre Colaborador', 
d.desSociedad 'Sociedad',d.desSubNivelOrg 'Nivel Organizacional',d.desVP 'Vicepresidencia',d.desDireGer 'Dirección',
case when d.CodPosicionJefe is null then '' else d.CodPosicionJefe end 'Código Posición Jefe',
case when d.nombreposicionjefe is null then '' else d.nombreposicionjefe end 'Nombre Posición Jefe',
--case when d.PosicionJefe is null then '' else d.PosicionJefe  end 'Nombre Posición Jefe',
case when d.CodJefe is null then '' else d.CodJefe end 'Código Jefe',
case when d.desjefe is null then '' else d.desjefe end 'Nombre Jefe',
d.codUO 'Código Unidad Organizativa',d.desUO 'Unidad Organizativa',d.codCeco 'Código Centro de Costo',d.desCeco 'Centro de Costo',
d.desAreaPersonal 'Área de Personal',d.desSubDivision 'Predio / Subdivisión',D.desEdificio 'Edificio', d.desOficina 'Oficina'
FROM SP_GETARBOL_POSICIONES(@CodPosicion) A
LEFT JOIN #NIVELES D ON A.Posicion = D.codPosicion

--where d.Sociedad in ('101-ALICORP')


END;


--select * from ods.MD_PERSONAL where nombreyapellidos like '%DAMM%'
--EXEC SP_JERARQUIA_POSICIONES 10100299
--exec SP_JERARQUIA_POSICIONES 10101856
--EXEC SP_JERARQUIA_POSICIONES 10000005
--select * from ods.MD_PERSONAL where codPosicion =10100181

--select * from ods.MD_POSICION where codPosicion = 10005791

--select * from SP_GETARBOL_POSICIONES(10101856)

--SELECT L.Posición
--    FROM DBO.VUD_MAEPOSICIONES L WHERE l.[Código Posición Jefe] = 10102536
--           --AND L.flgactivo = 'S'

--10100902
--10102482
--10102536

--select * from [ods].[MD_POSICION] where codposicion=10005791







GO
/****** Object:  StoredProcedure [dbo].[SP_JERARQUIA2]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_JERARQUIA2] (@codpersona int) 
AS
BEGIN


WITH DirectReports (codPersona,Nombres,desPosicion,Jefe,desVP,desDireGer,sociedad,correo,Level)
AS
(
-- Anchor member definition                                 
    SELECT l.codEmpleado,l.apellidos + ' ' + l.nombres AS EMPLEADO,
       L.desPosicion,l.desJefe, L.desVP,l.desDireGer,l.codSociedad+'-'+l.desSociedad AS SOCIEDAD,l.email correo,0 AS Level
    FROM ods.MD_PERSONAL l WHERE L.codEmpleado = @codpersona      
             and l.flgactivo  = 'S' 
    UNION ALL
-- Recursive member definition
    SELECT l.codEmpleado,l.apellidos + ' ' + l.nombres AS EMPLEADO,
       L.desPosicion,l.desJefe, L.desVP,l.desDireGer,l.codSociedad+'-'+l.desSociedad AS SOCIEDAD
         ,l.email correo , Level + 1 
    FROM ods.MD_PERSONAL l   
    INNER JOIN DirectReports d ON l.codJefe = d.codPersona
           WHERE l.flgactivo  = 'S'
)


SELECT * INTO #NIVELES FROM DirectReports
--select * from #NIVELES

SELECT 
CASE D.Level
WHEN 1 THEN '    ' + D.Nombres
WHEN 2 THEN '        ' +D.Nombres
WHEN 3 THEN '            ' +D.Nombres
WHEN 4 THEN '                ' +D.Nombres
WHEN 5 THEN '                    ' +D.Nombres
WHEN 6 THEN '                        ' +D.Nombres
WHEN 7 THEN '                            ' +D.Nombres
ELSE D.Nombres END ,
D.*
FROM SP_GETARBOL(@codpersona) A
LEFT JOIN #NIVELES D ON A.CodEmpleado = D.codPersona
-- order by d.Level, d.desVP,d.codUO


END;


--exec dbo.SP_JERARQUIA2 15302

GO
/****** Object:  StoredProcedure [dbo].[SP_PERSONAL_POR_PAIS]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PERSONAL_POR_PAIS] (@Pais nvarchar(50), @anio nvarchar(4), @mes nvarchar(2), @areaNom nvarchar(2) = '99')
AS
BEGIN
    -- DETALLE
	insert into [dbo].[ROL_DE_PERSONAL]
	Select * 
	from
	 (Select s.codSociedad + @anio + @mes as [SOC-Codmes], s.codSociedad as CodigoSociedad, s.desSociedad as [DescripcionSociedad], 
		   (select count(*) from ods.HM_PERSONAL where codAreaPersonal in ('E0', 'K0') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and flgactivo = 'S' and isnull(codposicion, '') != '999999999') [FuncionariosPermanentes],
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Empleado estable', 'Líder de linea') and codAreaPersonal not in ('E0', 'K0') and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and CODMES = @anio + @mes and codSociedad = s.codsociedad and flgactivo = 'S' and codEmpleado not in ('16161', '1300214', '1300255', '1300046', '11646') and isnull(codposicion, '') != '999999999') [EmpleadosPermanentes],
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Obrero estable') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and flgactivo = 'S' and isnull(codposicion, '') != '999999999') [ObrerosPermanentes],
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Empleado estable', 'Líder de linea', 'Obrero estable') and CODMES = @anio + @mes and codSociedad = s.codsociedad and codANomina != @areaNom and flgactivo = 'S' and isnull(codposicion, '') != '999999999') [TotalPermanentes],
		   ('0') [FuncionariosEventuales],
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Empleado contratado') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and flgactivo = 'S' and isnull(codposicion, '') != '999999999') [EmpleadosEventuales],
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Obrero contratado') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end)  and flgactivo = 'S' and isnull(codposicion, '') != '999999999') [ObrerosEventuales],
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Practicante pre-profesional', 'practicante profesional', 'practicantes pre-profesional') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and flgactivo = 'S' and isnull(codposicion, '') != '999999999') Practicantes,
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('CAPAC.LAB.JUVENIL') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and flgactivo = 'S' and isnull(codposicion, '') != '999999999') CLJ,
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('APRENDIZ SENATI') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and flgactivo = 'S' and isnull(codposicion, '') != '999999999') SENATI,
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('APE') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and flgactivo = 'S' and isnull(codposicion, '') != '999999999') APE,
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Empleado contratado', 'Obrero contratado', 'Practicante pre-profesional', 'practicante profesional', 'practicantes pre-profesional', 'CAPAC.LAB.JUVENIL', 'APRENDIZ SENATI', 'APE') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and isnull(codposicion, '') != '999999999' and flgactivo = 'S') [TotalEventuales],
		   ('0') [EmpleadosTerceros],
		   ('0') ObrerosTerceros,
		   ('0') TotalTerceros,
		   (select count(*) from ods.HM_PERSONAL where codAreaPersonal in ('E0') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and isnull(codposicion, '') != '999999999' and flgactivo = 'S') [FuncionariosTotales],
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Empleado estable', 'Líder de linea', 'Empleado contratado') and codAreaPersonal != 'E0' and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and isnull(codposicion, '') != '999999999' and flgactivo = 'S' and codEmpleado not in ('16161', '1300214', '1300255', '1300046', '11646')) [EmpleadosTotales],
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Obrero estable', 'Obrero contratado') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and isnull(codposicion, '') != '999999999' and flgactivo = 'S') [ObrerosTotales],
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Practicante pre-profesional', 'practicante profesional', 'practicantes pre-profesional') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and isnull(codposicion, '') != '999999999' and flgactivo = 'S') PracticantesTotales,
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('CAPAC.LAB.JUVENIL') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and isnull(codposicion, '') != '999999999' and flgactivo = 'S') [CLJTotales],
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('APRENDIZ SENATI') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and isnull(codposicion, '') != '999999999' and flgactivo = 'S') [SENATITotales],
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('APE') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and isnull(codposicion, '') != '999999999' and flgactivo = 'S') [APETotales],
		   ('0') [TercerosTotales],
		   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Empleado estable', 'Líder de linea', 'Empleado contratado', 'Obrero estable', 'Obrero contratado', 'Practicante pre-profesional', 'practicante profesional', 'practicantes pre-profesional', 'CAPAC.LAB.JUVENIL', 'APRENDIZ SENATI', 'APE') and CODMES = @anio + @mes and codSociedad = s.codsociedad and isnull(codANomina, '-') != (case s.codsociedad when 199 then ' ' else @areaNom end) and isnull(codposicion, '') != '999999999' and flgactivo = 'S' and codEmpleado not in ('16161', '1300214', '1300255', '1300046', '11646')) [TotalTotales]
	 from (Select codsociedad, dessociedad from ods.HM_PERSONAL where pais = @Pais and codmes = @anio + @mes group by codsociedad, dessociedad) as s) t

	order by t.DescripcionSociedad 


	-- TOTAL
	/**insert into [dbo].[ROL_DE_PERSONAL]
	Select '' as codSociedad, 'TOTAL ' + UPPER(@Pais) as desSociedad, 
       (select count(*) from ods.HM_PERSONAL where codAreaPersonal in ('E0') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') Funcionarios,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Empleado estable', 'Líder de linea') and codAreaPersonal != 'E0' and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') EmpleadosP,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Obrero estable') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') ObrerosP,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Empleado estable', 'Líder de linea', 'Obrero estable') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') TotalP,
	   ('0') FuncionariosE,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Empleado contratado') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') EmpleadosE,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Obrero contratado') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') ObrerosE,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Practicante pre-profesional', 'practicante profesional', 'practicantes pre-profesional') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') Practicantes,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('CAPAC.LAB.JUVENIL') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') CLJ,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('APRENDIZ SENATI') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') SENATI,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('APE') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') APE,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Empleado contratado', 'Obrero contratado', 'Practicante pre-profesional', 'practicante profesional', 'practicantes pre-profesional', 'CAPAC.LAB.JUVENIL', 'APRENDIZ SENATI', 'APE') and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S' and CODMES = @anio + @mes and pais = @Pais) TotalE,
	   ('0') EmpleadosTe,
	   ('0') ObrerosTe,
	   ('0') TotalTe,
	   (select count(*) from ods.HM_PERSONAL where codAreaPersonal in ('E0') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') FuncionariosT,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Empleado estable', 'Líder de linea', 'Empleado contratado') and codAreaPersonal != 'E0' and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') EmpleadosT,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Obrero estable', 'Obrero contratado') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') ObrerosT,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Practicante pre-profesional', 'practicante profesional', 'practicantes pre-profesional') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') PracticantesT,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('CAPAC.LAB.JUVENIL') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') CLJT,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('APRENDIZ SENATI') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') SENATIT,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('APE') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') APET,
	   ('0') TercerizadosT,
	   (select count(*) from ods.HM_PERSONAL where desAreaPersonal in ('Empleado estable', 'Líder de linea', 'Empleado contratado', 'Obrero estable', 'Obrero contratado', 'Practicante pre-profesional', 'practicante profesional', 'practicantes pre-profesional', 'CAPAC.LAB.JUVENIL', 'APRENDIZ SENATI', 'APE') and CODMES = @anio + @mes and pais = @Pais and codANomina != @areaNom and codPosicion != '99999999' and flgactivo = 'S') TotalT,
	   @anio as Anio,
	   @mes as Mes
from (Select pais from ods.HM_PERSONAL where pais = @Pais group by pais) as s
**/


END

GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTE_CAMPOS_NULOS]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REPORTE_CAMPOS_NULOS] (@archTemplate nvarchar(100) = "Prueba.xlsx",
												 @rutaDestino nvarchar(100) = "D:\Users\SOrdayaL\Documents\Reporte de nulos\",
												 @rutaTemplate nvarchar(100) = "D:\Users\SOrdayaL\Documents\Pruebas Data Tools\")
AS
BEGIN
	DECLARE @executionID bigint
	EXEC  SSISDB.catalog.create_execution 'Reporte de Campos nulos', 'Reporte de Nulos', 'Package1.dtsx', NULL, 1, @executionID out

	EXEC SSISDB.catalog.set_execution_parameter_value @executionID, 30, 'ArchTemplate', @archTemplate
	EXEC SSISDB.catalog.set_execution_parameter_value @executionID, 30, 'RutaDestino', "D:\Users\SOrdayaL\Documents\Reporte de nulos\"
	EXEC SSISDB.catalog.set_execution_parameter_value @executionID, 30, 'RutaTemplate', @rutaTemplate

	EXEC SSISDB.catalog.start_execution @executionID
END;


GO
/****** Object:  StoredProcedure [dbo].[SP_ROL_DE_PERSONAL]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ROL_DE_PERSONAL] (@anioInicio nvarchar(4) = '2016', @mesInicio nvarchar(2) = '12')
AS
BEGIN
    DECLARE CUR_MESES CURSOR
    FOR select * from dbo.YearMonths(@mesInicio+'/1/'+@anioInicio, DATEADD(month, -2, getdate()))

    DECLARE @anio nvarchar(4), @mes nvarchar(2)  
 
	OPEN CUR_MESES

	FETCH NEXT FROM CUR_MESES
	INTO @anio, @mes

	
	WHILE @@FETCH_STATUS =  0
	BEGIN  
  
	    execute dbo.[SP_PERSONAL_POR_PAIS] 'perú', @anio, @mes
		execute dbo.[SP_PERSONAL_POR_PAIS] 'argentina', @anio, @mes
		execute dbo.[SP_PERSONAL_POR_PAIS] 'ecuador', @anio, @mes
		execute dbo.[SP_PERSONAL_POR_PAIS] 'colombia', @anio, @mes
		execute dbo.[SP_PERSONAL_POR_PAIS] 'costa rica', @anio, @mes, ' '
		execute dbo.[SP_PERSONAL_POR_PAIS] 'honduras', @anio, @mes, ' '
		execute dbo.[SP_PERSONAL_POR_PAIS] 'chile', @anio, @mes, ' '
		execute dbo.[SP_PERSONAL_POR_PAIS] 'brasil', @anio, @mes	
		execute dbo.[SP_PERSONAL_POR_PAIS] 'uruguay', @anio, @mes, ' '


	FETCH NEXT FROM CUR_MESES
	INTO @anio, @mes

	END

	CLOSE CUR_MESES;
	DEALLOCATE CUR_MESES;
END

-- delete dbo.ROL_DE_PERSONAL

-- execute [dbo].[SP_ROL_DE_PERSONAL]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_MD_ACTIVOS]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_RPT_MD_ACTIVOS]
AS
BEGIN
DROP TABLE VUD_MAEACTIVOS

SELECT
MD.codEmpleado AS 'Código',
MD.apellidos + ' ' + MD.nombres 'Colaborador',
MD.codSociedad + '-' + MD.desSociedad AS 'Sociedad',
MD.desVP AS 'Vicepresidencia',
MD.desDireGer AS 'Dirección/Gerencia',
MD.desSubNivelOrg AS 'Nivel Organizacional',
MD.codjefe AS 'Código de Jefe',
MD.desJefe AS 'Nombre Jefe',
MD.codPosicion AS 'Posición',
MD.desPosicion AS 'Descripción Posición',
MD.codUO AS 'Unidad Organizativa',
MD.desUO AS 'Descripción de Unidad Organizativa',
MD.codCECO AS 'Centro de Costo',
MD.desCECO AS 'Descripción de Centro de Costo',
--MD.codAreaPersonal AS 'Cod. Área Personal',
MD.desAreaPersonal AS 'Área de personal',
--MD.codANomina AS 'Área de nómina',
--MD.desANomina AS 'Descripción de Área de nómina',
MD.desSubDivision AS 'Ubicación/Predio',
MD.desEdificio AS 'Edificio',
MD.desOficina AS 'Oficina',
--MD.clasecontrato AS 'Clase Contrato',
MD.fecingplanilla AS 'Fecha Ingreso',
MD.email AS 'E-Mail',
MD.anexo AS 'Anexo',
MD.numRPM AS 'RPM',
MD.codUsuarioRed AS 'Usuario Red',
--MD.codFuncion AS 'Código de Función',
MD.Horario as 'Horario',
MD.dni AS 'DNI',
MD.cExtranjeria AS 'Carné de Extranjería',
MD.sexo AS 'Sexo',
MD.fecnacimiento AS 'Fecha Nacimiento'
INTO VUD_MAEACTIVOS
FROM ODS.MD_PERSONAL MD
WHERE MD.flgactivo = 'S'

END;



GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_MD_CESES]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_RPT_MD_CESES]
AS
BEGIN

DROP TABLE ODS.MD_CESES

SELECT * INTO ODS.MD_CESES FROM 
(

--SELECT
--D.desSociedad,
--ISNULL(D.desVP,'N.D.') Vicepresidencia,
--ISNULL(D.desDireGer,'N.D') 'Dirección/Gerencia',
--d.codEmpleado 'Código',
--d.desAreaPersonal 'Grupo Colaboradores',
--D.[nombreyapellidos] 'Colaborador',
--YEAR(D.fecbaja) 'Año Cese',
--CASE  MONTH(d.fecbaja)
--WHEN '1' Then 'Enero'
--WHEN '2' Then 'Febrero'
--WHEN '3' Then 'Marzo'
--WHEN '4' Then 'Abril'
--WHEN '5' Then 'Mayo'
--WHEN '6' Then 'Junio'
--WHEN '7' Then 'Julio'
--WHEN '8' Then 'Agosto'
--WHEN '9' Then 'Setiembre'
--WHEN '10' Then 'Octubre'
--WHEN '11' Then 'Noviembre'
--ELSE 'Diciembre' END 'Mes Cese',
--d.desPosicion 'Posición',
----ISNULL(d.desSubNivelOrg,'N.D.') 'Nivel Organizacional',
--ISNULL(D.desSubDivision,'N,D.') 'Ubicación/Predio',
--D.desEdificio 'Edificio',
--d.desOficina 'Oficina',
--ISNULL(d.anexo,'N.D.') 'Anexo',
--ISNULL(d.numRPM,'N.D.') 'RPM',
--D.fecbaja 'Fecha Cese'
--FROM ODS.MD_PERSONAL D
--WHERE D.fecbaja IS NOT NULL
--and D.flgactivo = 'N'
----and d.codSociedad IN ('101','737')
--and d.MotivoRenuncia IN ('Renuncia Voluntaria','Cese Periodo Prueba','Fin de Contrato')
--and d.codANomina <> '99'
--UNION ALL
SELECT
D.desSociedad,
ISNULL(D.desVP,'N.D.') Vicepresidencia,
ISNULL(D.desDireGer,'N.D') 'Dirección/Gerencia',
d.codEmpleado 'Código',
d.desAreaPersonal 'Grupo Colaboradores',
d.apellidos + ' ' + d.nombres 'Colaborador',
dbo.FN_TOCODMES(D.fecBaja) CODMES_BAJA,
YEAR(D.fecbaja) 'Año Cese',
CASE  MONTH(d.fecbaja)
WHEN '1' Then 'Enero'
WHEN '2' Then 'Febrero'
WHEN '3' Then 'Marzo'
WHEN '4' Then 'Abril'
WHEN '5' Then 'Mayo'
WHEN '6' Then 'Junio'
WHEN '7' Then 'Julio'
WHEN '8' Then 'Agosto'
WHEN '9' Then 'Setiembre'
WHEN '10' Then 'Octubre'
WHEN '11' Then 'Noviembre'
ELSE 'Diciembre' END 'Mes Cese',
d.desPosicion 'Posición',
--ISNULL(d.desSubNivelOrg,'N.D.') 'Nivel Organizacional',
ISNULL(D.desSubDivision,'N,D.') 'Ubicación/Predio',
D.desEdificio 'Edificio',
d.desOficina 'Oficina',
ISNULL(d.anexo,'N.D.') 'Anexo',
ISNULL(d.numRPM,'N.D.') 'RPM',
D.fecbaja 'Fecha Cese'
FROM ODS.MD_PERSONAL D
WHERE D.fecbaja IS NOT NULL
and d.fecbaja < GETDATE()
--and d.codSociedad IN ('101','737')
--and d.MotivoRenuncia NOT IN ('Renuncia Voluntaria','Cese Periodo Prueba','Fin de Contrato')
and d.codANomina <> '99'
UNION ALL
SELECT
D.desSociedad,
ISNULL(D.desVP,'N.D.') Vicepresidencia,
ISNULL(D.desDireGer,'N.D') 'Dirección/Gerencia',
d.codEmpleado 'Código',
d.desAreaPersonal 'Grupo Colaboradores',
d.apellidos + ' ' + d.nombres 'Colaborador',
dbo.FN_TOCODMES(D.fecBaja) CODMES_BAJA,
YEAR(D.fecbaja) 'Año Cese',
CASE  MONTH(d.fecbaja)
WHEN '1' Then 'Enero'
WHEN '2' Then 'Febrero'
WHEN '3' Then 'Marzo'
WHEN '4' Then 'Abril'
WHEN '5' Then 'Mayo'
WHEN '6' Then 'Junio'
WHEN '7' Then 'Julio'
WHEN '8' Then 'Agosto'
WHEN '9' Then 'Setiembre'
WHEN '10' Then 'Octubre'
WHEN '11' Then 'Noviembre'
ELSE 'Diciembre' END 'Mes Cese',
d.desPosicion 'Posición',
--ISNULL(d.desSubNivelOrg,'N.D.') 'Nivel Organizacional',
ISNULL(D.desSubDivision,'N,D.') 'Ubicación/Predio',
D.desEdificio 'Edificio',
d.desOficina 'Oficina',
ISNULL(d.anexo,'N.D.') 'Anexo',
ISNULL(d.numRPM,'N.D.') 'RPM',
D.fecbaja 'Fecha Cese'
FROM ODS.HM_PERSONAL D
WHERE D.fecbaja IS NOT NULL
--AND (YEAR(D.fecbaja)>2015)
and D.flgCese = 'S'
--and d.codSociedad IN ('101','737')
--and d.MotivoRenuncia IN ('Renuncia Voluntaria','Cese Periodo Prueba','Fin de Contrato')
and d.codANomina <> '99') B
--ORDER BY D.fecbaja DESC

END;


GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_MD_INGRESOS]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_RPT_MD_INGRESOS]
AS
BEGIN
DROP TABLE VUD_MAEINGRESOS

SELECT
MD.codEmpleado AS 'Código',
MD.apellidos + ' ' + MD.nombres AS 'Colaborador',
MD.codSociedad + '-' + MD.desSociedad AS 'Sociedad',
MD.desVP AS 'Vicepresidencia',
MD.desDireGer AS 'Dirección/Gerencia',
MD.desSubNivelOrg AS 'Nivel Organizacional',
MD.codjefe AS 'Código de Jefe',
MD.desJefe AS 'Nombre Jefe',
MD.codPosicion AS 'Posición',
MD.desPosicion AS 'Descripción Posición',
MD.codUO AS 'Unidad Organizativa',
MD.desUO AS 'Descripción de Unidad Organizativa',
MD.codCECO AS 'Centro de Costo',
MD.desCECO AS 'Descripción de Centro de Costo',
--MD.codAreaPersonal AS 'Cod. Área Personal',
MD.desAreaPersonal AS 'Área de personal',
--MD.codANomina AS 'Área de nómina',
--MD.desANomina AS 'Descripción de Área de nómina',
MD.desSubDivision AS 'Ubicación/Predio',
MD.desEdificio AS 'Edificio',
MD.desOficina AS 'Oficina',
--MD.clasecontrato AS 'Clase Contrato',
MD.fecingplanilla AS 'Fecha Ingreso',
CASE  MONTH(MD.fecingplanilla)
WHEN '1' Then 'Enero'
WHEN '2' Then 'Febrero'
WHEN '3' Then 'Marzo'
WHEN '4' Then 'Abril'
WHEN '5' Then 'Mayo'
WHEN '6' Then 'Junio'
WHEN '7' Then 'Julio'
WHEN '8' Then 'Agosto'
WHEN '9' Then 'Setiembre'
WHEN '10' Then 'Octubre'
WHEN '11' Then 'Noviembre'
ELSE 'Diciembre' END 'Mes Ingreso',
YEAR(MD.fecingplanilla) AS 'Año Ingreso'
--MD.email AS 'E-Mail',
--MD.anexo AS 'Anexo',
--MD.numRPM AS 'RPM',
--MD.codUsuarioRed AS 'Usuario Red',
----MD.codFuncion AS 'Código de Función',
--MD.Horario as 'Horario',
--MD.dni AS 'DNI',
--MD.cExtranjeria AS 'Carné de Extranjería',
--MD.sexo AS 'Sexo',
--MD.fecnacimiento AS 'Fecha Nacimiento'
INTO VUD_MAEINGRESOS
FROM ODS.MD_PERSONAL MD
WHERE YEAR(MD.fecingplanilla)>2015



END;



GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_MD_MAESTRO]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_RPT_MD_MAESTRO]
AS
BEGIN
DROP TABLE VUD_MAEEMPLEADOS

SELECT
MD.codEmpleado AS 'Código',
MD.apellidos + ' ' + MD.nombres AS 'Colaborador',
MD.codSociedad + '-' + MD.desSociedad AS 'Sociedad',
MD.desVP AS 'Vicepresidencia',
MD.desDireGer AS 'Dirección/Gerencia',
MD.desSubNivelOrg AS 'Nivel Organizacional',
MD.codjefe AS 'Código de Jefe',
MD.desJefe AS 'Nombre Jefe',
MD.codPosicion AS 'Posición',
MD.desPosicion AS 'Descripción Posición',
MD.codUO AS 'Unidad Organizativa',
MD.desUO AS 'Descripción de Unidad Organizativa',
MD.codCECO AS 'Centro de Costo',
MD.desCECO AS 'Descripción de Centro de Costo',
--MD.codAreaPersonal AS 'Cod. Área Personal',
MD.desAreaPersonal AS 'Área de personal',
--MD.codANomina AS 'Área de nómina',
--MD.desANomina AS 'Descripción de Área de nómina',
MD.Predio AS 'Predio',
MD.desEdificio AS 'Edificio',
MD.desOficina AS 'Oficina',
--MD.clasecontrato AS 'Clase Contrato',
--MD.fecinggrupo AS 'Fecha Ingreso Grupo',
FLOOR(dbo.FN_DAMEDIFANHO_FECHAS(MD.fecingplanilla,GETDATE())) AS 'Años Serv. Alicorp',
MD.fecingplanilla AS 'Fecha Ingreso',
MD.email AS 'E-Mail',
MD.anexo AS 'Anexo',
MD.numRPM AS 'RPM',
MD.codUsuarioRed AS 'Usuario Red',
--MD.codFuncion AS 'Código de Función',
--MD.desFuncion AS 'Función',
MD.Horario as 'Horario',
TRY_CONVERT(decimal(20,0),try_parse(md.[DNI] as float)) AS 'DNI',
MD.cExtranjeria AS 'Carné de Extranjería',
MD.sexo AS 'Sexo',
MD.desestadocivil AS 'Estado Civil',
MD.fecnacimiento AS 'Fecha Nacimiento',
FLOOR(dbo.FN_DAMEDIFANHO_FECHAS(MD.fecnacimiento,GETDATE())) AS 'Edad'
INTO VUD_MAEEMPLEADOS
FROM ODS.MD_PERSONAL MD
WHERE (MD.flgactivo = 'S' AND MD.flgEmpleado = 'S') or codEmpleado = 00027140	


DROP TABLE VUD_MAEOBREROS

SELECT
MD.codEmpleado AS 'Código',
MD.apellidos + ' ' + MD.nombres 'Colaborador',
MD.codSociedad + '-' + MD.desSociedad AS 'Sociedad',
MD.desVP AS 'Vicepresidencia',
MD.desDireGer AS 'Dirección/Gerencia',
--MD.desSubNivelOrg AS 'Nivel Organizacional',
MD.codjefe AS 'Código de Jefe',
MD.desJefe AS 'Nombre Jefe',
MD.codPosicion AS 'Posición',
MD.desPosicion AS 'Descripción Posición',
MD.codUO AS 'Unidad Organizativa',
MD.desUO AS 'Descripción de Unidad Organizativa',
MD.codCECO AS 'Centro de Costo',
MD.desCECO AS 'Descripción de Centro de Costo',
--MD.codAreaPersonal AS 'Cod. Área Personal',
MD.desAreaPersonal AS 'Área de personal',
--MD.codANomina AS 'Área de nómina',
--MD.desANomina AS 'Descripción de Área de nómina',
MD.desSubDivision AS 'Ubicación/Predio',
MD.desEdificio AS 'Edificio',
MD.desOficina AS 'Oficina',
--MD.clasecontrato AS 'Clase Contrato',
--MD.fecinggrupo AS 'Fecha Ingreso',
FLOOR(dbo.FN_DAMEDIFANHO_FECHAS(MD.fecingplanilla,GETDATE())) AS 'Años Serv. Alicorp',
MD.fecingplanilla AS 'Fecha Ingreso',
MD.email AS 'E-Mail',
MD.anexo AS 'Anexo',
MD.numRPM AS 'RPM',
--MD.codUsuarioRed AS 'Usuario Red',
MD.codFuncion AS 'Código de Función',
MD.desFuncion AS 'Función',
MD.Horario as 'Horario',
TRY_CONVERT(decimal(20,0),try_parse(md.[DNI] as float)) AS 'DNI',
MD.cExtranjeria AS 'Carné de Extranjería',
MD.sexo AS 'Sexo',
MD.desestadocivil AS 'Estado Civil',
MD.fecnacimiento AS 'Fecha Nacimiento',
FLOOR(dbo.FN_DAMEDIFANHO_FECHAS(MD.fecnacimiento,GETDATE())) AS 'Edad'
INTO VUD_MAEOBREROS
FROM ODS.MD_PERSONAL MD
WHERE MD.flgactivo = 'S' AND MD.flgEmpleado = 'N'


END;




GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_CPE]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_CPE] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE ODS.HA_CPE 
	SET califobjetivos = 'Sin Calif.',califcompetencias= 'Sin Calif.',califgeneral = 'Sin Calif.'

	UPDATE ODS.HA_CPE 
	SET califobjetivos = 'Sob. Amp. Obj.'
	WHERE notaobjetivos>=4.5 and notaobjetivos<=5

	UPDATE ODS.HA_CPE 
	SET califobjetivos = 'Exc+ Obj.'
	WHERE notaobjetivos>=4.00 and notaobjetivos<=4.49

	UPDATE ODS.HA_CPE 
	SET califobjetivos = 'Exc- Obj.'
	WHERE notaobjetivos>=3.50 and notaobjetivos<=3.99

	UPDATE ODS.HA_CPE 
	SET califobjetivos = 'Cumple Obj.'
	WHERE notaobjetivos>=3.00 and notaobjetivos<=3.49


	UPDATE ODS.HA_CPE 
	SET califobjetivos = 'Cum. Parc. Obj.'
	WHERE notaobjetivos>=2.00 and notaobjetivos<=2.99

	UPDATE ODS.HA_CPE 
	SET califobjetivos = 'No Cum. Obj.'
	WHERE notaobjetivos>=1.00 and notaobjetivos<=1.99



	UPDATE ODS.HA_CPE 
	SET califcompetencias = 'Sob. Clara fortaleza'
	WHERE notacompetencias>=4.50 and notacompetencias<=5.00

	UPDATE ODS.HA_CPE 
	SET califcompetencias = 'Exc. Fortaleza'
	WHERE notacompetencias>=3.50 and notacompetencias<=4.49

	UPDATE ODS.HA_CPE 
	SET califcompetencias = 'Cum. Suficiencia'
	WHERE notacompetencias>=3.00 and notacompetencias<=3.49


	UPDATE ODS.HA_CPE 
	SET califcompetencias = 'Cum. Parc. En Desar.'
	WHERE notacompetencias>=2.00 and notacompetencias<=2.99

	UPDATE ODS.HA_CPE 
	SET califcompetencias = 'No Cum. A. Oport'
	WHERE notacompetencias>=1.00 and notacompetencias<=1.99

		
	UPDATE ODS.HA_CPE 
	SET califgeneral = 'Sob. Exp.'
	WHERE notageneral>=4.50 and notageneral<=5.00

	UPDATE ODS.HA_CPE 
	SET califgeneral = 'Exc. Exp.'
	WHERE notageneral>=3.50 and notageneral<=4.49

	UPDATE ODS.HA_CPE 
	SET califgeneral = 'Cum. Exp.'
	WHERE notageneral>=3.00 and notageneral<=3.49


	UPDATE ODS.HA_CPE 
	SET califgeneral = 'Cum. Par. Exp.'
	WHERE notageneral>=2.00 and notageneral<=2.99

	UPDATE ODS.HA_CPE 
	SET califgeneral = 'No Cum. Exp.'
	WHERE notageneral>=1.00 and notageneral<=1.99

	/*UPDATE ODS.HA_CPE 
	SET PAIS = CASE Pais
	WHEN 'PERU' THEN 'PERÚ'
	ELSE UPPER(PAIS) END*/

END


GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_HM_CESES]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_HM_CESES]

AS
BEGIN	
	
--- 3. Actualización de MOTIVOS DE RENUNCIA -------------

	--TIPOS DE RENUNCIA ARGENTINA
	UPDATE ODS.HM_PERSONAL 
	SET MotivoRenuncia = CASE MotivoRenuncia
	WHEN 'EXTINCION X MUTUO AC' THEN 'MUTUO DISENSO'
	WHEN 'RENUNCIA' THEN 'RENUNCIA VOLUNTARIA'
	WHEN 'FINALIZACIÒN PERÌODO' THEN 'FIN DE CONTRATO'
	WHEN 'DESPIDO CON JUSTA CA' THEN 'DESPIDO CON JUSTA CAUSA'
	WHEN 'DESPIDO SIN CAUSA' THEN 'DESPIDO SIN CAUSA'
	WHEN 'JUBILACIÒN' THEN 'JUBILACIÓN'
	WHEN 'VENCIMIENTO O FINALI' THEN 'FIN DE CONTRATO'
	WHEN 'FALLECIMIENTO TRABAJ' THEN 'FALLECIMIENTO'
	ELSE MotivoRenuncia END
	WHERE CODSOCIEDAD IN (120,125,720,721)

	UPDATE ODS.HM_PERSONAL
	SET SubMotivoRenuncia = MotivoRenuncia
	WHERE CODSOCIEDAD IN (120,125,720,721)

	------------------------------------------------

	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =1910345 AND CODMES=201503 
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =1910388 AND CODMES=201608 
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =1910104 AND CODMES=201507 
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =1910429 AND CODMES=201608 
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =25209 AND CODMES=201604 
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='RENUNCIA VOLUNTARIA', SUBMOTIVORENUNCIA='RENUNCIA VOLUNTARIA' WHERE CODEMPLEADO =19303 AND CODMES=201504
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='RENUNCIA VOLUNTARIA', SUBMOTIVORENUNCIA='RENUNCIA VOLUNTARIA' WHERE CODEMPLEADO =1300280 AND CODMES=201506
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='MUTUO DISENSO', SUBMOTIVORENUNCIA='MUTUO DISENSO' WHERE CODEMPLEADO =7318 AND CODMES=201410
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =26002 AND CODMES=201609 
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='MUTUO DISENSO', SUBMOTIVORENUNCIA='DESPIDO FALTA GRAVE' WHERE CODEMPLEADO =7319 AND CODMES=201505
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='DESPIDO FALTA GRAVE', SUBMOTIVORENUNCIA='DESPIDO FALTA GRAVE' WHERE CODEMPLEADO =2226 AND CODMES=201607
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =19286 AND CODMES=201405 
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =18845 AND CODMES=201405 
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =19961 AND CODMES=201405 
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =21028 AND CODMES=201405 
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='MUTUO DISENSO', SUBMOTIVORENUNCIA='MUTUO DISENSO' WHERE CODEMPLEADO =1200090 AND CODMES=201602
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='RENUNCIA VOLUNTARIA', SUBMOTIVORENUNCIA='RENUNCIA VOLUNTARIA' WHERE CODEMPLEADO =25550 AND CODMES=201603
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =25646 AND CODMES=201604
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='RENUNCIA VOLUNTARIA', SUBMOTIVORENUNCIA='RENUNCIA VOLUNTARIA' WHERE CODEMPLEADO =1203772 AND CODMES=201609
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='RENUNCIA VOLUNTARIA', SUBMOTIVORENUNCIA='RENUNCIA VOLUNTARIA' WHERE CODEMPLEADO =26778 AND CODMES=201610
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='MUTUO DISENSO', SUBMOTIVORENUNCIA='MUTUO DISENSO' WHERE CODEMPLEADO =1200090 AND CODMES=201602
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='MUTUO DISENSO', SUBMOTIVORENUNCIA='DESPIDO FALTA GRAVE' WHERE CODEMPLEADO =5635 AND CODMES=201607
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='RENUNCIA VOLUNTARIA', SUBMOTIVORENUNCIA='RENUNCIA VOLUNTARIA' WHERE CODEMPLEADO =25582 AND CODMES=201609
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='Despido Arbitrario', SUBMOTIVORENUNCIA='Despido Arbitrario' WHERE CODEMPLEADO =17764 AND CODMES=201607
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FALLECIMIENTO', SUBMOTIVORENUNCIA='FALLECIMIENTO' WHERE CODEMPLEADO =40255 AND CODMES=201612
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =24993 AND CODMES=201604 AND CODSOCIEDAD='101'
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =1910383 AND CODMES=201607 AND CODSOCIEDAD='106'
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='RENUNCIA VOLUNTARIA', SUBMOTIVORENUNCIA='RENUNCIA VOLUNTARIA' WHERE CODEMPLEADO =26091 AND CODMES=201605
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='RENUNCIA VOLUNTARIA', SUBMOTIVORENUNCIA='RENUNCIA VOLUNTARIA' WHERE CODEMPLEADO =26458 AND CODMES=201610
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='CESE PERIODO DE PRUEBA', SUBMOTIVORENUNCIA='CESE PERIODO DE PRUEBA' WHERE CODEMPLEADO =1203683 AND CODMES=201609 AND CODSOCIEDAD='736'
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='RENUNCIA VOLUNTARIA', SUBMOTIVORENUNCIA='RENUNCIA VOLUNTARIA' WHERE CODEMPLEADO =1203960 AND CODMES=201612
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='CESE PERIODO DE PRUEBA', SUBMOTIVORENUNCIA='CESE PERIODO DE PRUEBA' WHERE CODEMPLEADO =26676 AND CODMES=201611
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='CESE PERIODO DE PRUEBA', SUBMOTIVORENUNCIA='CESE PERIODO DE PRUEBA' WHERE CODEMPLEADO =1203283 AND CODMES=201607
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =1203288 AND CODMES=201607
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =1203320 AND CODMES=201608
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =1203260 AND CODMES=201607
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =26726 AND CODMES=201701
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' WHERE CODEMPLEADO =26727 AND CODMES=201701

	
	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='FIN DE CONTRATO', SUBMOTIVORENUNCIA='FIN DE CONTRATO' 
	WHERE CODEMPLEADO IN (24864,25307,25324,25325,25328,25329,25337,25338,25432,25433,25434,25436,23906,23907,24869,24871,7785,25003,
	25323,25326,25327,23543,26020,26051,26055,26089,25652,26140,26143,26145,26342,26345,26346,26347,26348,26349,26451,23158,26127,26424)
	AND CODMES BETWEEN 201601 AND 201612
	AND MotivoRenuncia IS NULL AND FLGCESE = 'S'

	UPDATE ODS.HM_PERSONAL SET MOTIVORENUNCIA='CESE PERIODO DE PRUEBA', SUBMOTIVORENUNCIA='CESE PERIODO DE PRUEBA' 
	WHERE CODEMPLEADO IN (26028,26029,26191,26192,26193,26195,26694,26695,26559)
	AND FLGCESE = 'S'

	SELECT
	j.CODMES,
	J.codEmpleado,j.fecbaja,j.MotivoRenuncia,j.SubMotivoRenuncia,j.desAreaPersonal,j.codsociedad,j.desSociedad,
	c.clasecontrato,c.MotivoMedida,c.SubmotivoMedida
	INTO #t1
	FROM ODS.HM_PERSONAL J
	INNER JOIN ods.HM_CESADOS c on j.codEmpleado = c.CODEMPLEADO and j.CODMES = dbo.FN_TOCODMES(c.fecbaja)
	WHERE J.CODSOCIEDAD NOT IN (0)--(125,721,120,731,730,720)
	AND J.flgCese = 'S'
	AND J.codmes>201512

	--Ecuador, Colombia y Honduras
		
	UPDATE ODS.HM_PERSONAL
	SET 
	ODS.HM_PERSONAL.MotivoRenuncia = ISNULL((SELECT MotivoMedida FROM #t1 C WHERE C.codempleado = ODS.HM_PERSONAL.codEmpleado AND C.CODMES = ODS.HM_PERSONAL.CODMES),
	ODS.HM_PERSONAL.MotivoRenuncia),
	ODS.HM_PERSONAL.SubMotivoRenuncia = ISNULL((SELECT MotivoMedida FROM #t1 C WHERE C.codempleado = ODS.HM_PERSONAL.codEmpleado AND C.CODMES = ODS.HM_PERSONAL.CODMES),
	ODS.HM_PERSONAL.SubMotivoRenuncia)
	WHERE ODS.HM_PERSONAL.FLGCESE = 'S'	
	AND ODS.HM_PERSONAL.CODSOCIEDAD IN (112,164,110,105,107)
	AND ODS.HM_PERSONAL.CODMES >= 201601
	
	--Alicorp Perú y Otros
	
	--UPDATE #t1 SET MotivoRenuncia = MotivoMedida
	--WHERE SubmotivoMedida=SubMotivoRenuncia and SubmotivoMedida is not null
	--AND codSociedad IN (101,736,752,108,106,737,199)	
		
	UPDATE ODS.HM_PERSONAL
	SET 
	ODS.HM_PERSONAL.MotivoRenuncia = ISNULL((SELECT MotivoMedida FROM #t1 C WHERE C.codempleado = ODS.HM_PERSONAL.codEmpleado AND C.CODMES = ODS.HM_PERSONAL.CODMES),
	ODS.HM_PERSONAL.MotivoRenuncia),
	ODS.HM_PERSONAL.SubMotivoRenuncia = ISNULL((SELECT SubmotivoMedida FROM #t1 C WHERE C.codempleado = ODS.HM_PERSONAL.codEmpleado AND C.CODMES = ODS.HM_PERSONAL.CODMES),
	ODS.HM_PERSONAL.SubMotivoRenuncia)
	WHERE ODS.HM_PERSONAL.FLGCESE = 'S'	
	AND ODS.HM_PERSONAL.CODSOCIEDAD IN (101,736,752,108,106,737,738)	
	AND ODS.HM_PERSONAL.CODMES >=201601
	AND ODS.HM_PERSONAL.MotivoRenuncia IS NULL

	--select * from #t1

	DROP TABLE #t1
	
	UPDATE ODS.HM_PERSONAL SET MotivoRenuncia = NULL,SubMotivoRenuncia = NULL
	WHERE FLGCESE = 'N'

	UPDATE ODS.HM_PERSONAL SET MotivoRenuncia = UPPER(MotivoRenuncia),SubMotivoRenuncia = UPPER(SubMotivoRenuncia)

	
	IF (SELECT COUNT(*) FROM ODS.HM_PERSONAL 
		WHERE MotivoRenuncia IS NULL and FLGCese = 'S'
		 and CODMES > 201512 AND CODSOCIEDAD IN (101,736,752,108,106,737,738,112,164,110,105,107)
		)>0
	 SELECT 1/0;  

		
	--SELECT  * FROM ODS.HM_PERSONAL 
	--WHERE MotivoRenuncia IS NULL and FLGCese = 'S'
	--and CODMES > 201512 AND CODSOCIEDAD IN (101,736,752,108,106,737,199)

		 
	--SELECT  * FROM ODS.HM_PERSONAL 
	--WHERE MotivoRenuncia IS NULL and FLGCese = 'S'
	--and CODMES > 201512 
		 	
END


GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_HM_PERSONAL]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_UPDATE_HM_PERSONAL]
AS
BEGIN


-- INICIO UPDATE HM ARGENTINA

UPDATE ods.HM_ARG_PERSONAL
SET codAreaPersonal = (SELECT DISTINCT codAreaPersonal FROM ODS.HM_ARG_PERSONAL P WHERE P.CodEmpleado = ODS.HM_ARG_PERSONAL.codEmpleado AND P.codAreaPersonal IS NOT NULL),
	desAreaPersonal = (SELECT DISTINCT desAreaPersonal FROM ODS.HM_ARG_PERSONAL P WHERE P.CodEmpleado = ODS.HM_ARG_PERSONAL.codEmpleado AND P.desAreaPersonal IS NOT NULL)
WHERE (codAreaPersonal IS NULL OR desAreaPersonal IS NULL)

UPDATE ods.HM_ARG_PERSONAL
SET codANomina = codAreaPersonal,
	desANomina =  desAreaPersonal 
WHERE (codANomina IS NULL OR desANomina IS NULL)


DELETE FROM ODS.HM_PERSONAL
WHERE codSociedad IN (SELECT distinct codSociedad From ODS.HM_ARG_PERSONAL)

INSERT INTO ODS.HM_PERSONAL
SELECT * FROM ODS.HM_ARG_PERSONAL

-- FIN UPDATE HM ARGENTINA

-- INICIO UPDATE CAMPOS

-- // AREA DE PERSONAL

UPDATE ODS.HM_PERSONAL
SET desAreaPersonal = CASE desAreaPersonal
WHEN 'EMPLEADO ESTABLE 1' THEN 'LÍDER DE LINEA'
WHEN 'OBRERO CONT. INDEF.' THEN 'OBRERO ESTABLE'
WHEN 'OBRERO EVENTUAL' THEN 'OBRERO CONTRATADO'
WHEN 'OBRERO CONTRAT.' THEN 'OBRERO CONTRATADO'
WHEN 'OBRERO CONT. FIJO' THEN 'OBRERO CONTRATADO'
WHEN 'EMPLEADO CONT.INDEF.' THEN 'EMPLEADO ESTABLE'
WHEN 'PASANTE' THEN 'PRACTICANTE PRE-PROFESIONAL'
WHEN 'FUNCIONARIO' THEN 'EMPLEADO ESTABLE'
WHEN 'EMPLEADO CONT. FIJO' THEN 'EMPLEADO CONTRATADO'
WHEN 'EMPLEADO EVENTUAL' THEN 'EMPLEADO CONTRATADO'
WHEN 'EMPLEADO CONTRAT.' THEN 'EMPLEADO CONTRATADO'
ELSE desAreaPersonal END,
desestadocivil = CASE desestadocivil
WHEN 'cas' THEN 'CASADO'
WHEN 'n.cas.' THEN 'SOLTERO'
WHEN 'sol' THEN 'SOLTERO'
WHEN 'div' THEN 'DIVORCIADO'
WHEN 'conv' THEN 'CONVIVIENTE'
WHEN 'concub' THEN 'CONCUBINO'
WHEN 'sep' THEN 'SEPARADO'
WHEN 'viu' THEN 'VIUDO'
WHEN 'VIUDO/A' THEN 'VIUDO'
WHEN 'Divorciado/a' THEN 'DIVORCIADO'
WHEN 'DIVORCIADA' THEN 'DIVORCIADO'
WHEN 'Convivencia' THEN 'CONVIVIENTE'
WHEN 'CASADO/A' THEN 'CASADO'
WHEN 'Separado/a lega' THEN 'SEPARADO'
WHEN 'SOLTERO/A' THEN 'SOLTERO'
WHEN 'SOLTERA' THEN 'SOLTERO'
WHEN 'CASADA' THEN 'CASADO'
WHEN 'DIVORCIADA' THEN 'DIVORCIADO'
WHEN NULL THEN 'N.D.'
ELSE desestadocivil END,
Sexo = Upper(Sexo),
horario = CASE  horario 
WHEN '5.00' THEN 'Lun. a Vie.'
WHEN '6.00' THEN 'Lun. a Sab.'
ELSE horario END


UPDATE ODS.HM_PERSONAL
SET desAreaPersonal = CASE clasecontrato
WHEN 'Pasantías Ley 26427 -con obra socia' THEN 'PRACTICANTES PRE-PROFESIONAL'
WHEN 'Trabajo eventual.' THEN 'EMPLEADO CONTRATADO'
WHEN 'A Tiempo completo indeterminado /Tr' THEN 'EMPLEADO ESTABLE'
WHEN 'LRT (Directores SA, municipios, org' THEN 'EMPLEADO ESTABLE'
WHEN 'A tiempo parcial determinado (contr' THEN 'EMPLEADO CONTRATADO'
WHEN 'A Tiempo completo  determinado (con' THEN 'EMPLEADO CONTRATADO'
ELSE desAreaPersonal END
WHERE codAreaPersonal = '1'

UPDATE ODS.HM_PERSONAL 
SET desAreaPersonal = CASE clasecontrato
WHEN 'Prac. Profesionales' THEN 'PRACTICANTE PROFESIONAL'
ELSE 'PRACTICANTE PRE-PROFESIONAL' END 
WHERE desAreaPersonal = 'PRACTICANTE'

UPDATE ODS.HM_PERSONAL
SET desAreaPersonal = CASE clasecontrato
WHEN 'A Tiempo completo indeterminado /Tr' THEN 'OBRERO ESTABLE'
ELSE desAreaPersonal END
WHERE codAreaPersonal = '2'


UPDATE ODS.HM_PERSONAL
SET codAreaPersonal = CASE desAreaPersonal
WHEN 'EMPLEADO ESTABLE' THEN 'E1'
WHEN 'EMPLEADO CONTRATADO' THEN 'E2'
WHEN 'OBRERO ESTABLE' THEN 'O1'
WHEN 'OBRERO CONTRATADO' THEN 'O2'
WHEN 'PRACTICANTE PRE-PROFESIONAL' THEN 'P1'
WHEN 'PRACTICANTE' THEN 'P1'
ELSE desAreaPersonal END
WHERE codSociedad = 199

UPDATE ODS.HM_PERSONAL
SET desAreaPersonal = CASE codAreaPersonal
WHEN 'M2' THEN 'EMPLEADO ESTABLE'
WHEN 'M3' THEN 'EMPLEADO ESTABLE'
WHEN 'M4' THEN 'EMPLEADO ESTABLE'
ELSE desAreaPersonal END
WHERE codSociedad = 105


-- // CLASE DE CONTRATO
UPDATE ODS.HM_PERSONAL
SET clasecontrato = CASE desAreaPersonal 
WHEN 'EMPLEADO CONTRATADO' THEN 'Limitado'
WHEN 'EMPLEADO ESTABLE' THEN 'Ilimitado'
WHEN 'OBRERO CONTRATADO' THEN 'limitado'
WHEN 'OBRERO ESTABLE' THEN 'Ilimitado'
WHEN 'PRACTICANTE' THEN 'Modalidad formativa'
ELSE clasecontrato END

UPDATE ODS.HM_PERSONAL
SET clasecontrato = CASE clasecontrato
WHEN 'Pasantías Ley 26427 -con obra socia' THEN 'Modalidad formativa'
WHEN 'Trabajo eventual.' THEN 'Limitado'
WHEN 'A Tiempo completo indeterminado /Tr' THEN 'Ilimitado'
WHEN 'LRT (Directores SA, municipios, org' THEN 'Ilimitado'
WHEN 'A tiempo parcial determinado (contr' THEN 'Limitado'
WHEN 'A Tiempo completo  determinado (con' THEN 'Limitado'
ELSE clasecontrato END


-- // FLAG EMPLEADO

UPDATE ODS.HM_PERSONAL
SET flgEmpleado = 'S'
WHERE codAreaPersonal IN ('E1','E0','E2','P1','K1','K4','K2','N1','N2','P3','1')

-- // SEXO

UPDATE ODS.HM_PERSONAL
SET SEXO = 'MASCULINO'
WHERE sexo = 'M'

UPDATE ODS.HM_PERSONAL
SET SEXO = 'FEMENINO'
WHERE sexo = 'F'

-- // NIVEL ORGANIZACIONAL


UPDATE ODS.HM_PERSONAL
SET desNivelOrg = '5. PRACTICANTE',desSubNivelOrg = '5.1. ' + desAreaPersonal
WHERE desAreaPersonal = 'PRACTICANTE PROFESIONAL'
UPDATE ODS.HM_PERSONAL
SET desNivelOrg = '5. PRACTICANTE',desSubNivelOrg = '5.2. ' + desAreaPersonal
WHERE desAreaPersonal = 'PRACTICANTE PRE-PROFESIONAL'


UPDATE ODS.HM_PERSONAL
SET desNivelOrg = CASE desSubNivelOrg
WHEN '1.1. ALTA GERENCIA - GERENTE GENERAL' THEN '1. ALTA GER.'
WHEN '1.2. ALTA GERENCIA - VICEPRESIDENTE' THEN '1. ALTA GER.' 
WHEN '2.1. EJECUTIVO - MANAGING DIRECTOR' THEN'2. EJECUTIVO'
WHEN '2.2. EJECUTIVO - DIRECTOR' THEN '2. EJECUTIVO'
WHEN '2.3. EJECUTIVO - GERENTE' THEN '2. EJECUTIVO'
WHEN '3.1. MANDO MEDIO - SENIOR' THEN '3. MAN. MED.'
WHEN '3.2. MANDO MEDIO - PLENO' THEN '3. MAN. MED.'
WHEN '4.1. CONTRIBUIDOR INDIVIDUAL - SENIOR' THEN '4. CON. IND.'
WHEN '4.2. CONTRIBUIDOR INDIVIDUAL - PLENO' THEN '4. CON. IND.'
WHEN '4.3. CONTRIBUIDOR INDIVIDUAL - JUNIOR' THEN '4. CON. IND.'
WHEN '5.1. PRACTICANTE PROFESIONAL' THEN '5. PRACTICANTE'
WHEN '5.2. PRACTICANTE PRE-PROFESIONAL' THEN '5. PRACTICANTE'
ELSE desNivelOrg END

UPDATE ODS.HM_PERSONAL
SET desNivelOrg = UPPER(desNivelOrg),desSubNivelOrg=UPPER(desSubNivelOrg)


UPDATE ODS.HM_PERSONAL
SET desNivelOrg = 'N.D.'
Where desNivelOrg IS NULL

UPDATE ODS.HM_PERSONAL
SET desSubNivelOrg = 'N.D.'
Where desSubNivelOrg IS NULL


-- // FLAG EMPLEADO

UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(01)3150800','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(054)232880','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(056)265900','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(064)244750','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(01)4657273','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(074)234121','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(051)322478','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(044)721270','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(044)242661','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(01)4652065','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(01)3326370','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(073)327786','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(064)513692','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(01)4820100','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(084)270151','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(066)317866','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(094)252384','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(01)3153800','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(511)239419','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(054)725611','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(044)322681','')))
UPDATE ODS.HM_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(064)571322','')))


-- // EDIFICIO - OFICINA - SUBDIVISION

UPDATE ODS.HM_PERSONAL
SET desEdificio = UPPER(desEdificio),desOficina=UPPER(desOficina),
desSubDivision=UPPER(desSubDivision)


-- // Vicepresidencia y Dirección

UPDATE ODS.HM_PERSONAL
SET desVP = 'N.D.'
Where desVP IS NULL


UPDATE ODS.HM_PERSONAL
SET desVP = UPPER(desVP)

UPDATE ODS.HM_PERSONAL
SET desDireGer = 'N.D.'
Where desDireGer IS NULL

UPDATE ODS.HM_PERSONAL
SET desDireGer = UPPER(desDireGer)


-- // FLG ACTIVO Y FLGCESE

UPDATE ODS.HM_PERSONAL 
SET FLGACTIVO = 'S',flgCese = 'N'

UPDATE ODS.HM_PERSONAL 
SET FLGCESE = 'S'
WHERE dbo.FN_TOCODMES(FECBAJA) = CODMES
AND FECBAJA IS NOT NULL

UPDATE ODS.HM_PERSONAL 
SET FLGACTIVO = 'N'
WHERE FECBAJA  < EOMONTH(convert(datetime,CONVERT(varchar,CODMES)+'01',104))
AND FECBAJA IS NOT NULL

------------------------------------------------------

-- // Sociedades

UPDATE ODS.HM_PERSONAL
SET desSociedad = CASE codSociedad
WHEN 101 THEN	'ALICORP PERÚ S.A.A.'
WHEN 103 THEN	'CODISA'
WHEN 105 THEN	'ALICORP COLOMBIA S.A'
WHEN 106 THEN	'MOLINCA'
WHEN 107 THEN	'ALICORP ECUADOR'
WHEN 108 THEN	'PRO ORIENTE'
WHEN 110 THEN	'ALICORP HONDURAS'
WHEN 112 THEN	'INBALNOR- VITAPRO ECUADOR'
WHEN 120 THEN	'ALICORP ARGENTINA S.C.A.'               
WHEN 121 THEN	'ALICORP SAN JUAN S.A.'                  
WHEN 125 THEN	'SANFORD S.A.C.I.F.I.Y.A.'                
WHEN 164 THEN	'VITAPRO ECUADOR'
WHEN 199 THEN	'GLOBAL PERÚ'
WHEN 703 THEN	'ALICORP URUGUAY'
WHEN 720 THEN	'ITALO MANERA S.A.'
WHEN 721 THEN	'PASTAS ESPECIALES S.A.'
WHEN 730 THEN	'VITAPRO CHILE'
WHEN 731 THEN	'CETECSAL -VITAPRO CHILE'
WHEN 736 THEN	'INDUSTRIAS TEAL S.A'
WHEN 737 THEN	'VITAPRO PERÚ S.A.'
WHEN 738 THEN	'MASTERBREAD S.A.'
WHEN 752 THEN	'VITAPRO PERÚ S.A.'
ELSE desSociedad END	

UPDATE ODS.HM_PERSONAL
SET Pais = CASE codSociedad
WHEN 101 THEN	'PERÚ'
WHEN 103 THEN	'PERÚ'
WHEN 105 THEN	'COLOMBIA'
WHEN 106 THEN	'PERÚ'
WHEN 107 THEN	'ECUADOR'
WHEN 108 THEN	'PERÚ'
WHEN 110 THEN	'HONDURAS'
WHEN 112 THEN	'ECUADOR'
WHEN 120 THEN	'ARGENTINA'               
WHEN 121 THEN	'ARGENTINA'                  
WHEN 125 THEN	'ARGENTINA'                
WHEN 164 THEN	'ECUADOR'
WHEN 199 THEN	'PERÚ'
WHEN 703 THEN	'URUGUAY'
WHEN 720 THEN	'ARGENTINA'
WHEN 721 THEN	'ARGENTINA'
WHEN 730 THEN	'CHILE'
WHEN 731 THEN	'CHILE'
WHEN 736 THEN	'PERÚ'
WHEN 737 THEN	'PERÚ'
WHEN 738 THEN	'PERÚ'
WHEN 752 THEN	'PERÚ'
ELSE Pais END	

-- // PREDIO

UPDATE ODS.HM_PERSONAL 
SET Predio = CASE codEdificio
WHEN 'E34' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E07' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E06' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E41' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E40' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E03' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E02' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E08' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E43' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E35' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E33' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'M01' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E10' THEN 'TRUJILLO'
WHEN 'E46' THEN 'APT CERCADO - LIMA'
WHEN 'E45' THEN 'CENTRO DE DISTRIBUCIÓN RANSA - LIMA'
WHEN 'E04' THEN 'MOLINO CALLAO - LIMA'
WHEN 'E05' THEN 'MOLINO SANTA ROSA - LIMA'
WHEN 'E12' THEN 'AREQUIPA'
WHEN 'E14' THEN 'AREQUIPA'
WHEN 'E18' THEN 'AYACUCHO'
WHEN 'E42' THEN 'CAJAMARCA'
WHEN 'E19' THEN 'CHICLAYO'
WHEN 'E20' THEN 'CHIMBOTE'
WHEN 'E15' THEN 'CUZCO'
WHEN 'E22' THEN 'HUACHO'
WHEN 'E23' THEN 'HUANCAYO'
WHEN 'E24' THEN 'HUÁNUCO'
WHEN 'PO30' THEN 'HUÁNUCO'
WHEN 'E25' THEN 'HUARAZ'
WHEN 'E26' THEN 'ICA'
WHEN 'E27' THEN 'IQUITOS'
WHEN 'E16' THEN 'JULIACA'
WHEN 'E28' THEN 'PIURA'
WHEN 'E29' THEN 'PUCALLPA'
WHEN 'PO20' THEN 'PUCALLPA'
WHEN 'BA01' THEN 'SAN ISIDRO - LIMA'
WHEN 'E17' THEN 'TACNA'
WHEN 'E30' THEN 'TARAPOTO'
WHEN 'PO10' THEN 'TARAPOTO'
WHEN 'E32' THEN 'TRUJILLO'
WHEN 'E11' THEN 'TUMBES'
ELSE Pais END

--- FIN UPDATE ---

EXEC dbo.SP_EXPATRIADOS_Y_NO_RELEV_P_NOMINA

END

GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_HM_PERSONAL_HIST]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_HM_PERSONAL_HIST]

AS
BEGIN	
	
	--///------------------------------
	--   2014 - 2015 - 2016
	--///------------------------------


-- 1er Grupo de Consistencia--

	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = 'No Disponible',desSubNivelOrg = 'No Disponible'
	WHERE CODMES<=201505

	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = 'No Disponible', desSubNivelOrg = 'No Disponible'
	WHERE codSociedad IN (736,199,731,730,107)


	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = 'No Disponible',desSubNivelOrg = 'No Disponible'
	WHERE (RTRIM(desAreaPersonal) NOT IN ('EMPLEADO CONTRATADO','EMPLEADO ESTABLE','PRACTICANTE PRE-PROFESIONAL','PRACTICANTE PROFESIONAL'))


-- 2. Update de Niveles Organizacionales


	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '2. EJECUTIVO',desSubNivelOrg = '2.1. EJECUTIVO - MANAGING DIRECTOR'
	WHERE CODEMPLEADO = 1300241 AND CODMES IN (201506,201507,201508,201509,201510,201511,201512)


	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '4. CON. IND.',desSubNivelOrg = '4.3. CONTRIBUIDOR INDIVIDUAL - JUNIOR'
	WHERE CODEMPLEADO = 15005 AND CODMES=201607

	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '2. EJECUTIVO',desSubNivelOrg = '2.3. EJECUTIVO - GERENTE'
	WHERE CODEMPLEADO = 26651 AND CODMES=201608

	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '2. EJECUTIVO',desSubNivelOrg = '2.3. EJECUTIVO - GERENTE'
	WHERE CODEMPLEADO = 16161 AND CODMES=201506


	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '2. EJECUTIVO',desSubNivelOrg = '2.3. EJECUTIVO - GERENTE'
	WHERE CODEMPLEADO = 20914 AND CODMES BETWEEN 201601 AND 201612

	
	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '4. CON. IND.',desSubNivelOrg = '4.2. CONTRIBUIDOR INDIVIDUAL - PLENO'
	WHERE CODEMPLEADO = 22205 AND CODMES BETWEEN 201601 AND 201612
	
	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '4. CON. IND.',desSubNivelOrg = '4.3. CONTRIBUIDOR INDIVIDUAL - JUNIOR'
	WHERE CODEMPLEADO = 22204 AND CODMES BETWEEN 201601 AND 201612


	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '2. EJECUTIVO',desSubNivelOrg = '2.2. EJECUTIVO - DIRECTOR'
	WHERE CODEMPLEADO = 16161 AND CODMES=201507


	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '4. CON. IND.',desSubNivelOrg = '4.3. CONTRIBUIDOR INDIVIDUAL - JUNIOR'
	WHERE CODEMPLEADO = 9967 AND CODMES=201607

	
	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '4. CON. IND.',desSubNivelOrg = '4.3. CONTRIBUIDOR INDIVIDUAL - JUNIOR'
	WHERE CODEMPLEADO = 11693 AND CODMES=201602


	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '4. CON. IND.',desSubNivelOrg = '4.2. CONTRIBUIDOR INDIVIDUAL - PLENO'
	WHERE CODEMPLEADO = 11692 AND CODMES IN (201506,201507)

	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '4. CON. IND.',desSubNivelOrg = '4.3. CONTRIBUIDOR INDIVIDUAL - JUNIOR'
	WHERE CODEMPLEADO = 25118 AND CODMES IN (201506,201507)

	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '2. EJECUTIVO',desSubNivelOrg = '2.1. EJECUTIVO - MANAGING DIRECTOR'
	WHERE CODEMPLEADO = 1300241 AND CODMES >=201506 

	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '4. CON. IND.',desSubNivelOrg = '4.2. CONTRIBUIDOR INDIVIDUAL - PLENO'
	WHERE CODEMPLEADO = 1300280 AND CODMES =201506

	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '4. CON. IND.',desSubNivelOrg = '4.3. CONTRIBUIDOR INDIVIDUAL - JUNIOR'
	WHERE CODEMPLEADO IN (16232,15910) AND CODMES IN (201607)
	
	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '4. CON. IND.',desSubNivelOrg = '4.3. CONTRIBUIDOR INDIVIDUAL - JUNIOR'
	WHERE CODEMPLEADO IN (19303) AND CODMES IN (201601)

	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '4. CON. IND.',desSubNivelOrg = '4.2. CONTRIBUIDOR INDIVIDUAL - PLENO'
	WHERE CODEMPLEADO = 19303 AND CODMES IN (201602,201603)

	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '4. CON. IND.',desSubNivelOrg = '4.1. CONTRIBUIDOR INDIVIDUAL - SENIOR'
	WHERE CODEMPLEADO = 27140 AND CODMES IN (201612)


	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '2. EJECUTIVO',desSubNivelOrg = '2.2. EJECUTIVO - DIRECTOR'
	WHERE CODEMPLEADO = 1600003 AND CODMES BETWEEN 201601 AND 201612


	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '2. EJECUTIVO',desSubNivelOrg = '2.3. EJECUTIVO - GERENTE'
	WHERE CODEMPLEADO = 1600002 AND CODMES BETWEEN 201601 AND 201612

	
	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '2. EJECUTIVO',desSubNivelOrg = '2.3. EJECUTIVO - GERENTE'
	WHERE CODEMPLEADO = 1600002 AND CODMES BETWEEN 201601 AND 201612

	
	UPDATE ODS.HM_PERSONAL
	SET desNivelOrg = '3. MAN. MED.',desSubNivelOrg = '3.2. MANDO MEDIO - PLENO'
	WHERE CODEMPLEADO = 1600012 AND CODMES BETWEEN 201601 AND 201612
	

	UPDATE ODS.HM_PERSONAL 
	SET desNivelOrg = 'No Disponible',desSubNivelOrg = 'No Disponible'
	where desNivelOrg = 'N/A' OR desNivelOrg IS NULL


--- 4. Actualización de VP, DIRECCIÓN, CECO y UO

	UPDATE  ODS.HM_PERSONAL  
	SET desVP  = NULL,codVP = NULL WHERE  codVP = '00000000'
	UPDATE  ODS.HM_PERSONAL  
	SET desDireGer  = NULL WHERE desDireGer = '00000000'

	--Actualizaciones por persona

	UPDATE ODS.HM_PERSONAL
	SET  CODCECO = '101MG0101' , DESCECO = 'Molienda Trigo MSR' , CODUO = '10000201' , DESUO = 'HARINAS INDUSTRIALES - MO'
	WHERE CODEMPLEADO = 5635 AND CODMES=201401

	UPDATE ODS.HM_PERSONAL
	SET CODCECO = '752MV0103' , DESCECO = 'PROD. ACUICOLA PECES' , CODFUNCION = '21100251' , DESFUNCION = 'CATEGORIA 5 OBREROS PROVINCIA'
	, CODUO = '21100006' , DESUO = 'PRODUCCION ACUICOLA PECES'
	WHERE CODEMPLEADO = 1300337 AND CODMES=201609

	UPDATE ODS.HM_PERSONAL
	SET CODCECO = '752MV0103' , DESCECO = 'PROD. ACUICOLA PECES' , CODFUNCION = '21100251' , DESFUNCION = 'CATEGORIA 5 OBREROS PROVINCIA'
	, CODUO = '21100006' , DESUO = 'PRODUCCION ACUICOLA PECES'
	WHERE CODEMPLEADO = 1300338 AND CODMES=201609
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='DIRECCION COMERCIAL NNA CENTRO AMERICA'
	WHERE CODEMPLEADO = 24759
	AND CODMES = 201608

	-----------------------------------------------------------------------------------------------

	-- Actualizaciones por Sociedad
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL TEAL',CODVP = 'N.D.',desDireGer = 'GERENCIA GENERAL TEAL'
	WHERE codSociedad = '736' AND CODMES BETWEEN 201401 AND 201712
	

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '21100251',desDireGer = 'ALICORP URUGUAY'
	WHERE codSociedad = '703' AND CODMES BETWEEN 201401 AND 201712

	UPDATE ODS.HM_PERSONAL SET desDireGer = CASE CODUO
	WHEN '22000002' THEN 'GERENCIA DE NEGOCIOS MASTERBREAD'
	WHEN '22000001' THEN 'GERENCIA GENERAL MASTERBREAD'
	WHEN '22000003' THEN 'OPERACIONES MB'
	WHEN '22000004' THEN 'COMERCIAL MB'
	ELSE desDireGer END, DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000460'
	WHERE codSociedad = '738'
	AND CODMES BETWEEN 201401 AND 201712

	-----------------------------------------------------------------------------------------------

		
	--- VP SUPPLY CHAIN ---------------------------------------------------------------------------

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO', CODVP = '10000258',desDireGer ='GENERAL GENERAL MOLINCA'
	WHERE codSociedad = 106
			 
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000473',desDireGer='DIRECCION DE CALIDAD Y SEGUR.CORPORATIVO'
	WHERE (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL) 
	AND CODCECO IN ('101UC0416','101UC0603','101UA0402','101UA0403','101UA0404','101UA0405','101UA0406',
	'101UC0411','101UC0619','101UC0606','101UC0610','101UC0604','101UC0404','101UB0403')
	AND CODMES BETWEEN 201401 AND 201712

	UPDATE ODS.HM_PERSONAL 
	SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000473',desDireGer='DIRECCION DE MANUFACTURA PERU'
	WHERE (CODCECO LIKE '101MA%' OR CODCECO LIKE '101MK%'  OR CODCECO LIKE '101MG%' OR CODCECO LIKE '101MT%'
	OR CODCECO LIKE '101MS%' OR CODCECO LIKE '101MJ%' OR CODCECO LIKE '101MH%' OR CODCECO LIKE '101MI%' OR CODCECO LIKE '101UC03%')
	AND (DESVP IS NULL OR DESVP = '00000000')
	AND CODMES BETWEEN 201401 AND 201712


	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000473',desDireGer='DIRECCION DE MANUFACTURA PERU'
	WHERE (DESVP IS NULL OR desDireGer IS NULL) AND CODCECO IN ('10000160','101MA0203','101MA0204','101MA0207','101MA9941','101MA9981','101MH0101',
	'101MH0102','101MI0103','101MJ0101','101MK0101','101MK1001','101MK9902','101UA0203','101UC0303','101UC0306','101MA0201','101MA0205','101MA0206',
	'101MA0208','101MA0209','101MA0210','101UC0221','101MA0503','101MA0501','101MA0402','101MA0502','101MA9902','101MA9903','101UC0220','101UC0305',
	'101UC0605','101MU0101','101MO0101','101MA0401','101MA0501','101MA0208','101MA0209','101MA0502','101MA9981','101MA0203','101MA9903','101MA0201',
	'101MA0206','101MA0205','101MA0405','101MA0402''101MA0401','101MA9904','101MA9941','101MA0404','101MA0101','101MA0210','101MA9902','101MA0207',
	'101MA0301','101MA0503','101MA0204','101MT0101','101MK0110','101MT0101''101MT9991','101MT0601','101MT0201','101MT0301','101MT0701','101MT0001',
	'101MG0101','101MI0101','101MK2001','101MH0110','101MS0102','101MN0101','101MI0110','101UC0304','101UA0211','101MG0110','101UA0219','101UC0307',
	'101MI0110','101UA0214','101UA0208','101UA0220','101UC0203','101UC0207','101UC0206','101UC0208','101MS0105','101MS0102','101MS0101','101MS9991')
	AND CODMES BETWEEN 201401 AND 201712
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000015',desDireGer='DIRECCION DE MANUFACTURA PERU'
	WHERE (CODCECO LIKE '101UC02%' OR CODCECO LIKE '101UC03%') AND CODMES BETWEEN 201401 AND 201612 AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)


	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000015',desDireGer='DIRECCION DE MANUFACTURA PERU'
	WHERE CODCECO LIKE '101UB02%' AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201506

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000473',desDireGer ='DIRECCION DE MANUFACTURA PERU'
	WHERE (DESVP IS NULL OR desDireGer IS NULL) AND CODCECO IN ('101AH0505') AND CODMES BETWEEN 201401 AND 201507
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000258',desDireGer ='DIRECCION DE MANUFACTURA PERU'
	WHERE (DESVP IS NULL OR desDireGer IS NULL) AND CODCECO IN ('101UC0621')
	AND CODMES BETWEEN 201401 AND 201401

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000258',desDireGer ='DIRECCION DE MANUFACTURA PERU'
	WHERE (DESVP IS NULL OR desDireGer IS NULL) AND CODCECO IN ('101UA0215')
	AND CODMES BETWEEN 201401 AND 201509

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000258',desDireGer ='DIRECCION DE MANUFACTURA PERU'
	WHERE (DESVP IS NULL OR desDireGer IS NULL) AND CODCECO IN ('101MU9991')
	AND CODMES BETWEEN 201401 AND 201402
			
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000473',desDireGer='DIRECCION DE DISTRIBUCION'
	WHERE (DESVP IS NULL OR desDireGer IS NULL) AND CODCECO IN
	 ('101AG0112','101AG0116','101AG0215','101AG0217','101AG0101','101AG0102','101AG0103','101AG0109','101AG0119','101AF0201','101AF0101',
	'101AG0201','101AG0202','101AG0203','101AG0204','101AG0208','101AG0211','101AG0116','101AG0205','108AG0102','108AG0101')
	AND CODMES BETWEEN 201401 AND 201712
		

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000473',desDireGer='DIRECCION DE DISTRIBUCION'
	WHERE (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL) AND CODCECO LIKE '101AG%'
	AND CODMES BETWEEN 201401 AND 201712

	UPDATE ODS.HM_PERSONAL 
	SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000473',desDireGer='DIRECCION DE CALIDAD Y SEGUR.CORPORATIVO'
	WHERE (CODCECO LIKE '101UC04%' ) AND (DESVP IS NULL OR DESVP IS NULL) AND CODMES BETWEEN 201401 AND 201712
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000015',desDireGer='DIRECCION DE TECNOLOGIA INDUSTRIAL'
	WHERE CODCECO IN ('101UC0510','101UC0511') 
	AND CODMES BETWEEN 201510 AND 201612
			
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000473',desDireGer='DIRECCION PLANEAM. CORPORATIVO Y PERU'
	WHERE (DESVP IS NULL OR DESVP IS NULL) AND CODCECO IN ('101AH0505') AND CODMES BETWEEN 201508 AND 201712
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000015',desDireGer='DIRECCION PLANEAM. CORPORATIVO Y PERU'
	WHERE CODCECO LIKE '101AH05%' AND CODMES BETWEEN 201401 AND 201712 AND (DESVP IS NULL OR desDireGer IS NULL)
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000473',desDireGer='DIRECCION PLANEAM. CORPORATIVO Y PERU'
	WHERE (DESVP IS NULL OR desDireGer IS NULL) AND CODCECO IN ('101AH0512','101AH0101','101AH0510','101AH0513','101AH0507','101AH0508','101AH0509','101AH0511',
	'101UC0101','101UC0102') AND CODMES BETWEEN 201401 AND 201712
			
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. SUPPLY CHAIN CORPORATIVO',CODVP = '10000015',desDireGer='DIRECCION DE COMPRAS Y COM.EXT.CORPORATI'
	WHERE (DESVP IS NULL OR desDireGer IS NULL) AND CODCECO IN ('101AH0702','101AH0703','101AH0701','101AB1112','101AB0112') 
	AND CODMES BETWEEN 201401 AND 201712
		

	-----------------------------------------------------------------------------------------------


	----------- RECURSOS HUMANOS --------------------------------------------------------

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000460',desDireGer = 'GERENCIA DE CAPACITACION Y SELECCION'
	WHERE CODCECO IN ('101AB0138','101AB0137') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201412

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000447',desDireGer ='DIRECCION DE RELACIONES LABORALES'
	WHERE CODCECO IN ('101AB0173')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201505

		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000447',desDireGer ='DIRECCION CORP. DE RELACIONES LABORALES'
	WHERE CODCECO IN ('101AB0173')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201511 AND 201512


	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000447',desDireGer ='BUSINESS PARTNER SUPPLY / FINANZAS'
	WHERE CODCECO IN ('101AB1129')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201501 AND 201505

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000447',desDireGer ='BUSINESS PARTNER NEGOCIO'
	WHERE CODCECO IN ('101AB1128')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201501 AND 201505
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000447',desDireGer ='DIRECCION DE COMPENS. Y SOP.CORPORATIVO'
	WHERE CODCECO IN ('101AB1127')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201501 AND 201503

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000447',desDireGer ='BUSINESS PARTNER CMP / NPI / AACC / CI'
	WHERE CODCECO IN ('101AB1130')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201504 AND 201509

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000447',desDireGer ='DIRECCIÓN DE RR.HH - BUSINESS PARTNER'
	WHERE CODCECO IN ('101AB1130')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201510 AND 201512

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000447',desDireGer ='DIRECCION DE COMPENS. Y SOP.CORPORATIVO'
	WHERE CODCECO IN ('101AB0107')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201505
			
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000460', desDireGer = 'DIRECCION DE COMPENS. Y SOP.CORPORATIVO'
	WHERE CODCECO IN ('101AB0153') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201503
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000460', desDireGer = 'ADMINISTRACION DE RECURSOS HUMANOS'
	WHERE CODCECO IN ('101AB0153') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201504 AND 201505

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000460',desDireGer = 'GERENCIA CORPORATIVA DE DESARROLLO ORGAN'
	WHERE CODCECO IN ('101AB0172') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201505

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. RECURSOS HUMANOS CORPORATIVO',CODVP = '10000447',desDireGer ='V.P. RECURSOS HUMANOS CORPORATIVOS'
	WHERE CODCECO IN ('101AB0108')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201612

	----------------------------------------------------------------------------------------------


	-----------FINANZAS CORPORATIVOS -------------------------------------------------

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000015',desDireGer ='PLANEAMIENTO FINANCIERO Y CONTROL DE GES'
	WHERE CODCECO IN ('101AB0111') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201404
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000015',desDireGer ='PLANEAMIENTO FINANCIERO Y CONTROL DE GES'
	WHERE CODCECO IN ('101AB1111') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201506


	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000258',desDireGer ='FINANZAS CORPORATIVAS'
	WHERE CODCECO IN ('101AB1113')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201405
			
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000258',desDireGer ='DIRECCION DE CONTRALORIA CORPORATIVA'
	WHERE CODCECO IN ('101AB1115','101AB1116')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201501 AND 201505


	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000258',desDireGer ='PLANEAMIENTO FINANCIERO Y CONTROL DE GES'
	WHERE CODCECO IN ('101AB1121')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201404 AND 201412

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000258',desDireGer ='PLANEAMIENTO FINANCIERO CMP'
	WHERE CODCECO IN ('101AB1121')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201501 AND 201505

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000258',desDireGer ='PLANEAMIENTO FINANCIERO AF Y NPI'
	WHERE CODCECO IN ('101AB1122')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201404 AND 201503


	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000258',desDireGer ='DIRECCION DE CONTRALORIA CORPORATIVA'
	WHERE CODCECO IN ('101AB1123')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201404 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000258',desDireGer ='PLANEAMIENTO FINANCIERO Y CONTROL DE GES'
	WHERE CODCECO IN ('101AB1124')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201404 AND 201505

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000015',desDireGer ='DIRECCION DE ADMINISTRACION CORPORATIVO'
	WHERE CODCECO IN ('101AB0177','101AB0178','101AB0191')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201712
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000015',desDireGer='No Disponible'
	WHERE CODCECO IN ('101AC9905') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000015',desDireGer ='DIRECCION DE CONTRALORIA CORPORATIVA'
	WHERE CODCECO IN ('101AB0103')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000015',desDireGer ='DIRECCION DE FINANZAS CORP.Y RELAC. INVE'
	WHERE CODCECO IN ('101AB0105')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000015',desDireGer ='DIRECCION DE CONTRALORIA CORPORATIVA'
	WHERE CODCECO IN ('101AB0167') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000015',desDireGer ='V.P. FINANZAS CORPORATIVO'
	WHERE CODCECO IN ('101AB0135') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000025',desDireGer ='DIRECCION DE CONTRALORIA CORPORATIVA'
	WHERE CODCECO IN ('101AB0181') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201410 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. FINANZAS CORPORATIVO',CODVP = '10000025',desDireGer ='DIRECCION DE ADMINISTRACION CORPORATIVO'
	WHERE CODCECO IN ('101AB0191') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201410 AND 201612

	----------------------------------------------------------------------------------------------

	---------- ALICORP SOLUCIONES ------------------------------------------------------------------

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO PRODUCTOS INDUSTRIALES',CODVP = '10000447',desDireGer ='DIRECCION DE NEG.FOODSERVICE Y GRAN IND.'
	WHERE CODCECO IN ('101UA0506')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201503

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO PRODUCTOS INDUSTRIALES',CODVP = '10000447',desDireGer ='DIRECCION DE NEGOCIO PANIFIC E INDUSTRIA'
	WHERE CODCECO IN ('101UA0506')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201504 AND 201505

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000258',desDireGer ='GERENCIA DE PRODUCTOS NATIVOS'
	WHERE CODCECO IN ('101UA0702')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201503 AND 201506

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO PRODUCTOS INDUSTRIALES',CODVP = '10000258',desDireGer ='GERENCIA DE PRODUCTOS NATIVOS'
	WHERE CODCECO IN ('101UA0702')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201502

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO PRODUCTOS INDUSTRIALES',CODVP = '10000258',desDireGer ='DIRECCION COMERCIAL NPI'
	WHERE CODCECO IN ('101UA0701')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201502

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000258',desDireGer ='DIRECCION DE NEGOCIO PANIFIC E INDUSTRIA'
	WHERE CODCECO IN ('101UA0701')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201503 AND 201505

	UPDATE ODS.HM_PERSONAL SET desDireGer = 'V.P. NEGOCIO PRODUCTOS INDUSTRIALES', DESVP = 'V.P. NEGOCIO PRODUCTOS INDUSTRIALES',CODVP = '10000460'
	WHERE CODCECO IN ('101UA0101') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201503
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000025',desDireGer ='DIRECCION COMERCIAL NNA - REGION ANDINA'
	WHERE CODCECO IN ('101AB0170') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201412

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000025',desDireGer ='DIRECCION DE NUTRICION Y DESARROLLO NNA'
	WHERE CODCECO IN ('101AB0314') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201403 AND 201403

	UPDATE ODS.HM_PERSONAL SET desDireGer = 'GERENCIA DE CENTRO DE INNOVACION', DESVP = 'V.P. NEGOCIO PRODUCTOS INDUSTRIALES',CODVP = '10000460'
	WHERE CODCECO IN ('101AD9921','101AD9920','101AB0315') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201503

	UPDATE ODS.HM_PERSONAL SET desDireGer = 'GERENCIA INTELIGENCIA NEGOCIOS', DESVP = 'V.P. NEGOCIO PRODUCTOS INDUSTRIALES',CODVP = '10000460'
	WHERE CODCECO IN ('101AD9967') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201503
	
	UPDATE ODS.HM_PERSONAL SET desDireGer = 'DIRECCION DE NUTRICION Y DESARROLLO NNA', DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000460'
	WHERE CODCECO = '101UB0402' AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000473',desDireGer='DIRECCION DE NEG.FOODSERVICE Y GRAN IND.'
	WHERE CODCECO IN ('101AD9912','101AD9913','101AD9909') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL) 
	AND  CODMES BETWEEN 201401 AND 201503
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000473',desDireGer='DIRECCION NEGOCIO GASTRONOMIA'
	WHERE CODCECO IN ('101AD9912','101AD9913','101AD9909') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL) 
	AND  CODMES BETWEEN 201504 AND 201612
			
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000473',desDireGer='DIRECCION DE NEG.FOODSERVICE Y GRAN IND.'
	WHERE CODCECO IN ('101UA0512') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL) 
	AND  CODMES BETWEEN 201401 AND 201503
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000473',desDireGer='DIRECCION DE NEGOCIO PANIFIC'
	WHERE CODCECO IN ('101UA0512') AND(DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL) 
	AND  CODMES BETWEEN 201504 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000460',desDireGer = 'GERENCIA DE CENTRO DE INNOVACION'
	WHERE CODCECO IN ('101AD9921','101AD9920','101AB0315') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201504 AND 201712

			
	UPDATE ODS.HM_PERSONAL SET desDireGer = 'DIRECCION COMERCIAL NPI', DESVP = 'V.P. NEGOCIO PRODUCTOS INDUSTRIALES',CODVP = '10000460'
	WHERE CODCECO IN ('101UA0801','101UA0104') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201503

	UPDATE ODS.HM_PERSONAL SET desDireGer = 'DIRECCION DE NEGOCIO PANIFIC', DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000460'
	WHERE CODCECO IN ('101UA0801','101UA0104') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201504 AND 201612

	UPDATE ODS.HM_PERSONAL SET desDireGer = 'DIRECCION COMERCIAL NPI', DESVP = 'V.P. NEGOCIO PRODUCTOS INDUSTRIALES',CODVP = '10000460'
	WHERE CODCECO IN ('101UA0802','101UA0803')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201503

	UPDATE ODS.HM_PERSONAL SET desDireGer = 'DIRECCION DE NEGOCIO PANIFIC', DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000460'
	WHERE CODCECO IN ('101UA0802','101UA0803') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201504 AND 201612
		

	UPDATE ODS.HM_PERSONAL SET desDireGer = 'DIRECCION COMERCIAL NPI', DESVP = 'V.P. NEGOCIO PRODUCTOS INDUSTRIALES',CODVP = '10000460'
	WHERE CODCECO IN ('101AD9922','101AD9925','101UA0514') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201503

	UPDATE ODS.HM_PERSONAL SET desDireGer = 'GERENCIA INTELIGENCIA NEGOCIOS', DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000460'
	WHERE CODCECO IN ('101AD9922','101AD9925') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201504 AND 201612



	UPDATE ODS.HM_PERSONAL SET desDireGer = 'GERENCIA INTELIGENCIA NEGOCIOS', DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000460'
	WHERE CODCECO IN ('101AD9967') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201504 AND 201612
	

	UPDATE ODS.HM_PERSONAL SET desDireGer = 'GERENCIA  DE DESARROLLO DE NEG.PROD.IND.', DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000460'
	WHERE CODCECO LIKE '101UA0601%' AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201510 AND 201612



	UPDATE ODS.HM_PERSONAL SET desDireGer = 'V.P. ALICORP SOLUCIONES', DESVP = 'V.P. ALICORP SOLUCIONES',CODVP = '10000460'
	WHERE CODCECO IN ('101UA0101') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201504 AND 201612



	----------------------------------------------------------------------------------------------	


		
	---------CONSUMO MASIVO INTERNACIONAL------------------------------------------------------------------------------------------------------------------

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO INTERNACIONAL',CODVP = '10000460',desDireGer = 'DIRECCION COMERCIAL CONSUMO MASIVO INTER'
	WHERE CODCECO IN ('101AD9923') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201407

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO INTERNACIONAL',CODVP = '10000258',desDireGer ='PLANEAMIENTO Y COMERCIO EXTERIOR'
	WHERE CODCECO IN ('105MW9841')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201501 AND 201507

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO INTERNACIONAL',CODVP = '10000258',desDireGer ='ADMINISTRACION Y FINANZAS - COLOMBIA'
	WHERE CODCECO IN ('105AB0109')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201405

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO INTERNACIONAL',CODVP = '10000258',desDireGer ='GERENCIA COMERCIAL COLOMBIA'
	WHERE CODCECO IN ('105AD9905')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201409 AND 201508

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO INTERNACIONAL',CODVP = '10000460',desDireGer = 'DIRECCION DE FINANZAS CMI'
	WHERE CODCECO IN ('101AB0501','101AB1101') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201712
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO INTERNACIONAL', CODVP = '10000258',desDireGer ='General Gereneral Alicorp Ecuador'
	WHERE codSociedad = 107

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO INTERNACIONAL',CODVP = '10000258',desDireGer ='GERENCIA GENERAL URUGUAY'
	WHERE CODCECO IN ('101AB1102')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201505

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO INTERNACIONAL',CODVP = '10000025',desDireGer ='DIRECCION COMERCIAL CONSUMO MASIVO INTER'
	WHERE CODCECO IN ('101AB0503') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201404 AND 201505


	-------------------------------------------------------------------------------------------------------------------------------------------------------
	
	
	-----------CONSUMO MASIVO -----------------------------------------------------------------------------------------------------------------------------


	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000025',desDireGer = 'DIRECCION COMERCIAL CONSUMO MASIVO PERU'
	WHERE DESVP IS NULL AND CODCECO IN ('101AC9909','101AC9909','101AD0102','101AD0103','101AD0105','101AD0108','101AD0109','101AD0113','101AD0114',
	'101AD0119','101AD0120','101AD0120','101AD0122','101AD0123','101AD0134','101AD0134','101AD0137','101AD0137','101AD0138','101AD0140','101AD0140',
	'101AD0141','101AD0141','101AD0142','101AD0142','101AD9908','101AH0301') 
	AND CODMES BETWEEN 201401 AND 201612

		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. MARKETING CORPORATIVO',CODVP = '10000258',desDireGer ='GERENCIA DE SERVICIOS PUB. MEDIOS Y PROM'
	WHERE CODCECO IN ('101AB0120')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201407
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000025',desDireGer ='GERENCIA DE SERVICIOS DE MARKETING'
	WHERE CODCECO IN ('101AB0120') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201408 AND 201601

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000025',desDireGer ='DIRECCION DE SERVICIOS DE MARKETING'
	WHERE CODCECO IN ('101AB0120')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201602 AND 201612

			
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000025',desDireGer ='DIRECCION COMERCIAL CONSUMO MASIVO PERU'
	WHERE CODCECO IN ('101AD9924','101AD9917','101AD9902','101AD9940','101AD9918') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201612


	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. MARKETING CORPORATIVO',CODVP = '10000258',desDireGer ='DIRECCION DE MARKETING OLEAGINOSOS'
	WHERE CODCECO IN ('101ML9996')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201407
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000025',desDireGer ='DIRECCION DE MARK. OLEAGINOSOS Y FARINAC'
	WHERE CODCECO IN ('101ML9996') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201408 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000015',desDireGer='PLANEAMIENTO FINANCIERO CMP'
	WHERE CODCECO IN ('101AC9901') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. MARKETING CORPORATIVO',CODVP = '10000258',desDireGer ='DIRECCION MARKETING CONOCIMIENTO CONS.'
	WHERE CODCECO IN ('101AB0124','101AB0406')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201407
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000025',desDireGer ='DIRECCION MARKETING CONOCIMIENTO CONS.'
	WHERE CODCECO IN ('101AB0124','101AB0406') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201408 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. MARKETING CORPORATIVO',CODVP = '10000258',desDireGer ='MARKETING SALSAS, AYUD.CUL, REF Y POSTRE'
	WHERE CODCECO IN ('101AB0130','101AB0132')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201407
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000025',desDireGer ='MARKETING SALSAS, AYUD.CUL, REF Y POSTRE'
	WHERE CODCECO IN ('101AB0130','101AB0132') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201408 AND 201612

		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. MARKETING CORPORATIVO',CODVP = '10000258',desDireGer ='DIRECCION DE MARKETING FARINACEOS'
	WHERE CODCECO IN ('101AB0162')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201407

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000258',desDireGer ='DIRECCION DE MARKETING FARINACEOS'
	WHERE CODCECO IN ('101AB0162')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201408 AND 201503
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000025',desDireGer ='DIRECCION DE MARK. OLEAGINOSOS Y FARINAC'
	WHERE CODCECO IN ('101AB0162') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201504 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000015',desDireGer='DIRECCION DE INV. DES. E INNOVACIÓN TEC.'
	WHERE CODCECO IN ('101UC0501','101UC0502','101UC0503','101UC0505','101UC0506','101UC0507','101UC0512','101UC0515') 
	AND CODMES BETWEEN 201510 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. MARKETING CORPORATIVO',CODVP = '10000258',desDireGer ='V.P. MARKETING CORPORATIVO'
	WHERE CODCECO IN ('101AB0401')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201407

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000258',desDireGer ='DIRECCION COMERCIAL CONSUMO MASIVO PERU'
	WHERE CODCECO IN ('108AD0104','108AD0102','108AD0101')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201405
						

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. MARKETING CORPORATIVO',CODVP = '10000258',desDireGer ='DIRECCION DE MARKETING CUIDADO DEL HOGAR'
	WHERE CODCECO IN ('101ML9997')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201407
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. CONSUMO MASIVO PERU',CODVP = '10000025',desDireGer ='DIRECCION DE MARKETING CUIDADO DEL HOGAR'
	WHERE CODCECO IN ('101ML9997') AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201408 AND 201612




	---------------------------------------------------------------------------------------------------------------------------------------


		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000015',desDireGer='MANUFACTURA NNA'
	WHERE CODCECO LIKE '101MV%' AND CODMES BETWEEN 201401 AND 201411 AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)




	-----------GERENCIA GENERAL-------------------------------------------------------------------------------------------------

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL',CODVP = '10000025',desDireGer ='GERENCIA DE GESTION DE PROYECTOS'
	WHERE CODCECO IN ('101AB1110') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201412 AND 201502

		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL',CODVP = '10000025',desDireGer ='GERENCIA DE CONSULTORIA INTERNA'
	WHERE CODCECO IN ('101AB1110') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201504 AND 201504

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL',CODVP = '10000015',desDireGer='DIRECCION DE DESARR.TECNOL.CORPORATIVO'
	WHERE CODCECO LIKE '101UC05%' AND CODMES BETWEEN 201401 AND 201509
		
	UPDATE ODS.HM_PERSONAL SET desDireGer = 'DIRECCION DE DESARR.TECNOL.CORPORATIVO', DESVP = 'GERENCIA GENERAL',CODVP = '10000460'
	WHERE CODCECO LIKE '101UA0601%' AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201509

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL',CODVP = '10000447',desDireGer ='GERENCIA DE ASUNTOS CORPORATIVOS'
	WHERE CODCECO IN ('101AB0169')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201509

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL',CODVP = '10000015',desDireGer ='GERENCIA DE CONSULTORIA INTERNA'
	WHERE CODCECO IN ('101AB0102')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201501 AND 201505

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL',CODVP = '10000015',desDireGer = 'GERENCIA GENERAL'
	WHERE CODCECO IN ('101AB0101') AND CODMES BETWEEN 201401 AND 201612

	------------------------------------------------------------------------------------------------------------



	------- VITAPRO -----------------------------------------

	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000015',desDireGer = 'GERENCIA PLANTA INBALNOR'
	WHERE CODCECO IN ('112MV0102') AND CODMES BETWEEN 201401 AND 201406
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000015',desDireGer = 'GERENCIA PLANTA INBALNOR'
	WHERE CODCECO IN ('112MV0102') AND CODMES BETWEEN 201407 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000015',desDireGer = 'MANUFACTURA NNA'
	WHERE CODCECO IN ('737MV0104') AND CODMES BETWEEN 201408 AND 201612
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU', CODVP = '10000258',desDireGer ='MANUFACTURA NNA'
	WHERE CODCECO LIKE '737M%'

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='GERENCIA GENERAL VITAPRO PERU'
	WHERE CODCECO IN ('752AB0101')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='MANUFACTURA NNA'
	WHERE CODCECO IN ('737UB0206','737UB0203')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201609

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='GERENCIA PLANTA INBALNOR'
	WHERE CODCECO IN ('112UB0206','112UB0402')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='GERENCIA PLANTA INBALNOR'
	WHERE CODCECO IN ('112UB0206','112UB0402','112UB0203')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201712
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='CONTABILIDAD'
	WHERE CODCECO IN ('164AB0103')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='CONTABILIDAD'
	WHERE CODCECO IN ('164AB0103')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='GERENCIA RRHH Y ADMINIST. ECUADOR'
	WHERE CODCECO IN ('164AB0108')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='GERENCIA RRHH Y ADMINIST. ECUADOR'
	WHERE CODCECO IN ('164AB0108')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='ADMINISTRACION'
	WHERE CODCECO IN ('164AB0109')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='ADMINISTRACION'
	WHERE CODCECO IN ('164AB0109')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 2016712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='GERENCIA DE LOGISTICA ECUADOR'
	WHERE CODCECO IN ('164AB0113')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='COMERCIO EXTERIOR'
	WHERE CODCECO IN ('164AB0113')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='GERENCIA TECNICA NNA ECUADOR'
	WHERE CODCECO IN ('164AD0151')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='GERENCIA TECNICA NNA ECUADOR'
	WHERE CODCECO IN ('164AD0151')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='GERENCIA VENTAS NNA ECUADOR'
	WHERE CODCECO IN ('164AD9903')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='GERENCIA VENTAS NNA ECUADOR'
	WHERE CODCECO IN ('164AD9903')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='ALMACEN NNA GYE'
	WHERE CODCECO IN ('164AG0213')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='ALMACEN NNA GYE'
	WHERE CODCECO IN ('164AG0213')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='ALMACEN NNA MACHALA'
	WHERE CODCECO IN ('164AG0214')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='ALMACEN NNA MACHALA'
	WHERE CODCECO IN ('164AG0214')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201712
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='PLANIFICACION'
	WHERE CODCECO IN ('164AG0215')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='PLANIFICACION'
	WHERE CODCECO IN ('164AG0215')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='ASUNTOS REGULATORIOS'
	WHERE CODCECO IN ('164AD0104')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201405 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='ALMACEN MATERIAS PRIMAS MILAGRO'
	WHERE CODCECO IN ('164AG0216')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='ALMACEN MATERIAS PRIMAS MILAGRO'
	WHERE CODCECO IN ('164AG0216')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='V.P. NEGOCIO DE NUTRICION ANIMAL'
	WHERE CODCECO IN ('737AB0101')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='GERENCIA GENERAL VITAPRO PERU'
	WHERE CODCECO IN ('737AB0101')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201612
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='MANUFACTURA NNA'
	WHERE CODCECO IN ('737AG0201','737AH0503')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201503

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='PLANEAMIENTO, DISTRIBUCION Y COMEX'
	WHERE CODCECO IN ('737AG0201','737AH0503')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201504 AND 201609
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='MANUFACTURA NNA'
	WHERE CODCECO IN ('737UB0108')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201505		
		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='DIRECCION DE NUTRICION Y DESARROLLO NNA'
	WHERE CODCECO IN ('737UB0301')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201609

		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU', CODVP = '10000258',desDireGer ='MANUFACTURA NNA'
	WHERE CODCECO LIKE '752M%'   AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='ALMACEN MATERIAS PRIMAS MILAGRO'
	WHERE CODCECO IN ('164AG0212')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='ALMACEN MATERIAS PRIMAS MILAGRO'
	WHERE CODCECO IN ('164AG0212')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201612	


	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='GERENCIA DE LOGISTICA ECUADOR'
	WHERE CODCECO IN ('164AG9901')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='GERENCIA DE LOGISTICA ECUADOR'
	WHERE CODCECO IN ('164AG9901')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='DIRECCION DE NUTRICION Y DESARROLLO NNA'
	WHERE CODCECO IN ('737UB0402')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='DIRECCION DE NUTRICION Y DESARROLLO NNA'
	WHERE CODCECO IN ('737UB0402')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201601

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='MANUFACTURA NNA'
	WHERE CODCECO IN ('737UB0402')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201602 AND 201612	

		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='PLANEAMIENTO, DISTRIBUCION Y COMEX'
	WHERE CODCECO IN ('737AG0203')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201412 AND 201609

		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='PLANEAMIENTO, DISTRIBUCION Y COMEX'
	WHERE CODCECO IN ('752AG0201')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201609 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='GERENCIA PLANTA INBALNOR'
	WHERE CODCECO IN ('112UB0203')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='GERENCIA PLANTA INBALNOR'
	WHERE CODCECO IN ('112UB0203')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201612


	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='MANUFACTURA NNA'
	WHERE CODCECO IN ('737UB0604')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='MANUFACTURA NNA'
	WHERE CODCECO IN ('737UB0604')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201612

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='GERENCIA DE MARKETING NNA'
	WHERE CODCECO IN ('737UB0801')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='GERENCIA DE MARKETING NNA'
	WHERE CODCECO IN ('737UB0801')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201612

		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='GERENCIA PLANTA INBALNOR'
	WHERE CODCECO IN ('112AD9905')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201405 AND 201405

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='GERENCIA PLANTA INBALNOR'
	WHERE CODCECO IN ('112AD9905')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201406 AND 201409

				
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='PLANEAMIENTO, DISTRIBUCION Y COMEX'
	WHERE CODCECO IN ('737AG0202')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201503


	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='CONTABILIDAD'
	WHERE CODCECO IN ('164AB0103')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201405 AND 201406

		UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000015',desDireGer ='MANUFACTURA NNA'
	WHERE CODCECO IN ('101MV0102','101MV0104','101MV0103')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201407

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000015',desDireGer ='DIRECCION DE NUTRICION Y DESARROLLO NNA'
	WHERE CODCECO IN ('101MB0101')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201404

		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='SALUD ECUADOR'
	WHERE CODCECO IN ('164AB0118')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201608 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='FINANZAS ECUADOR'
	WHERE CODCECO IN ('164AB0135')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201405 AND 201612


	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='MARKETING NNA'
	WHERE CODCECO IN ('164AD0103')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201409 AND 201503


	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='GERENCIA TECNICA NNA ECUADOR'
	WHERE CODCECO IN ('164AD0151')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='MANUFACTURA NNA'
	WHERE CODCECO IN ('752UB0604')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201610 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='PLANEAMIENTO, DISTRIBUCION Y COMEX'
	WHERE CODCECO IN ('752AG0203')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201610 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='GERENCIA GENERAL VITAPRO PERU'
	WHERE CODCECO IN ('752AB0170')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201610 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='GERENCIA GENERAL VITAPRO PERU'
	WHERE CODCECO IN ('737AB0170')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201501 AND 201609

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='DIRECCION COMERCIAL NNA CENTRO AMERICA'
	WHERE CODCECO IN ('737UB0702')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201407 AND 201503

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='DIRECCION DE ASISTENCIA TECNICA CAM'
	WHERE CODCECO IN ('737UB0105')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201503 AND 201505

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='DIRECCION DE FINANZAS'
	WHERE CODCECO IN ('737AB0125')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201501 AND 201504

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='PLANEAMIENTO, DISTRIBUCION Y COMEX'
	WHERE CODCECO IN ('737AB0121')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201501 AND 201503

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='PLANEAMIENTO, DISTRIBUCION Y COMEX'
	WHERE CODCECO IN ('752AH0503')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201610 AND 201712

		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='PROYECTOS Y MANTENIMIENTO PNT'
	WHERE CODCECO IN ('752UB0203')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201610 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='DIRECCION DE NUTRICION Y DESARROLLO NNA'
	WHERE CODCECO IN ('752UB0301')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201610 AND 201712

		
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='MANUFACTURA NNA'
	WHERE CODCECO IN ('752UB0402')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201610 AND 201712

	UPDATE ODS.HM_PERSONAL SET DESVP =  'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='RECURSOS HUMANOS'
	WHERE CODCECO IN ('105AB0108')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201401

			
	UPDATE ODS.HM_PERSONAL SET DESVP =  'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000258',desDireGer ='GERENCIA PLANTA INBALNOR'
	WHERE CODCECO IN ('112AB0101')  AND (DESVP IS NULL OR DESVP = '00000000' OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201401

	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='RRHH INBALNOR'
	WHERE CODCECO IN ('112AB0108')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201503 AND 201504

	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000015',desDireGer='DIRECCION COMERCIAL NNA CENTRO AMERICA'
	WHERE CODCECO IN ('101UB0105') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000015',desDireGer='MANUFACTURA NNA'
	WHERE CODCECO IN ('101UB0101') AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406

	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='DIRECCION DE CONTRALORIA CORPORATIVA'
	WHERE CODCECO IN ('110AD0140')  AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201502 AND 201712
	
	UPDATE ODS.HM_PERSONAL SET DESVP = 'V.P. NEGOCIO DE NUTRICION ANIMAL',CODVP = '10000015',desDireGer='DIRECCION DE NUTRICION Y DESARROLLO NNA'
	WHERE CODCECO LIKE '101UB03%' AND (DESVP IS NULL OR desDireGer IS NULL)
	AND CODMES BETWEEN 201401 AND 201406


	-------------------------------------------------------
	------MODELO DE GOBIERNO-------------------------------


	--UPDATE ODS.HM_PERSONAL SET DESVP = 'GERENCIA GENERAL VITAPRO PERU',CODVP = '10000258',desDireGer ='DIRECCION DE CONTRALORIA CORPORATIVA'
	--WHERE CODCECO IN ('110AD0140')  AND (DESVP IS NULL OR desDireGer IS NULL)
	--AND CODMES BETWEEN 201701 AND 201702


	-------------------------------------------------------



	--UPDATE ODS.HM_PERSONAL 
	--SET desDireGer = 'No Disponible'
	--WHERE desDireGer IS NULL


	SELECT codceco,count(*) FROM ODS.HM_PERSONAL
	WHERE (DESVP IS NULL OR DESVP = 'N.D.') and codmes>201701
	and pais not in ('CHILE','ARGENTINA')
	and flgEmpleado = 'S'
	group by codceco
	order by count(*) desc

	SELECT * FROM ODS.HM_PERSONAL
	WHERE (DESVP IS NULL OR DESVP = 'N.D.') and codmes>201701
	and pais not in ('CHILE','ARGENTINA')
	and flgEmpleado = 'S'
	and codceco = '101AB1101'


END


GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_MD_CESES]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_MD_CESES]

AS
BEGIN	
	
--- 3. Actualización de MOTIVOS DE RENUNCIA -------------


	SELECT
	J.codEmpleado,j.fecbaja,j.MotivoRenuncia,j.SubMotivoRenuncia,j.desAreaPersonal,j.codsociedad,j.desSociedad,
	c.clasecontrato,c.MotivoMedida,c.SubmotivoMedida
	INTO #t1
	FROM ODS.MD_PERSONAL J
	INNER JOIN ods.HM_CESADOS c on j.codEmpleado = c.CODEMPLEADO 
	WHERE J.CODSOCIEDAD NOT IN (0)--(125,721,120,731,730,720)
	AND J.fecbaja IS NOT NULL

	--Ecuador, Colombia y Honduras
		
	UPDATE ODS.MD_PERSONAL
	SET 
	ODS.MD_PERSONAL.MotivoRenuncia = ISNULL((SELECT MotivoMedida FROM #t1 C WHERE C.codempleado = ODS.MD_PERSONAL.codEmpleado),
	ODS.MD_PERSONAL.MotivoRenuncia),
	ODS.MD_PERSONAL.SubMotivoRenuncia = ISNULL((SELECT MotivoMedida FROM #t1 C WHERE C.codempleado = ODS.MD_PERSONAL.codEmpleado),
	ODS.MD_PERSONAL.SubMotivoRenuncia)
	WHERE ODS.MD_PERSONAL.fecbaja IS NOT NULL
	AND ODS.MD_PERSONAL.CODSOCIEDAD IN (112,164,110,105,107)
	
	--Alicorp Perú y Otros
	
	--UPDATE #t1 SET MotivoRenuncia = MotivoMedida
	--WHERE SubmotivoMedida=SubMotivoRenuncia and SubmotivoMedida is not null
	--AND codSociedad IN (101,736,752,108,106,737,199)	
		
	UPDATE ODS.MD_PERSONAL
	SET 
	ODS.MD_PERSONAL.MotivoRenuncia = ISNULL((SELECT MotivoMedida FROM #t1 C WHERE C.codempleado = ODS.MD_PERSONAL.codEmpleado),
	ODS.MD_PERSONAL.MotivoRenuncia),
	ODS.MD_PERSONAL.SubMotivoRenuncia = ISNULL((SELECT SubmotivoMedida FROM #t1 C WHERE C.codempleado = ODS.MD_PERSONAL.codEmpleado),
	ODS.MD_PERSONAL.SubMotivoRenuncia)
	WHERE ODS.MD_PERSONAL.fecbaja IS NOT NULL
	AND ODS.MD_PERSONAL.CODSOCIEDAD IN (101,736,752,108,106,737,199,738,112,164,110,105,107)		
	AND ODS.MD_PERSONAL.MotivoRenuncia IS NULL

	--SELECT * FROM #T1

	DROP TABLE #t1
	
	UPDATE ODS.MD_PERSONAL SET MotivoRenuncia = NULL,SubMotivoRenuncia = NULL
	WHERE fecbaja IS NULL

	--select * from ods.HM_CESADOS where CODEMPLEADO = 25758

	--select codEmpleado,nombres,apellidos,desAreaPersonal,codSociedad,desSociedad
	--,fecBaja,MotivoRenuncia,SubMotivoRenuncia from ods.MD_PERSONAL where codEmpleado = 25758

	IF (SELECT COUNT(*) FROM ODS.MD_PERSONAL 
		WHERE SubMotivoRenuncia IS NULL and fecbaja IS NOT NULL
		 AND CODSOCIEDAD IN (101,736,752,108,106,737,199,738,112,164,110,105,107)
		 --AND dbo.FN_TOCODMES(FECBAJA)<dbo.FN_TOCODMES(GETDATE())
		)>0
	 SELECT 1/0;  

	--VALIDACIÓN
	SELECT codEmpleado,nombres,apellidos,desAreaPersonal,codSociedad,desSociedad,fecBaja,MotivoRenuncia,SubMotivoRenuncia FROM ODS.MD_PERSONAL 
		WHERE SubMotivoRenuncia IS NULL and fecbaja IS NOT NULL
		 AND CODSOCIEDAD IN (101,736,752,108,106,737,199,738,112,164,110,105,107)
		 	-- AND dbo.FN_TOCODMES(FECBAJA)<dbo.FN_TOCODMES(GETDATE())
END

--EXEC [SP_UPDATE_MD_CESES]

GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_MD_PERSONAL]    Script Date: 10/04/2017 01:59:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_UPDATE_MD_PERSONAL]
AS
BEGIN

-- // AREA DE PERSONAL

UPDATE ODS.MD_PERSONAL
SET desAreaPersonal = CASE desAreaPersonal
WHEN 'EMPLEADO ESTABLE 1' THEN 'LÍDER DE LINEA'
WHEN 'OBRERO CONT. INDEF.' THEN 'OBRERO ESTABLE'
WHEN 'OBRERO EVENTUAL' THEN 'OBRERO CONTRATADO'
WHEN 'OBRERO CONTRAT.' THEN 'OBRERO CONTRATADO'
WHEN 'OBRERO CONT. FIJO' THEN 'OBRERO CONTRATADO'
WHEN 'EMPLEADO CONT.INDEF.' THEN 'EMPLEADO ESTABLE'
WHEN 'PASANTE' THEN 'PRACTICANTE PRE-PROFESIONAL'
WHEN 'FUNCIONARIO' THEN 'EMPLEADO ESTABLE'
WHEN 'EMPLEADO CONT. FIJO' THEN 'EMPLEADO CONTRATADO'
WHEN 'EMPLEADO EVENTUAL' THEN 'EMPLEADO CONTRATADO'
WHEN 'EMPLEADO CONTRAT.' THEN 'EMPLEADO CONTRATADO'
ELSE desAreaPersonal END,
desestadocivil = CASE desestadocivil
WHEN 'cas' THEN 'CASADO'
WHEN 'n.cas.' THEN 'SOLTERO'
WHEN 'sol' THEN 'SOLTERO'
WHEN 'div' THEN 'DIVORCIADO'
WHEN 'conv' THEN 'CONVIVIENTE'
WHEN 'concub' THEN 'CONCUBINO'
WHEN 'sep' THEN 'SEPARADO'
WHEN 'viu' THEN 'VIUDO'
WHEN 'VIUDO/A' THEN 'VIUDO'
WHEN 'Divorciado/a' THEN 'DIVORCIADO'
WHEN 'DIVORCIADA' THEN 'DIVORCIADO'
WHEN 'Convivencia' THEN 'CONVIVIENTE'
WHEN 'CASADO/A' THEN 'CASADO'
WHEN 'Separado/a lega' THEN 'SEPARADO'
WHEN 'SOLTERO/A' THEN 'SOLTERO'
WHEN 'SOLTERA' THEN 'SOLTERO'
WHEN 'CASADA' THEN 'CASADO'
WHEN 'DIVORCIADA' THEN 'DIVORCIADO'
WHEN NULL THEN 'N.D.'
ELSE desestadocivil END,
Sexo = Upper(Sexo),
horario = CASE  horario 
WHEN '5.00' THEN 'Lun. a Vie.'
WHEN '6.00' THEN 'Lun. a Sab.'
ELSE horario END
UPDATE ODS.MD_PERSONAL
SET desAreaPersonal = CASE clasecontrato
WHEN 'Pasantías Ley 26427 -con obra socia' THEN 'PRACTICANTES PRE-PROFESIONAL'
WHEN 'Trabajo eventual.' THEN 'EMPLEADO CONTRATADO'
WHEN 'A Tiempo completo indeterminado /Tr' THEN 'EMPLEADO ESTABLE'
WHEN 'LRT (Directores SA, municipios, org' THEN 'EMPLEADO ESTABLE'
WHEN 'A tiempo parcial determinado (contr' THEN 'EMPLEADO CONTRATADO'
WHEN 'A Tiempo completo  determinado (con' THEN 'EMPLEADO CONTRATADO'
ELSE desAreaPersonal END
WHERE codAreaPersonal = '1'

UPDATE ODS.MD_PERSONAL 
SET desAreaPersonal = CASE clasecontrato
WHEN 'Prac. Profesionales' THEN 'PRACTICANTE PROFESIONAL'
ELSE 'PRACTICANTE PRE-PROFESIONAL' END 
WHERE desAreaPersonal = 'PRACTICANTE'

UPDATE ODS.MD_PERSONAL
SET desAreaPersonal = CASE clasecontrato
WHEN 'A Tiempo completo indeterminado /Tr' THEN 'OBRERO ESTABLE'
ELSE desAreaPersonal END
WHERE codAreaPersonal = '2'

UPDATE ODS.MD_PERSONAL
SET codAreaPersonal = CASE desAreaPersonal
WHEN 'EMPLEADO ESTABLE' THEN 'E1'
WHEN 'EMPLEADO CONTRATADO' THEN 'E2'
WHEN 'OBRERO ESTABLE' THEN 'O1'
WHEN 'OBRERO CONTRATADO' THEN 'O2'
WHEN 'PRACTICANTE PRE-PROFESIONAL' THEN 'P1'
WHEN 'PRACTICANTE' THEN 'P1'
ELSE desAreaPersonal END
WHERE codSociedad = 199


UPDATE ODS.MD_PERSONAL
SET desAreaPersonal = CASE codAreaPersonal
WHEN 'M2' THEN 'EMPLEADO ESTABLE'
WHEN 'M3' THEN 'EMPLEADO ESTABLE'
WHEN 'M4' THEN 'EMPLEADO ESTABLE'
ELSE desAreaPersonal END
WHERE codSociedad = 105

-- // CLASE DE CONTRATO
UPDATE ODS.MD_PERSONAL
SET clasecontrato = CASE desAreaPersonal 
WHEN 'EMPLEADO CONTRATADO' THEN 'Limitado'
WHEN 'EMPLEADO ESTABLE' THEN 'Ilimitado'
WHEN 'OBRERO CONTRATADO' THEN 'limitado'
WHEN 'OBRERO ESTABLE' THEN 'Ilimitado'
WHEN 'PRACTICANTE' THEN 'Modalidad formativa'
ELSE clasecontrato END

UPDATE ODS.MD_PERSONAL
SET clasecontrato = CASE clasecontrato
WHEN 'Pasantías Ley 26427 -con obra socia' THEN 'Modalidad formativa'
WHEN 'Trabajo eventual.' THEN 'Limitado'
WHEN 'A Tiempo completo indeterminado /Tr' THEN 'Ilimitado'
WHEN 'LRT (Directores SA, municipios, org' THEN 'Ilimitado'
WHEN 'A tiempo parcial determinado (contr' THEN 'Limitado'
WHEN 'A Tiempo completo  determinado (con' THEN 'Limitado'
ELSE clasecontrato END


-- // FLAG EMPLEADO

UPDATE ODS.MD_PERSONAL
SET flgEmpleado = 'S'
WHERE codAreaPersonal IN ('E1','E0','E2','P1','K1','K4','K2','N1','N2','P3','1','M2','M3','M4')


-- // NIVEL ORGANIZACIONAL


UPDATE ODS.MD_PERSONAL
SET desNivelOrg = '5. PRACTICANTE',desSubNivelOrg = '5.1. ' + desAreaPersonal
WHERE desAreaPersonal = 'PRACTICANTE PROFESIONAL'
UPDATE ODS.MD_PERSONAL
SET desNivelOrg = '5. PRACTICANTE',desSubNivelOrg = '5.2. ' + desAreaPersonal
WHERE desAreaPersonal = 'PRACTICANTE PRE-PROFESIONAL'


UPDATE ODS.MD_PERSONAL
SET desNivelOrg = CASE desSubNivelOrg
WHEN '1.1. ALTA GERENCIA - GERENTE GENERAL' THEN '1. ALTA GER.'
WHEN '1.2. ALTA GERENCIA - VICEPRESIDENTE' THEN '1. ALTA GER.' 
WHEN '2.1. EJECUTIVO - MANAGING DIRECTOR' THEN'2. EJECUTIVO'
WHEN '2.2. EJECUTIVO - DIRECTOR' THEN '2. EJECUTIVO'
WHEN '2.3. EJECUTIVO - GERENTE' THEN '2. EJECUTIVO'
WHEN '3.1. MANDO MEDIO - SENIOR' THEN '3. MAN. MED.'
WHEN '3.2. MANDO MEDIO - PLENO' THEN '3. MAN. MED.'
WHEN '4.1. CONTRIBUIDOR INDIVIDUAL - SENIOR' THEN '4. CON. IND.'
WHEN '4.2. CONTRIBUIDOR INDIVIDUAL - PLENO' THEN '4. CON. IND.'
WHEN '4.3. CONTRIBUIDOR INDIVIDUAL - JUNIOR' THEN '4. CON. IND.'
WHEN '5.1. PRACTICANTE PROFESIONAL' THEN '5. PRACTICANTE'
WHEN '5.2. PRACTICANTE PRE-PROFESIONAL' THEN '5. PRACTICANTE'
ELSE desNivelOrg END

UPDATE ODS.MD_PERSONAL
SET desNivelOrg = UPPER(desNivelOrg),desSubNivelOrg=UPPER(desSubNivelOrg)

UPDATE ODS.MD_PERSONAL
SET desNivelOrg = 'N.D.'
Where desNivelOrg IS NULL

UPDATE ODS.MD_PERSONAL
SET desSubNivelOrg = 'N.D.'
Where desSubNivelOrg IS NULL


-- // FLAG EMPLEADO

UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(01)3150800','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(054)232880','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(056)265900','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(064)244750','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(01)4657273','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(074)234121','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(051)322478','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(044)721270','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(044)242661','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(01)4652065','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(01)3326370','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(073)327786','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(064)513692','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(01)4820100','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(084)270151','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(066)317866','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(094)252384','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(01)3153800','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(511)239419','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(054)725611','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(044)322681','')))
UPDATE ODS.MD_PERSONAL
SET anexo = LTRIM(RTRIM(REPLACE(anexo,'(064)571322','')))


-- // SEXO

UPDATE ODS.MD_PERSONAL
SET SEXO = 'MASCULINO'
WHERE sexo = 'M'

UPDATE ODS.MD_PERSONAL
SET SEXO = 'FEMENINO'
WHERE sexo = 'F'

UPDATE ODS.HM_PERSONAL
SET SEXO = 'N.D.'
WHERE sexo IS NULL


-- // EDIFICIO - OFICINA - SUBDIVISION

UPDATE ODS.MD_PERSONAL
SET desEdificio = UPPER(desEdificio),desOficina=UPPER(desOficina),
desSubDivision=UPPER(desSubDivision)

-- // Vicepresidencia y Dirección


UPDATE ODS.MD_PERSONAL
SET desVP = 'N.D.'
Where desVP IS NULL

UPDATE ODS.MD_PERSONAL
SET desVP = UPPER(desVP)

UPDATE ODS.MD_PERSONAL
SET desDireGer = 'N.D.'
Where desDireGer IS NULL

UPDATE ODS.MD_PERSONAL
SET desDireGer = UPPER(desDireGer)



	-------------------------------------------------------
	------AREA DE NOMINA NO RELEVANTE-------------------------------

	UPDATE ODS.MD_PERSONAL
	SET FLGACTIVO = 'N',MotivoRenuncia = NULL, SubMotivoRenuncia = NULL
	WHERE codANomina = '99' AND
	codSociedad IN (736,738,101,752,737)

	-------------------------------------------------------

-- // Sociedades

UPDATE ODS.MD_PERSONAL
SET desSociedad = CASE codSociedad
WHEN 101 THEN	'ALICORP PERÚ S.A.A.'
WHEN 103 THEN	'CODISA'
WHEN 105 THEN	'ALICORP COLOMBIA S.A'
WHEN 106 THEN	'MOLINCA'
WHEN 107 THEN	'ALICORP ECUADOR'
WHEN 108 THEN	'PRO ORIENTE'
WHEN 110 THEN	'ALICORP HONDURAS'
WHEN 112 THEN	'INBALNOR- VITAPRO ECUADOR'
WHEN 120 THEN	'ALICORP ARGENTINA S.C.A.'               
WHEN 121 THEN	'ALICORP SAN JUAN S.A.'                  
WHEN 125 THEN	'SANFORD S.A.C.I.F.I.Y.A.'                
WHEN 164 THEN	'VITAPRO ECUADOR'
WHEN 199 THEN	'GLOBAL PERÚ'
WHEN 703 THEN	'ALICORP URUGUAY'
WHEN 720 THEN	'ITALO MANERA S.A.'
WHEN 721 THEN	'PASTAS ESPECIALES S.A.'
WHEN 730 THEN	'VITAPRO CHILE'
WHEN 731 THEN	'CETECSAL -VITAPRO CHILE'
WHEN 736 THEN	'INDUSTRIAS TEAL S.A'
WHEN 737 THEN	'VITAPRO PERÚ S.A.'
WHEN 738 THEN	'MASTERBREAD S.A.'
WHEN 752 THEN	'VITAPRO PERÚ S.A.'
ELSE desSociedad END	

-- // Sociedades

UPDATE ODS.MD_PERSONAL
SET Pais = CASE codSociedad
WHEN 101 THEN	'PERÚ'
WHEN 103 THEN	'PERÚ'
WHEN 105 THEN	'COLOMBIA'
WHEN 106 THEN	'PERÚ'
WHEN 107 THEN	'ECUADOR'
WHEN 108 THEN	'PERÚ'
WHEN 110 THEN	'HONDURAS'
WHEN 112 THEN	'ECUADOR'
WHEN 120 THEN	'ARGENTINA'               
WHEN 121 THEN	'ARGENTINA'                  
WHEN 125 THEN	'ARGENTINA'                
WHEN 164 THEN	'ECUADOR'
WHEN 199 THEN	'PERÚ'
WHEN 703 THEN	'URUGUAY'
WHEN 720 THEN	'ARGENTINA'
WHEN 721 THEN	'ARGENTINA'
WHEN 730 THEN	'CHILE'
WHEN 731 THEN	'CHILE'
WHEN 736 THEN	'PERÚ'
WHEN 737 THEN	'PERÚ'
WHEN 738 THEN	'PERÚ'
WHEN 752 THEN	'PERÚ'
ELSE Pais END	


-- // PREDIO

UPDATE ODS.MD_PERSONAL 
SET Predio = CASE codEdificio
WHEN 'E34' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E07' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E06' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E41' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E40' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E03' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E02' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E08' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E43' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E35' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E33' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'M01' THEN 'CALLAO PREDIO CENTRAL - LIMA'
WHEN 'E10' THEN 'TRUJILLO'
WHEN 'E46' THEN 'APT CERCADO - LIMA'
WHEN 'E45' THEN 'CENTRO DE DISTRIBUCIÓN RANSA - LIMA'
WHEN 'E04' THEN 'MOLINO CALLAO - LIMA'
WHEN 'E05' THEN 'MOLINO SANTA ROSA - LIMA'
WHEN 'E12' THEN 'AREQUIPA'
WHEN 'E14' THEN 'AREQUIPA'
WHEN 'E18' THEN 'AYACUCHO'
WHEN 'E42' THEN 'CAJAMARCA'
WHEN 'E19' THEN 'CHICLAYO'
WHEN 'E20' THEN 'CHIMBOTE'
WHEN 'E15' THEN 'CUZCO'
WHEN 'E22' THEN 'HUACHO'
WHEN 'E23' THEN 'HUANCAYO'
WHEN 'E24' THEN 'HUÁNUCO'
WHEN 'PO30' THEN 'HUÁNUCO'
WHEN 'E25' THEN 'HUARAZ'
WHEN 'E26' THEN 'ICA'
WHEN 'E27' THEN 'IQUITOS'
WHEN 'E16' THEN 'JULIACA'
WHEN 'E28' THEN 'PIURA'
WHEN 'E29' THEN 'PUCALLPA'
WHEN 'PO20' THEN 'PUCALLPA'
WHEN 'BA01' THEN 'SAN ISIDRO - LIMA'
WHEN 'E17' THEN 'TACNA'
WHEN 'E30' THEN 'TARAPOTO'
WHEN 'PO10' THEN 'TARAPOTO'
WHEN 'E32' THEN 'TRUJILLO'
WHEN 'E11' THEN 'TUMBES'
ELSE Pais END

--- FIN UPDATE ---



END;



GO
