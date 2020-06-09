CREATE SCHEMA Project;
go

CREATE TABLE Project.[User](
    UserID          INT IDENTITY(1,1) ,
    Email           VARCHAR(50) UNIQUE    NOT NULL,
    [Password]        VARBINARY(64)     NOT NULL,
    RegisterDate    DATE            NOT NULL,
    PRIMARY KEY (USERID)
);

CREATE TABLE Project.[Admin](
    UserID      INT,
    PRIMARY KEY (USERID)
);

CREATE TABLE Project.Client(
    UserID          INT,
    Username        VARCHAR(50)   UNIQUE   NOT NULL,
    FullName        VARCHAR(max),
    Sex             CHAR,
    Birth           DATE,
    Balance         DECIMAL(5,2) CHECK (Balance >=0),
    PRIMARY KEY (USERID)
);

CREATE TABLE Project.Follows(
    IDFollower  INT,
    IDFollowed  INT,
    PRIMARY KEY (IDFollower,IDFollowed),
    FOREIGN KEY (IDFollower) REFERENCES Project.Client(UserID),
    FOREIGN KEY (IDFollowed) REFERENCES Project.Client(UserID),
);

CREATE TABLE Project.Credit(

    NumCredit     INT      IDENTITY(1,1)       NOT NULL,
    MetCredit     VARCHAR(20)     NOT NULL,
    DateCredit    DATE            NOT NULL,
    ValueCredit   Decimal(4,2)    NOT NULL,
    IDClient      INT             NOT NULL,
    PRIMARY KEY (NumCredit)
);


CREATE TABLE Project.Reviews(
    IDReview        INT                 IDENTITY(1,1),
    Title           VARCHAR(50)      CHECK(len(Title) > 0)   NOT NULL,
    Text            VARCHAR(280)     CHECK(len(Text) > 0) NOT NULL,
    Rating          DECIMAL(2,1)        NOT NULL,  
    DateReview      DATE                NOT NULL,
    UserID          INT                 NOT NULL,
    IDGame          INT                 NOT NULL,
    PRIMARY KEY (IDReview),
    CONSTRAINT Chk_rat CHECK (Rating >= 0 AND Rating <= 5)          
);

CREATE TABLE Project.Purchase(
    NumPurchase         INT IDENTITY(1,1) ,
    Price               DECIMAL (5,2)      CHECK(Price >= 0) NOT NULL,
    PurchaseDate        DATE                NOT NULL,
    IDClient            INT                 NOT NULL,
    SerialNum           INT                 NOT NULL,
    PRIMARY KEY(NumPurchase)
);

CREATE TABLE Project.Game(

    IDGame          INT				IDENTITY(1,1),
    Name            VARCHAR(50)     NOT NULL,
    Description     VARCHAR(MAX),
    ReleaseDate     DATE            NOT NULL,
    AgeRestriction  INT             NOT NUll,
    CoverImg        VARCHAR(MAX),
    Price           Decimal(5,2)   CHECK(Price >= 0)  NOT NULL,
	IDCompany       INT             NOT NULL,
	IDFranchise    INT,
    CONSTRAINT chk_AgeRestrict CHECK (AgeRestriction >= 1 AND AgeRestriction <= 18),
    PRIMARY KEY(IDGame)
);

CREATE TABLE Project.[Copy](
    SerialNum       INT IDENTITY(100000,1)   NOT NULL,
    IDGame          INT					NOT NULL,
	PlatformName	VARCHAR(30)			NOT NULL,
    PRIMARY KEY(SerialNum)

);


CREATE TABLE Project.Company(
    IDCompany       INT			IDENTITY(1,1),
    Contact         VARCHAR(50), --our contact will only be the email of the companies
    CompanyName     VARCHAR(30) NOT NULL,
    Website         VARCHAR(50) NOT NULL,
    Logo            VARCHAR(MAX),
    FoundationDate  DATE,
    City            VARCHAR(50),
    Country	        VARCHAR(50),
    PRIMARY KEY (IDCompany)
);


CREATE TABLE Project.Discount(

    PromoCode         INT     NOT NULL,
    Percentage        INT     NOT NULL,
    DateBegin         DATE    NOT NULL,
    DateEnd           DATE    NOT NULL,
    PRIMARY KEY(PromoCode),
    CONSTRAINT chk_Discount CHECK (Percentage >= 0 AND Percentage <= 100)
);



CREATE TABLE Project.DiscountGame(

    PromoCode           INT     NOT NULL,
    IDGame              INT     NOT NULL,
    PRIMARY KEY(PromoCode,IDGame),
);


CREATE TABLE Project.[Platform](

    PlatformName       VARCHAR(30)     NOT NULL,
    ReleaseDate         DATE            NOT NULL,
    Producer            VARCHAR(30)     NOT NULL,
    PRIMARY KEY(PlatformName)
);

CREATE TABLE Project.PlatformReleasesGame(

    IDGame          INT             NOT NULL,
    PlatformName  VARCHAR(30)     NOT NULL,
    PRIMARY KEY(IDGame,PlatformName)
);

CREATE TABLE Project.Genre(
    GenName           VARCHAR(25)     NOT NULL,
    Description       VARCHAR(max),
    PRIMARY KEY(GenName)
);

CREATE TABLE Project.GameGenre(
    IDGame          INT         NOT NULL,
    GenName         VARCHAR(25) NOT NULL,
    PRIMARY KEY(IDGame,GenName)
);


CREATE TABLE Project.Franchise(
    IDFranchise    INT				IDENTITY(1,1),
    Name           VARCHAR(30)      NOT NULL,
    Logo       VARCHAR(MAX),
	IDCompany INT NOT NULL, 
    PRIMARY KEY(IDFranchise)
);





-- Foreign keys
ALTER TABLE Project.[Admin] ADD CONSTRAINT AdminID FOREIGN KEY (UserID) REFERENCES Project.[User](UserID);
ALTER TABLE Project.Credit  ADD CONSTRAINT CredClient FOREIGN KEY(IDClient) REFERENCES Project.Client(UserID);
ALTER TABLE Project.Reviews ADD CONSTRAINT RevClient FOREIGN KEY(UserID) REFERENCES Project.Client(UserID);
ALTER TABLE Project.Reviews ADD CONSTRAINT RevGame FOREIGN KEY(IDGame) REFERENCES Project.Game(IDGame);
ALTER TABLE Project.Purchase ADD CONSTRAINT ClientPurchase FOREIGN KEY(IDClient) REFERENCES Project.Client(UserID);
ALTER TABLE Project.Purchase ADD CONSTRAINT GamePurchase FOREIGN KEY(SerialNum) REFERENCES Project.[Copy](SerialNum);
ALTER TABLE Project.Client ADD CONSTRAINT ClientID FOREIGN KEY(UserID) REFERENCES Project.[User](UserID);
ALTER TABLE Project.Game ADD CONSTRAINT   IDCompanyGame  FOREIGN KEY (IDCompany) REFERENCES Project.Company(IDCompany);
ALTER TABLE Project.Game ADD CONSTRAINT   IDFranchiseGame  FOREIGN KEY (IDFranchise) REFERENCES Project.Franchise(IDFranchise);
ALTER TABLE Project.[Copy] ADD CONSTRAINT CopyGame FOREIGN KEY(IDGame) REFERENCES Project.Game(IDGame);
ALTER TABLE Project.[Copy] ADD CONSTRAINT CopyPlatform FOREIGN KEY(PlatformName) REFERENCES Project.[Platform](PlatformName);
ALTER TABLE Project.PlatformReleasesGame ADD CONSTRAINT LaunchedGame FOREIGN KEY(IDGame) REFERENCES Project.Game(IDGame);
ALTER TABLE Project.PlatformReleasesGame ADD CONSTRAINT PlatformGame FOREIGN KEY(PlatformName) REFERENCES Project.[Platform](PlatformName);
ALTER TABLE Project.DiscountGame ADD CONSTRAINT CodDiscount FOREIGN KEY (PromoCode) REFERENCES Project.Discount(PromoCode);
ALTER TABLE Project.DiscountGame ADD CONSTRAINT CodGame FOREIGN KEY (IDGame) REFERENCES Project.Game(IDGame);
ALTER TABLE Project.GameGenre ADD CONSTRAINT  GenGame FOREIGN KEY (IDGame) REFERENCES Project.Game(IDGame);
ALTER TABLE Project.GameGenre ADD CONSTRAINT  GenName FOREIGN KEY (GenName) REFERENCES Project.Genre(GenName);
ALTER TABLE Project.Franchise ADD CONSTRAINT  Comp FOREIGN KEY (IDCompany) REFERENCES Project.Company(IDCompany);