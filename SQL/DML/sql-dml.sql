﻿-- Inserts


-- insert users

INSERT INTO Project.[User](Email,[Password],RegisterDate) VALUES('brunobastos@gmail.com',ENCRYPTBYPASSPHRASE('**********','password'), '2018-04-04')
INSERT INTO Project.[User](Email,[Password],RegisterDate) VALUES('client@gmail.com', ENCRYPTBYPASSPHRASE('**********','client'), '2018-11-02')
INSERT INTO Project.[User](Email,[Password],RegisterDate) VALUES('NancyKim@gmail.com', ENCRYPTBYPASSPHRASE('**********','HelloWorld'), '2019-11-02')
INSERT INTO Project.[User](Email,[Password],RegisterDate) VALUES('timcarrey@outlook.com', ENCRYPTBYPASSPHRASE('**********','notjimcarrey?'), '2019-12-10')
INSERT INTO Project.[User](Email,[Password],RegisterDate) VALUES('KareemCorbett@gmail.com', ENCRYPTBYPASSPHRASE('**********', '8gMxBJMube'), '2018-10-23')
INSERT INTO Project.[User](Email,[Password],RegisterDate) VALUES('CocoNava@gmail.com', ENCRYPTBYPASSPHRASE('**********', 'yFxeZXdcaX'), '2018-11-11')
INSERT INTO Project.[User](Email,[Password],RegisterDate) VALUES('dominik_stokes@gmail.com', ENCRYPTBYPASSPHRASE('**********','jDeTicDbvf'), '2018-09-22')
INSERT INTO Project.[User](Email,[Password],RegisterDate) VALUES('Wesley_Shields@gmail.com', ENCRYPTBYPASSPHRASE('**********','65bdSkgCqe'), '2019-01-20')
INSERT INTO Project.[User](Email,[Password],RegisterDate) VALUES('leandrocoelhom@gmail.com', ENCRYPTBYPASSPHRASE('**********','BxjthfZPFX'), '2020-01-01')
INSERT INTO Project.[User](Email,[Password],RegisterDate) VALUES('procsplayerdaubi@gmail.com', ENCRYPTBYPASSPHRASE('**********','sLMfQeyTT6'), '2019-12-02')

-- insert admin
INSERT INTO Project.[Admin](UserID) VALUES (1);

--insert clients 
INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance) Values(2,'JohnyS','John Kerry Smith','M','2000-10-05',12.00)
INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance) Values(3,'NKimmy','Nancy Black Kim','F','1999-01-01',0.00)
INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance) Values(4,'TimJ0Carrey','Tim John Carrey','M','1993-04-15',32.56)
INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance) Values(5,'CorKareembett','Kareem Zinca Corbett','F','1975-12-13',9.99)
INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance) Values(6,'Aceu','Coco Nava','M','1990-10-20',0.00)
INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance) Values(7,'Shroud','Dominik Billy White Armstrong Stokes','M','1978-05-12',0.00)
INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance) Values(8,'Zorlakoka','Wesley Marvel Shields','M','1983-03-15',0.00)
INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance) Values(9,'Leav0n','Leandro Leonardo Lionel Silva','M','2000-09-19',0.00)
INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance) Values(10,'AceDestiny','Chico Carry Me Silva','M','2000-06-27',0.00)

-- inser Company

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('beth@softworks.com','Bethesda Softworks','www.bethesda.net','i2.wp.com/www.inforumatik.com/wp-content/uploads/2017/04/data.images.authors.bgs_gear-black.png?resize=256%2C256&ssl=1','1986-06-28','Rockville, Maryland','United States');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('privacy_policy@ea.com','Electronic Arts', 'www.ea.com','cdn.iconscout.com/icon/free/png-256/electronic-arts-2-761658.png','1982-05-27', 'Redwood City,California','United States');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('squareenix@se.com','	Square Enix','www.square-enix-games.com','www.ssbwiki.com/images/a/a6/DragonQuestSymbol.svg','1975-09-22','Shinjuku, Tokyo','Japan');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('rockstargames@rs.com','Rockstar Games','www.rockstargames.com','cdn.iconscout.com/icon/free/png-256/rockstar-4-282963.png','1998-12-01','New York City, New York','United States');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('beth@softworks.com','Tencent Games','www.tencent.com','img.tapimg.com/market/images/07f7fbba25187f74f1509e17fabd3a91.png?imageView2/1/w/256/q/40/interlace/1/ignore-error/1','1998-11-11','Nanshan,Shenzen','China');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('easports@ea.com','EA Sports','www.easports.com','pbs.twimg.com/profile_images/617071953053028352/AhRCgQq7_400x400.jpg','1991-01-01','Redwood City,California','United States');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('konami@pes.com','Konami','www.konami.com','res-1.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/v1471973547/adsebqux5ocydnqlpv95.png','1969-03-21','Tokyo','Japan');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('sonygames@sony.com','Sony Interactive Entertainment','www.sie.com','logospng.org/download/sony/logo-sony-256.png','1993-11-16','San Mateo, California','United States');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('microstudios@micro.pt','Xbox Game Studios','www.microsoftstudios.com','tweaks.com/img/cat/300.jpg','2002-01-01','Redmond, Washington','United States');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('activision@contact.com','Activision','www.activision.com','res-2.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/w099gxyaawn8mjsld0rx','1979-10-01','Santa Monica, California','United States');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('billing@blizzard.com','Blizzard Entertainment','www.blizzard.com','dl1.cbsistatic.com/i/2019/06/20/1beee23f-1b12-4364-99c3-ce915d44a160/ca8589b0643aa68e02dcbd0921634cf0/imgingest-286371551299044459.png','1991-02-08','Irving, California','United States');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('dmca@noa.nintendo.com','Nintendo','www.nintendo.com','cdn.iconscout.com/icon/free/png-256/nintendo-6-282132.png','1889-09-23','Kyoto','Japan');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('bandai@namco.com','BANDAI NAMCO Entertainment','www.bandainamcoent.com','res-4.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/v1418805261/dhgs17yoampfadyglg62.jpg','2006-03-31','	Tokyo','Japan');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('cap@com.com','Capcom','www.capcom.co.jp','cdn.iconscout.com/icon/free/png-256/capcom-285355.png','1979-05-30','Osaka','Japan');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('press@wizards.com','Wizards of the Coast','company.wizards.com','pbs.twimg.com/profile_images/378800000138698413/5c74ebfc0015676be7b1cca2bd8c924a.jpeg','1990-01-01','Renton, Washington','United States');
    
INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('ubi@mail.com','Ubisoft','www.ubisoft.com','triangle-studios.com/wp-content/uploads/2015/11/logo_ubisoft.png','1986-03-12','Montreuil','France');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('contact@epic.com','Epic Games','www.epicgames.com','img.informer.com/icons_mac/png/128/444/444398.png','1991-01-01','Cary, North Carolina','United States');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES (NULL,'Riot games','www.riotgames.com','s3.us-east-2.amazonaws.com/upload-icon/uploads/icons/png/14871393811551942295-256.png','2006-08-31','Los Angeles, California','United States');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('contact@valvesoftware.com','Valve','www.valvesoftware.com','cdn.iconscout.com/icon/free/png-256/valve-51-286093.png','1996-09-24','Belleveue, Washington','United States');

INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) 
VALUES ('wbsf@warnerbros.com','Warner Bros Int. Entertainment','www.wbgames.com','res-4.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/v1464182490/wu53830rljaewbldv1no.png','1993-06-23','Burbank, California','United States');

-- insert franchise


INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Mario',12,'img.pngio.com/filemario-logopng-wikimedia-commons-mario-logo-png-256_256.png');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Pokemon',12,'res-1.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/v1487981301/x29qmdr7nzxnpfrplxmd.png');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Grand Theft Auto',4,'cdn.iconscout.com/icon/free/png-256/gta-283003.png');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('FIFA',2,'images.ctfassets.net/oqcxjunhepvs/29JWmTZaTy66O4SicWsawW/4ecfe87b180f741f8ce37bea3b6ab53e/July-15-2014-1.png');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Call of Duty',10,'static.cloud-boxloja.com/lojas/wyfyg/produtos/f25a0bd3-cd98-4f34-95e4-f63769130a7e_t260x260.jpg');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Left 4 Dead',19,'p1.hiclipart.com/preview/391/210/556/left-4-dead-2-icon-2-left-4-dead-b-left-4-dead-logo-png-clipart.jpg');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Need For Speed',2,'cdn.iconscout.com/icon/free/png-256/need-for-speed-2-569509.png');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Assassins Creed',16,'i.pinimg.com/originals/9a/22/3d/9a223d796c71d5f1289e9ad36b9c1a72.png');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Far Cry',16,'p1.hiclipart.com/preview/865/346/322/far-cry-series-icon-far-cry-by-alchemist10-d7isoxh-png-icon.jpg');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Pro Evolution Soccer',7,'escharts.com/storage/app/uploads/public/5af/59b/40d/5af59b40df255299807350.png');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('The Legend Of Zelda',12,'i.pinimg.com/originals/f2/e4/6f/f2e46f0473b6d637b7ef9b98ca1a334d.png');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Battlefield',2,'cdn.iconscout.com/icon/free/png-256/battlefield-1-282437.png');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Uncharted',8,'ih1.redbubble.net/image.1083813143.6081/flat,128x128,075,f-pad,128x128,f8f8f8.jpg');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Resident Evil',14,'i53.fastpic.ru/big/2013/0322/c8/d743e27bd8e35d690cc63b5d968731c8.png');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Halo',9,'cdn.shopify.com/s/files/1/1288/8361/files/Halo_Icon.png?9735559993999264622');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Tomb Raider',3,'portingteam.com/index.php?app=downloads&module=display&section=screenshot&id=7840');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('The Elder Scrolls',1,'images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/79db8688-58ac-41dc-aea8-cc2422e185c7/d4gg9zv-97eb5f08-a4e1-4b97-b1d5-08097cf7639c.png/v1/fill/w_256,h_256,q_80,strp/the_elder_scrolls_v_skyrim___icon_by_j1mb091_d4gg9zv-fullview.jpg');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Counter Strike',19,'lh3.googleusercontent.com/proxy/nXDUBI7pbshUG-lMatxCxsz6LHaNxRba9rujXSrvjA1uP4La-mn2Fl8_K6cB9tuQYQ7HkDxuiWnyFrduy7E5KjL9BDkT95Vrd_ebGu5u_53N');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('God Of War',8,'ih1.redbubble.net/image.550493323.5957/flat,128x128,075,t.u5.jpg');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Warcraft',11,'i1.pngguru.com/preview/832/663/631/wow-high-rez-icon-world-of-warcraft-logo-png-clipart.jpg');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Forza',9,'external-preview.redd.it/k7pYlhS4epFbqAE5uiRf7w5Meg52pgD96TdfI7A1X-M.jpg?auto=webp&s=df7b5ae0c3475dcf8da39e2dea907573290278a9');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Mass Effect',9,'external-preview.redd.it/YNrBdv5EFiAay3nyOKnlOWyZFYsv6tqooZrOzc7E-Dw.png?auto=webp&s=a5698bb811548620dfc0ce228345b3ac865576e1');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Tekken',13,'www.esc.watch/storage/app/uploads/public/5a0/ae9/b6a/5a0ae9b6abccf539928704.png');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Street Fighter',14,'www.ssbwiki.com/images/8/84/StreetFighterSymbol.svg');
INSERT INTO Project.Franchise(Name,IDCompany,Logo) VALUES ('Borderlands',8,'steamuserimages-a.akamaihd.net/ugc/250336157155911118/D961B7C5AB064EF1D8037D4921156787D1B89296/');



-- insert genre

INSERT INTO Project.Genre(GenName,Description) VALUES('Action','Action games are just that�games where the player is in control of and at the center of the action, which is mainly comprised of physical challenges players must overcome.');
INSERT INTO Project.Genre(GenName,Description) VALUES('Platformer','Platformer games get their name from the fact that the game�s character interacts with platforms throughout the gameplay.');
INSERT INTO Project.Genre(GenName,Description) VALUES('Shooter','Shooters let players use weapons to engage in the action, with the goal usually being to take out enemies or opposing players.');
INSERT INTO Project.Genre(GenName,Description) VALUES('Fighting','Fighting games like Mortal Kombat and Street Fighter II focus the action on combat, and in most cases, hand-to-hand combat.');
INSERT INTO Project.Genre(GenName,Description) VALUES('Adventure','Adventure games are categorized by the style of gameplay, not the story or content. And while technology has given developers new options to explore storytelling in the genre, at a basic level, adventure games haven�t evolved much from their text-based origins.');
INSERT INTO Project.Genre(GenName,Description) VALUES('Role-Playing','Probably the second-most popular game genre, role-playing games, or RPGs, mostly feature medieval or fantasy settings. ');
INSERT INTO Project.Genre(GenName,Description) VALUES('MMORPG','MMORPGs involve hundreds of players actively interacting with each other in the same world, and typically, all players share the same or a similar objective.');
INSERT INTO Project.Genre(GenName,Description) VALUES('Strategy','With gameplay is based on traditional strategy board games, strategy games give players a godlike access to the world and its resources. ');
INSERT INTO Project.Genre(GenName,Description) VALUES('Battle Royale','A battle royale game is a genre that blends the survival, exploration and scavenging elements of a survival game with last man standing gameplay g to stay in safe playable area which shrinks as the time passes, with the winner being the last competitor in the game');
INSERT INTO Project.Genre(GenName,Description) VALUES('Sports','Sports games simulate sports like golf, football, basketball, baseball, and soccer. They can also include Olympic sports like skiing, and even pub sports like darts and pool.');
INSERT INTO Project.Genre(GenName,Description) VALUES('Puzzle','Puzzle or logic games usually take place on a single screen or playfield and require the player to solve a problem to advance the action.');
INSERT INTO Project.Genre(GenName,Description) VALUES('Idle','Idle games are simplified games that involve minimal player involvement, such as clicking on an icon over and over. Idle games keep players engaged by rewarding those who complete simple objectives.');
INSERT INTO Project.Genre(GenName,Description) VALUES('Racing','Racing simulator series like Forza and Gran Turismo are some of the most popular games in this category, but arcade classics like Pole Position are included here too. In these games, players race against another opponent or the clock.');
INSERT INTO Project.Genre(GenName,Description) VALUES('MOBA','This category combines action games, role-playing games, and real-time strategy games. In this subgenre of strategy games, players usually do not build resources such as bases or combat units.');
INSERT INTO Project.Genre(GenName,Description) VALUES('Simulation','Games in the simulation genre have one thing in common�they are all designed to emulate real or fictional reality, to simulate a real situation or event.');
INSERT INTO Project.Genre(GenName,Description) VALUES('Side-Scrolling','A side-scrolling game is a video game in which the gameplay action is viewed from a side-view camera angle, and as the players character moves left or right, the screen scrolls with them. These games make use of scrolling computer display technology.');
INSERT INTO Project.Genre(GenName,Description) VALUES('Survival','The survival horror game Resident Evil was one of the earliest (though a linear game), while more modern survival games like Fortnite take place in open-world game environments and give players access to resources to craft tools, weapons, and shelter to survive as long as possible.');


-- insert platform

INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Xbox 360','2005-11-22', 'Microsoft' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Xbox One','2013-11-22', 'Microsoft' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Windows 7','2009-07-22', 'Microsoft' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Windows 10','2015-07-29', 'Microsoft' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('PlayStation','1994-12-03', 'Sony' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('PlayStation 2','2000-03-04', 'Sony' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('PlayStation 3','2006-11-11', 'Sony' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('PlayStation 4','2005-11-13', 'Sony' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('PlayStation Portable','2004-12-12', 'Sony' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('PlayStation Vita','2011-12-17', 'Microsoft' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Nintendo DS', '2004-12-02','Nintendo' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Nintendo 3DS', '2011-02-26', 'Nintendo');
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Wii', '2006-11-19', 'Nintendo' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Nintendo Switch', '2017-03-03', 'Nintendo');
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Nintendo 64', '1996-06-23','Nintendo' );
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('GameCube', '2001-09-14','Nintendo');
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Wii U', '2012-11-18','Nintendo');
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('MacOS', '2018-11-24', 'Apple');
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('iOS', '2007-06-29','Apple');
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Android', '2006-09-28','Google');
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Linux', '1991-04-20', 'Linux');
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Sega Saturn', '1994-11-22','Sega');
INSERT INTO Project.[Platform](PlatformName,ReleaseDate,Producer) VALUES ('Dreamcast', '1998-11-27','Sega' );

-- insert follows

INSERT INTO Project.Follows(IDFollowed,IDFollower) VALUES(2,3);
INSERT INTO Project.Follows(IDFollowed,IDFollower) VALUES(2,4);
INSERT INTO Project.Follows(IDFollowed,IDFollower) VALUES(2,5);
INSERT INTO Project.Follows(IDFollowed,IDFollower) VALUES(2,6);
INSERT INTO Project.Follows(IDFollowed,IDFollower) VALUES(3,2);
INSERT INTO Project.Follows(IDFollowed,IDFollower) VALUES(4,5);
INSERT INTO Project.Follows(IDFollowed,IDFollower) VALUES(5,6);

-- insert games


INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Super Mario 64','Super Mario 64 is a 1996 platform video game for the Nintendo 64.','1996-06-23',3,3.99, 12 ,1,'i.ya-webdesign.com/images/super-mario-64-png-8.png')

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany, IDFranchise,CoverImg) 
VALUES('New Super Mario Bros.','New Super Mario Bros. is a side-scrolling video game.',
'2006-05-01',3, 3.99, 12 , 1, 'yuzu-emu.org/images/game/boxart/new-super-mario-bros-u-deluxe.png' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany, IDFranchise,CoverImg) 
VALUES('Super Mario Run','Super Mario Run is a 2016 side-scrolling platform mobile game developed and published by Nintendo.',
'2016-12-15',3,1.99,12, 1,'a.thumbs.redditmedia.com/N9gGTwEaZJ3D2iGF13A-RRNgeqgPbkNr1jetwhXIVQ0.png')

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Pokemon Red','Pokemon Red Version is role-playing video game developed by Game Freak and published by Nintendo.'
,'1996-03-27', 3 ,9.99, 12 , 2,'tecnoblog.net/wp-content/uploads/2011/08/ruby-saphire.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Pokemon Sword','Pokemon Sword is a role-playing video game developed by Game Freak and published by Nintendo.','2019-11-15', 3 ,59.99, 12 , 2,'www.speedrun.com/themes/pkmnswordshield/cover-256.png' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Grand Theft Auto V','Grand Theft Auto V is a 2013 action-adventure game published by Rockstar Games.','2013-09-17', 18 ,59.99, 4 , 3,'pngimage.net/wp-content/uploads/2018/06/gta-v-icon-png-2.png' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('FIFA Football 2004','FIFA Football 2004 is a football video game developed and published by Electronic Arts','2003-10-24', 3 ,59.99, 6 , 4,'upload.wikimedia.org/wikipedia/en/thumb/e/e3/FIFA_Football_2004_cover.jpg/250px-FIFA_Football_2004_cover.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise, CoverImg) 
VALUES('FIFA 20','FIFA 20 is a football simulation video game published by Electronic Arts as part of the FIFA series.','2019-07-19', 3 ,59.99, 6 , 4,'1.bp.blogspot.com/-rD96Hu8rAyw/XYeClZZIlWI/AAAAAAAABD0/Uocets3DupIJNQgFFAe8l0Hq8Vi5RFOtgCEwYBhgL/s1600/fifa20.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Call of Duty : Black Ops 2','Call of Duty: Black Ops II is a 2012 first-person shooter published by Activision.','2012-11-12', 18 ,11.99, 10 ,5,'pbs.twimg.com/profile_images/2772600693/ca93f6313b2310cfb4dfdb6c11366775.jpeg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Call of Duty : World at War','Call of Duty: World at War is a 2008 first-person shooter video game published by Activision. ','2008-11-11', 18 ,4.99, 10 , 5,'p1.hiclipart.com/preview/850/213/205/the-call-of-duty-series-icon-2003-2011-world-at-war-call-of-duty-world-at-war-illustration-png-clipart.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Left 4 Dead 2','Left 4 Dead 2 is a 2009 multiplayer survival horror game developed and published by Valve.','2009-11-17', 18 ,5.99, 19 , 6,'steamuserimages-a.akamaihd.net/ugc/845968188390814023/37674AD466665B9F4E540AAE7128C51D0C59A1D1/' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Need For Speed : Most Wanted','Need for Speed: Most Wanted is an open world racing game published by Electronic Arts.','2012-10-30', 3 ,10.99, 2 , 7,'cdn6.aptoide.com/imgs/0/e/4/0e492e0ec8a53fa7c3c1fbf5e58c6322_icon.png?w=256' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Need For Speed : Shift','Need for Speed: Shift is the 13th installment of the racing video game franchise Need for Speed.','2009-07-15', 3 ,4.99, 2 , 7,'images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/8dd91536-f09a-487f-838f-140f69ff9d8a/d5reyzt-658a6e08-0dd5-458a-8227-46ed76d956fa.png/v1/fill/w_256,h_256,q_80,strp/need_for_speed_shift_icon_for_obly_tile_by_enigmaxg2_d5reyzt-fullview.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Assassins Creed II','Assassins Creed II is a 2009 action-adventure video game developed published by Ubisoft.','2009-11-17', 18 ,9.99, 16 , 8, 'images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/8dd91536-f09a-487f-838f-140f69ff9d8a/d5ws6i1-1fb4c643-f683-4f93-9f23-bd20f0535403.png/v1/fill/w_256,h_256,q_80,strp/assassin_s_creed_2_icon_for_obly_tile_by_enigmaxg2_d5ws6i1-fullview.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Assassins Creed IV: Black Flag','Assassins Creed IV: Black Flag is an action-adventure video game published by Ubisoft.','2013-10-29', 18 ,19.99, 16 , 8,'pbs.twimg.com/profile_images/3321242353/74d0589d590170d9a6c914496ffb81d2.jpeg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Far Cry 3','Far Cry 3 is a 2012 first-person shooter developed by Ubisoft Montreal and published by Ubisoft.','2012-11-29', 18 ,19.99, 16 , 9,'c-sf.smule.com/sf/s34/arr/6e/75/11178429-7c20-4335-8c8e-7771de9945b9.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Far Cry 5','Far Cry 5 is a first-person shooter game published by Ubisoft, the 5th game in the Far Cry series.','2018-03-27', 18 ,49.99, 16 , 9,'turkce-yama.com/wp-content/uploads/FarCry-5-Simge-256x256.png' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Pro Evolution Soccer 2019','Pro Evolution Soccer 2019 is a football simulation video game published by Konami','2019-08-08', 3 ,39.99, 7 , 10,'i.pinimg.com/474x/15/e8/fa/15e8fa57c4588318250d2676c9f40a56.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise, CoverImg) 
VALUES('The Legend of Zelda: Breath of the Wild','The Legend of Zelda: Breath of the Wild is an action-adventure game developed and published by Nintendo','2017-03-03', 3 ,59.99, 12 , 11, 'i.pinimg.com/474x/15/e8/fa/15e8fa57c4588318250d2676c9f40a56.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Uncharted: Drakes Fortune', 'Uncharted: Drakes Fortune is a 2007 action-adventure game published by Sony Computer Entertainment. It is the first game in the Uncharted series.','2007-1-20', 3 ,9.99, 1 , 13,'static.truetrophies.com/boxart/Game_986.png' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Uncharted 4: A Thiefs End' , 'Uncharted 4: A Thiefs End is a 2016 action-adventure game published by Sony Computer Entertainment.','2007-1-20', 3 ,9.99, 1 , 13,'www.truetrophies.com/boxart/Game_4209.png' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Battlefield 4','Battlefield 4 is a first-person shooter video game developed by video game developer EA DICE and published by Electronic Arts','2013-10-29', 18 ,39.99, 2 , 12,'vectorified.com/images/battlefield-4-icon-16x16-33.png' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Resident Evil 2','Resident Evil 2 is a survival horror game developed and published by Capcom.','2019-01-25', 18 ,39.99, 14 , 14,'static.truetrophies.com/boxart/Game_8024.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Halo 5 : Guardian','Halo 5: Guardians is a first-person shooter video game developed by 343 Industries and published by Microsoft Studios','2015-10-17', 16 ,39.99, 9 , 15,'avatarfiles.alphacoders.com/123/123823.png' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Shadow of the Tomb Raider','Shadow of the Tomb Raider is an action-adventure video game published by Square Enix.','2018-09-12', 18 ,20.00, 3 , 16,'www.truetrophies.com/boxart/Game_7519.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('The Elder Scrolls V: Skyrim','The Elder Scrolls V: Skyrim is an action role-playing video game published by Bethesda Softworks.','2011-11-11', 12, 19.99, 1 , 17,'images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/78aa3687-9f6e-45cc-9450-47d0978a810d/d39n68b-07b03bff-a1c3-4417-be06-a228a0ab0cff.png/v1/fill/w_256,h_256,q_80,strp/elder_scrolls_v___skyrim_icon_by_bonscha_d39n68b-fullview.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Counter Strike Global Offensive','Counter-Strike: Global Offensive is a multiplayer first-person shooter video game developed by Valve and Hidden Path Entertainment.','2012-08-21', 18 ,10.00, 19 , 18,'p1.hiclipart.com/preview/915/443/598/counter-strike-go-game-icon-pack-cs-go-6-png-icon.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('God Of War','God of War is an action-adventure game developed by Santa Monica Studio and published by Sony Interactive Entertainment.','2018-04-20', 18 ,40.00, 8 , 19,'avatarfiles.alphacoders.com/222/222728.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Warcraft III: Reign of Chaos','Warcraft III: Reign of Chaos is a high fantasy real-time strategy computer video game developed and published by Blizzard Entertainment released in July 2002. It is the second sequel to Warcraft: Orcs & Humans','2002-07-03', 16 ,5.00, 11 , 20,'dl1.cbsistatic.com/i/2016/07/12/f3f4e353-38aa-4de9-8c87-a6ad905ce9e9/d900d0e88d0f97b1464494805baac237/imgingest-6030158764582817665.png' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Mass Effect: Andromeda','Mass Effect: Andromeda is an action role-playing video game developed by BioWare and published by Electronic Arts.','2017-03-21', 16 ,45.00, 2 , 22,'m.media-amazon.com/images/I/51zkf-kP5yL._AA256_.jpg' )

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Tekken 7','Tekken 7 is a fighting game developed and published by Bandai Namco Entertainment.','2015-03-18', 18 ,49.99, 13 , 23,'static.truetrophies.com/boxart/Game_5497.png')

INSERT INTO Project.Game(Name,Description,ReleaseDate,AgeRestriction,Price,IDCompany,IDFranchise,CoverImg) 
VALUES('Street Fighter','Street Fighter V is a fighting game developed by Capcom','2016-02-16', 3 ,15.00, 14 , 24,'pbs.twimg.com/profile_images/697220635198689285/T34coLzR_400x400.png' )


-- insert credit

INSERT INTO Project.Credit(MetCredit,DateCredit,ValueCredit,IDClient)
VALUES('PayPal','2020-05-01',3.99,2);

INSERT INTO Project.Credit(MetCredit,DateCredit,ValueCredit,IDClient)
VALUES('MBWay','2020-05-01',19.99,2);

INSERT INTO Project.Credit(MetCredit,DateCredit,ValueCredit,IDClient)
VALUES('PayPal','2020-05-01',12.00,2);

INSERT INTO Project.Credit(MetCredit,DateCredit,ValueCredit,IDClient)
VALUES('VISA','2020-03-04', 3.99,3);

INSERT INTO Project.Credit(MetCredit,DateCredit,ValueCredit,IDClient)
VALUES('PayPal','2020-01-01',19.99,3);

INSERT INTO Project.Credit(MetCredit,DateCredit,ValueCredit,IDClient)
VALUES('VISA','2020-03-22',1.99,3);

INSERT INTO Project.Credit(MetCredit,DateCredit,ValueCredit,IDClient)
VALUES('PayPal','2020-03-03',1.99,4);

INSERT INTO Project.Credit(MetCredit,DateCredit,ValueCredit,IDClient)
VALUES('MasterCard','2020-05-01',32.56,4);

INSERT INTO Project.Credit(MetCredit,DateCredit,ValueCredit,IDClient)
VALUES('PayPal','2020-01-21',1.99,5);

INSERT INTO Project.Credit(MetCredit,DateCredit,ValueCredit,IDClient)
VALUES('PayPal','2020-05-01',9.99,5);


-- insert discount

INSERT INTO Project.Discount(PromoCode,Percentage,DateBegin,DateEnd) 
VALUES(1,50,'2020-05-01','2020-11-20');
INSERT INTO Project.Discount(PromoCode,Percentage,DateBegin,DateEnd) 
VALUES(2,50,'2020-03-01','2020-04-20');
INSERT INTO Project.Discount(PromoCode,Percentage,DateBegin,DateEnd) 
VALUES(3,30,'2020-06-01','2020-11-20');


-- insert discountgame

INSERT INTO Project.DiscountGame(PromoCode,IDGame) VALUES(1,1);
INSERT INTO Project.DiscountGame(PromoCode,IDGame) VALUES(2,2);
INSERT INTO Project.DiscountGame(PromoCode,IDGame) VALUES(3,3);
INSERT INTO Project.DiscountGame(PromoCode,IDGame) VALUES(1,4);


-- insert gamegenre



INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (1,'Platformer');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (1,'Side-Scrolling');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (2,'Platformer');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (2,'Adventure');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (3,'Platformer');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (3,'Role-Playing');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (3,'Adventure');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (4,'Role-Playing');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (4,'Adventure');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (5,'Role-Playing');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (5,'Adventure');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (6,'Adventure');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (6,'Action');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (6,'Shooter');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (7,'Simulation');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (7,'Sports');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (8,'Simulation');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (8,'Sports')

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (9,'Shooter');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (9,'Action');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (10,'Shooter');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (10,'Action');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (11,'Shooter');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (11,'Action');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (11,'Survival');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (12,'Racing');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (13,'Racing');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (14,'Adventure');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (14,'Action');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (15,'Adventure');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (15,'Action');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (16,'Adventure');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (16,'Action');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (16,'Shooter');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (17,'Adventure');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (17,'Action');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (17,'Shooter');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (18,'Sports');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (18,'Simulation');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (19,'Adventure');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (19,'Action');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (19,'Role-Playing');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (20,'Action');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (20,'Adventure');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (20,'Platformer');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (20,'Shooter');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (21,'Action');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (21,'Adventure');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (21,'Platformer');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (21,'Shooter');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (22,'Shooter');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (22,'Action');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (23,'Shooter');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (23,'Action');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (23,'Survival');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (24,'Shooter');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (24,'Strategy');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (24,'Action');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (24,'Adventure');


INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (25,'Shooter');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (25,'Action');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (25,'Adventure');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (25,'Puzzle');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (26,'Role-Playing');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (26,'Action');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (26,'Adventure');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (26,'Puzzle');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (27,'Shooter');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (27,'Strategy');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (27,'Action');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (28,'Puzzle');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (28,'Action');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (28,'Adventure');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (28,'Role-Playing');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (29,'Adventure');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (29,'MMORPG');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (29,'Strategy');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (30,'Role-Playing');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (30,'Action');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (31,'Fighting');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (31,'Action');

INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (32,'Fighting');
INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (32,'Action');

-- insert platformreleasesgame


INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (1,'Nintendo 64');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (2,'Nintendo DS');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (3,'Android');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (3,'iOS');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (4,'Nintendo DS');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (5,'Nintendo Switch');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (6,'Windows 10');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (6,'PlayStation 3');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (6,'PlayStation 4');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (6,'Xbox 360');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (6,'Xbox One');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (7,'Xbox 360');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (7,'PlayStation');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (7,'PlayStation 2');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (7,'GameCube');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (8,'Xbox One');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (8,'PlayStation 4');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (8,'Nintendo Switch');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (8,'MacOS');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (8,'Windows 10');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (8,'Windows 7');



INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (9,'Xbox 360');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (9,'PlayStation 3');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (9,'Windows 7');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (10,'Xbox 360');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (10,'PlayStation 3');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (10,'Windows 7');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (10,'Wii');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (11,'Windows 7');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (11,'MacOS');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (11,'Linux');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (11,'Xbox 360');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (12,'Xbox 360');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (12,'PlayStation 3');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (12,'Windows 7');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (12,'Wii U');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (12,'PlayStation Vita');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (12,'Android');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (12,'iOS');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (13,'PlayStation Portable');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (13,'PlayStation 3');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (13,'iOS');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (13,'Android');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (13,'Xbox 360');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (14,'Xbox 360');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (14,'PlayStation 3');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (14,'Windows 7');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (15,'Xbox 360');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (15,'PlayStation 3');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (15,'Windows 7');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (15,'Xbox One');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (15,'PlayStation 4');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (15,'Windows 10');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (16,'Xbox 360');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (16,'PlayStation 3');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (16,'Windows 7');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (17,'Xbox One');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (17,'PlayStation 4');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (17,'Windows 10');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (18,'Xbox 360');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (18,'PlayStation 3');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (18,'Windows 7');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (18,'Xbox One');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (18,'PlayStation 4');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (18,'Windows 10');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (19,'Nintendo Switch');


INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (20,'PlayStation 3');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (21,'PlayStation 4');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (22,'Xbox One');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (22,'PlayStation 4');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (22,'Windows 10');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (23,'Xbox One');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (23,'PlayStation 4');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (23,'Windows 10');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (24,'Xbox One');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (24,'Xbox 360');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (24,'Windows 7');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (25,'Xbox One');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (25,'PlayStation 4');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (25,'Windows 10');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (26,'Xbox 360');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (26,'PlayStation 3');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (26,'Windows 7');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (27,'Windows 7');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (27,'Windows 10');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (28,'PlayStation 4');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (29,'Windows 7');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (30,'Xbox One');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (30,'PlayStation 4');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (30,'Windows 10');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (31,'Xbox One');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (31,'PlayStation 4');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (31,'Windows 10');

INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (32,'PlayStation 4');
INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (32,'Windows 10');

-- insert Reviews


INSERT INTO Project.Reviews(Title,Text,Rating,DateReview,UserID,IDGame) 
VALUES('Very bad game','My game keeps crashing. I can not play this...',1,'2020-05-01',2,1);


INSERT INTO Project.Reviews(Title,Text,Rating,DateReview,UserID,IDGame) 
VALUES('Not that good', 'I really do not like the graphic design :/',3,'2020-03-04', 3, 1  );

INSERT INTO Project.Reviews(Title,Text,Rating,DateReview,UserID,IDGame)
VALUES('Amazing', 'I really have fun playing this!', 4, '2020-01-02',5,1);


INSERT INTO Project.Reviews(Title,Text,Rating,DateReview,UserID,IDGame)
VALUES('Can not stop playing! OMG','This game is so addictive, pls send help!',5,'2020-05-01',2,2);

INSERT INTO Project.Reviews(Title,Text,Rating,DateReview,UserID,IDGame) 
VALUES('Could be worse','The game looks nice, but it has some problems in playability',3,'2020-01-01',3,2 );


INSERT INTO Project.Reviews(Title,Text,Rating,DateReview,UserID,IDGame) 
VALUES('Not worth the money!','If anyone is reading this pls do not buy this game',1,'2020-03-22',3,3);

INSERT INTO Project.Reviews(Title,Text,Rating,DateReview,UserID,IDGame) 
VALUES('Couldnt ask for better', 'Really fun, addictive and nostalgic',4, '2020-01-21',5,3 );

INSERT INTO Project.Reviews(Title,Text,Rating,DateReview,UserID,IDGame)
VALUES('GG', 'good design and playability, but some problems',3, '2020-03-03',4,3 );

-- insert copias



INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(1,'Nintendo 64');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(1,'Nintendo 64');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(1,'Nintendo 64');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(1,'Nintendo 64');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(2,'Nintendo DS');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(2,'Nintendo DS');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(2,'Nintendo DS');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(2,'Nintendo DS');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(3,'Android');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(3,'Android');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(3,'Android');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(3,'iOS');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(4,'Nintendo DS');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(4,'Nintendo DS');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(4,'Nintendo DS');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(4,'Nintendo DS');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(5,'Nintendo Switch');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(5,'Nintendo Switch');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(5,'Nintendo Switch');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(5,'Nintendo Switch')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(6,'Windows 10');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(6,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(6,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(6,'Xbox One')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(7,'PlayStation 2');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(7,'GameCube');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(7,'Xbox 360');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(7,'PlayStation');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(8,'Xbox One');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(8,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(8,'Windows 10');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(8,'Windows 10')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(9,'Xbox 360');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(9,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(9,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(9,'Windows 7')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(10,'Xbox 360');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(10,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(10,'Windows 7');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(10,'Wii')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(11,'Windows 7');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(11,'MacOS');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(11,'Linux');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(11,'Xbox 360')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(12,'Xbox 360');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(12,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(12,'Windows 7');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(12,'PlayStation Vita')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(13,'PlayStation Portable');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(13,'PlayStation Portable');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(13,'Xbox 360');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(13,'Android')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(14,'Windows 7');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(14,'Xbox 360');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(14,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(14,'PlayStation 3')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(15,'Windows 7');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(15,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(15,'Windows 10');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(15,'Windows 10')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(16,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(16,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(16,'Windows 7');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(16,'Xbox 360')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(17,'Xbox One');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(17,'Xbox One');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(17,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(17,'Windows 10')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(18,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(18,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(18,'Windows 10');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(18,'Xbox 360')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(19,'Nintendo Switch');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(19,'Nintendo Switch');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(19,'Nintendo Switch');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(19,'Nintendo Switch');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(20,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(20,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(20,'PlayStation 3');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(20,'PlayStation 3')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(21,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(21,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(21,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(21,'PlayStation 4')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(22,'Xbox One');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(22,'Xbox One');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(22,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(22,'Windows 10')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(23,'Xbox One');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(23,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(23,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(23,'Windows 10')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(24,'Xbox One');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(24,'Xbox One');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(24,'Xbox 360');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(24,'Windows 7')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(25,'Xbox One');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(25,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(25,'Windows 10');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(25,'Windows 10')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(26,'Windows 7');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(26,'Xbox 360');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(26,'Xbox 360');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(26,'PlayStation 3')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(27,'Windows 7');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(27,'Windows 7');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(27,'Windows 10');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(27,'Windows 10')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(28,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(28,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(28,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(28,'PlayStation 4')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(29,'Windows 7');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(29,'Windows 7');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(29,'Windows 7');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(29,'Windows 7')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(30,'Xbox One');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(30,'Xbox One');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(30,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(30,'Windows 10')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(31,'Xbox One');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(31,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(31,'Windows 10');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(31,'Windows 10')
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(32,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(32,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(32,'PlayStation 4');
INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES(32,'Windows 10')



-- insert purchases

INSERT INTO Project.Purchase(Price,PurchaseDate,IDClient,SerialNum) 
VALUES(3.99,'2020-05-01',2,100001);

INSERT INTO Project.Purchase(Price,PurchaseDate,IDClient,SerialNum) 
VALUES(3.99,'2020-03-04',3,100002);

INSERT INTO Project.Purchase(Price,PurchaseDate,IDClient,SerialNum) 
VALUES(3.99,'2020-01-02',5,100003);

INSERT INTO Project.Purchase(Price,PurchaseDate,IDClient,SerialNum) 
VALUES(19.99,'2020-05-01',2,100005);

INSERT INTO Project.Purchase(Price,PurchaseDate,IDClient,SerialNum) 
VALUES(19.99,'2020-05-01',3,100006);

INSERT INTO Project.Purchase(Price,PurchaseDate,IDClient,SerialNum) 
VALUES(3.99,'2020-03-22',3,100009);

INSERT INTO Project.Purchase(Price,PurchaseDate,IDClient,SerialNum) 
VALUES(3.99,'2020-01-21',5,100010);

INSERT INTO Project.Purchase(Price,PurchaseDate,IDClient,SerialNum) 
VALUES(3.99,'2020-03-03',4,100011);