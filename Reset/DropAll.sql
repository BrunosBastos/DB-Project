use LocalDB;

ALTER TABLE Project.[Admin] DROP CONSTRAINT AdminID;
ALTER TABLE Project.Credit  DROP CONSTRAINT CredClient;
ALTER TABLE Project.Reviews DROP CONSTRAINT RevClient ;
ALTER TABLE Project.Reviews DROP CONSTRAINT RevGame 
ALTER TABLE Project.Purchase DROP CONSTRAINT ClientPurchase;
ALTER TABLE Project.Purchase DROP CONSTRAINT GamePurchase;
ALTER TABLE Project.Client DROP CONSTRAINT ClientID ;
ALTER TABLE Project.Game DROP CONSTRAINT   IDCompanyGame ;
ALTER TABLE Project.Game DROP CONSTRAINT   IDFranchiseGame;
ALTER TABLE Project.[Copy] DROP CONSTRAINT CopyGame; 
ALTER TABLE Project.[Copy] DROP CONSTRAINT CopyPlatform;
ALTER TABLE Project.PlatformReleasesGame DROP CONSTRAINT LaunchedGame ;
ALTER TABLE Project.PlatformReleasesGame DROP CONSTRAINT PlatformGame ;
ALTER TABLE Project.DiscountGame DROP CONSTRAINT CodDiscount;
ALTER TABLE Project.DiscountGame DROP CONSTRAINT CodGame ;
ALTER TABLE Project.GameGenre DROP CONSTRAINT  GenGame ;
ALTER TABLE Project.GameGenre DROP CONSTRAINT  GenName;  
ALTER TABLE Project.CompFranchise DROP CONSTRAINT ProducesFranchise; 


DROP TABLE Project.[Admin];
DROP TABLE Project.Client;
DROP TABLE Project.[User];
DROP TABLE Project.Game;
DROP TABLE Project.[Platform];
DROP TABLE Project.Genre;
DROP TABLE Project.Company;
DROP TABLE Project.Franchise;
DROP TABLE Project.CompFranchise;
DROP TABLE Project.Purchase;
DROP TABLE Project.PlatformReleasesGame;
DROP TABLE Project.GameGenre;
DROP TABLE Project.DiscountGame;
DROP TABLE Project.Discount;
DROP TABLE Project.[Copy];
DROP TABLE Project.Reviews;
DROP TABLE Project.Follows;
DROP TABLE Project.Credit;

--Procedures
Drop Proc Project.pd_Login;
Drop Proc Project.pd_sign_up;
DROP PROC Project.pd_getFranchiseData;
DROP PROC Project.pd_getCompData;
drop proc Project.pd_getCompFranchise;
drop proc Project.pd_getGameGenres;

--udfs
Drop function Project.udf_check_email;
Drop function Project.udf_check_username;
Drop function Project.udf_isadmin;
Drop function Project.udf_isclient;
Drop function Project.[udf_checkusersgames];
Drop function Project.[udf_countuserGames];
DROP FUNCTION Project.[udf_userfollowers]
DROP FUNCTION Project.[udf_countuserFollwers];
DROP FUNCTION Project.[udf_checkGameofFollows]
DROP FUNCTION Project.[udf_checkAllGamesinCommon];
DROP FUNCTION Project.[udf_getGameGenres];
DROP FUNCTION Project.[udf_getGamePlataforms];
DROP FUNCTION Project.[udf_getPurchaseInfo];
DROP FUNCTION Project.[udf_getGameDetails];
DROP SCHEMA Project;