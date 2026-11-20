-- ELIMINA IL DATABASE SE ESISTE
USE master;
GO

IF DB_ID('ScuolaDb') IS NOT NULL
BEGIN
    ALTER DATABASE ScuolaDb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ScuolaDb;
END
GO

-- CREA IL DATABASE
CREATE DATABASE ScuolaDb;
GO

USE ScuolaDb;
GO

--------------------------------------------------
-- TABELLA STUDENTI
--------------------------------------------------

CREATE TABLE Studenti
(
    StudenteId INT IDENTITY(1,1) PRIMARY KEY,

    Nome NVARCHAR(50) NOT NULL,
    Cognome NVARCHAR(50) NOT NULL,

    DataNascita DATE NOT NULL,

    Email NVARCHAR(100) UNIQUE,
    Telefono NVARCHAR(20) UNIQUE,

    CodiceFiscale CHAR(16) UNIQUE NOT NULL,

    Attivo BIT DEFAULT 1
);
GO

--------------------------------------------------
-- TABELLA CORSI
--------------------------------------------------

CREATE TABLE Corsi
(
    CorsoId INT IDENTITY(1,1) PRIMARY KEY,

    NomeCorso NVARCHAR(250) NOT NULL,
    Descrizione NVARCHAR(100),
    Crediti INT,
    Durata INT
);
GO

--------------------------------------------------
-- TABELLA DOCENTI
--------------------------------------------------

CREATE TABLE Docenti
(
    DocenteId INT IDENTITY(1,1) PRIMARY KEY,

    Nome NVARCHAR(50) NOT NULL,
    Cognome NVARCHAR(50) NOT NULL,

    Email NVARCHAR(150) UNIQUE NOT NULL,
    Telefono NVARCHAR(20) UNIQUE,

    Specializzazione NVARCHAR(100),

    CodiceFiscale CHAR(16) UNIQUE
);
GO

--------------------------------------------------
-- TABELLA AULE
--------------------------------------------------

CREATE TABLE Aule
(
    AulaId INT IDENTITY(1,1) PRIMARY KEY,

    NomeAula NVARCHAR(100) NOT NULL,
    Capacita INT NOT NULL
);
GO

--------------------------------------------------
-- TABELLA ISCRIZIONI
--------------------------------------------------

CREATE TABLE Iscrizioni
(
    IscrizioneId INT IDENTITY(1,1) PRIMARY KEY,

    StudenteId INT NOT NULL,
    CorsoId INT NOT NULL,

    DataIscrizione DATE DEFAULT CAST(GETDATE() AS DATE),

    FOREIGN KEY (StudenteId)
        REFERENCES Studenti(StudenteId),

    FOREIGN KEY (CorsoId)
        REFERENCES Corsi(CorsoId)
);
GO

--------------------------------------------------
-- TABELLA DOCENTICORSI
--------------------------------------------------

CREATE TABLE DocentiCorsi
(
    DocenteCorsoId INT IDENTITY(1,1) PRIMARY KEY,

    DocenteId INT NOT NULL,
    CorsoId INT NOT NULL,

    FOREIGN KEY (DocenteId)
        REFERENCES Docenti(DocenteId),

    FOREIGN KEY (CorsoId)
        REFERENCES Corsi(CorsoId)
);
GO


INSERT INTO Iscrizioni
(
    StudenteId,
    CorsoId,
    DataIscrizione
)
VALUES
	(1, 1, '2026-11-01'),
	(2, 1, '2026-11-02'),
	(3, 2, '2026-11-03'),
	(4, 3, '2026-11-04'),
	(5, 4, '2026-11-05'),
	(6, 5, '2026-11-06');



