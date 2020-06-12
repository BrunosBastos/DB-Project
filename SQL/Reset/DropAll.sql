use p6g2;


DROP TRIGGER Project.trigger_Admin;
DROP TRIGGER Project.trigger_Client;
DROP TRIGGER Project.trigger_Company;
DROP TRIGGER Project.trigger_review
DROP TRIGGER Project.trigger_credit
DROP TRIGGER Project.trigger_purchase
DROP TRIGGER Project.trigger_insertGames
DROP TRIGGER Project.trigger_Genres
DROP TRIGGER Project.trigger_Franchise
DROP TRIGGER Project.trigger_Platforms
DROP TRIGGER Project.trigger_Discount
DROP TRIGGER Project.trigger_DiscountGame
DROP TRIGGER Project.trigger_User
DROP TRIGGER Project.trigger_insertFollows


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
ALTER TABLE Project.Franchise DROP CONSTRAINT Comp;


DROP TABLE Project.Follows;
DROP TABLE Project.[Admin];
DROP TABLE Project.Client;
DROP TABLE Project.[User];
DROP TABLE Project.Game;
DROP TABLE Project.[Platform];
DROP TABLE Project.Genre;
DROP TABLE Project.Company;
DROP TABLE Project.Franchise;
DROP TABLE Project.Purchase;
DROP TABLE Project.PlatformReleasesGame;
DROP TABLE Project.GameGenre;
DROP TABLE Project.DiscountGame;
DROP TABLE Project.Discount;
DROP TABLE Project.[Copy];
DROP TABLE Project.Reviews;
DROP TABLE Project.Credit;

--Procedures
Drop Proc Project.pd_Login;
Drop Proc Project.pd_sign_up;
DROP PROC Project.pd_insertCredit;
DROP PROC Project.pd_insertReview;
DROP PROC Project.pd_addPlatformToGame
DROP PROC Project.pd_addGameGenre
Drop PROC Project.pd_deleteFollows
DROP PROC Project.pd_filter_CreditHistory
Drop PROC Project.pd_filter_Games
Drop PROC Project.pd_filter_PurchaseHistory
Drop PROC Project.pd_getUserFilter
Drop PROC Project.pd_insert_Games
Drop PROC Project.pd_insertAdmin
Drop PROC Project.pd_insertCompany
Drop PROC Project.pd_insertDiscount
Drop PROC Project.pd_insertDiscountGame
Drop PROC Project.pd_insertFollows
Drop PROC Project.pd_insertFranchise
Drop PROC Project.pd_insertGenres
Drop PROC Project.pd_insertPlatforms
Drop PROC Project.pd_insertPurchase
Drop PROC Project.pd_removeGameDiscount
Drop PROC Project.pd_removeGameGenre
Drop PROC Project.pd_updateCompany
Drop PROC Project.pd_updateDiscount
Drop PROC Project.pd_updateFranchise
Drop PROC Project.pd_updateGame
Drop PROC Project.pd_updateGenre
Drop PROC Project.pd_updatePlatform
Drop PROC Project.pd_UpdateUser



--udfs
Drop function Project.udf_check_email;
Drop function Project.udf_check_username;
Drop function Project.udf_isadmin;
DROP FUNCTION Project.udf_getNumberCompGames;
DROP FUNCTION Project.udf_getNumberFranchiseComp;
DROP FUNCTION Project.udf_getNumberGameFranchises;
DROP FUNCTION Project.udf_getNumberGenreGames;
DROP FUNCTION Project.udf_getNumberOfReviews;
DROP FUNCTION Project.udf_getNumberPlatformGames;

Drop function Project.udf_isclient;
Drop function Project.udf_countuserGames;
DROP FUNCTION Project.udf_userfollowers;
DROP FUNCTION Project.udf_countuserFollowers;
DROP FUNCTION Project.udf_checkGameofFollows;
DROP FUNCTION Project.udf_checkReview;
DROP FUNCTION Project.udf_checkAllGamesinCommon;
DROP FUNCTION Project.udf_checkGameCopies;
DROP FUNCTION Project.udf_checkGameDiscount;
DROP FUNCTION Project.udf_favComp;
DROP FUNCTION Project.udf_favFran;
DROP FUNCTION Project.udf_favGenre;
DROP FUNCTION Project.udf_favPlatform;
DROP FUNCTION Project.udf_getCompanyDetails;
DROP FUNCTION Project.udf_getCompGames;
DROP FUNCTION Project.udf_getFranchiseDetails;
DROP FUNCTION Project.udf_getFranchisesComp;
DROP FUNCTION Project.udf_getGameDetails;
DROP FUNCTION Project.udf_getGameGenres;
DROP FUNCTION Project.udf_getGamePlataforms;
DROP FUNCTION Project.udf_getGamesFranchise;
DROP FUNCTION Project.udf_getGenreDetails;
DROP FUNCTION Project.udf_getGenreGames;
DROP FUNCTION Project.udf_getPlatformGames;
DROP FUNCTION Project.udf_getPlatformDetails;
DROP FUNCTION Project.udf_getPurchaseInfo;
DROP FUNCTION Project.udf_getReviewsList;
DROP FUNCTION Project.udf_getTotalMoney;
DROP FUNCTION Project.udf_leastSoldGames;
DROP FUNCTION Project.udf_most_Sold_Genres;
DROP FUNCTION Project.udf_most_Sold_Platforms;
DROP FUNCTION Project.udf_mostMoneySpent;
DROP FUNCTION Project.udf_mostSoldGames;
DROP FUNCTION Project.udf_checkusersgames;


DROP FUNCTION Project.udf_checkIfFollows;
DROP FUNCTION Project.udf_checkUserPurchase;







DROP SCHEMA Project;