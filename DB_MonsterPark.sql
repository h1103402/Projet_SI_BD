/*DROP DATABASE IF EXISTS DB_MONSTER_PARK ;*/
CREATE DATABASE DB_MONSTER_PARK ;
USE DB_MONSTER_PARK ;

DROP TABLE IF EXISTS MONSTER ;
CREATE TABLE MONSTER (
	ID_MONSTER INT(10) AUTO_INCREMENT NOT NULL,
	NAME VARCHAR(20),
	GENDER ENUM('F', 'M'),
	AGE INT(5),
	WEIGHT INT(5),
	DANGER_SCALE ENUM('INOFFENSIVE', 'AGGRESSIVE', 'DANGEROUS', 'MORTAL'),
	HEALTH_STATE INT(10),
	HUNGER_STATE INT(10),
	CLEAN_SCALE INT(10),
	REGIME ENUM('HERBIVORE', 'FRUITARIAN', 'PESCETARIAN', 'OMNIVOROUS', 'CARNIVORE'),
	ID_ENCLOSURE INT(10),
	ID_MATURITY INT(10),
	ID_PLAYER INT(10),
	PRIMARY KEY (ID_MONSTER)
);

DROP TABLE IF EXISTS SUB_SPECIE ;
CREATE TABLE SUB_SPECIE (
 	ID_SUB_SPECIE INT(10) AUTO_INCREMENT NOT NULL,
	LIB_SUB_SPECIE VARCHAR(20),
	LIB_HABITAT VARCHAR(20),
	ID_SPECIE INT(10),
	PRIMARY KEY (ID_SUB_SPECIE)
);

DROP TABLE IF EXISTS SPECIE ;
CREATE TABLE SPECIE (
	ID_SPECIE INT(10) AUTO_INCREMENT NOT NULL,
	LIB_SPECIE VARCHAR(20),
	PRIMARY KEY (ID_SPECIE)
);

DROP TABLE IF EXISTS ELEMENT ;
CREATE TABLE ELEMENT (	
	ID_ELEMENT INT(10) AUTO_INCREMENT NOT NULL,
	LIB_ELEMENT VARCHAR(20),
	PRIMARY KEY (ID_ELEMENT)
);

DROP TABLE IF EXISTS ENCLOSURE ;
CREATE TABLE ENCLOSURE (
	ID_ENCLOSURE INT(10) AUTO_INCREMENT NOT NULL,
	TYPE_ENCLOS ENUM('BASIC', 'AVIARY', 'AQUARIUM'),
	CAPACITY_MONSTER INT(10),
	PRICE INT(10),
	CLIMATE ENUM('FOREST', 'VOLCANIC', 'ARID', 'TROPICAL', 'CAVERNOUS', 'MOUNTAINOUS', 'ARCTIC', 'ISLAND', 'OCEANIC'),
	ID_SUB_SPECIE INT(10),
	ID_PARK INT(10),
	PRIMARY KEY (ID_ENCLOSURE)
);

DROP TABLE IF EXISTS PLAYER ;
CREATE TABLE PLAYER (
	ID_PLAYER INT(10) AUTO_INCREMENT NOT NULL,
	FIRST_NAME VARCHAR(20),
	LAST_NAME VARCHAR(20),
	GENDER ENUM('F', 'M'),
	BIRTH_DATE DATE,
	PHONE_NUMBER VARCHAR(10),
	DESCRIPTION LONGTEXT,
	WEBSITE VARCHAR(200),
	MONEY INT(10),
	PRIMARY KEY (ID_PLAYER)
);

DROP TABLE IF EXISTS ITEM ;
CREATE TABLE ITEM (
	ID_ITEM INT(10) AUTO_INCREMENT NOT NULL,
	TYPE_ITEM ENUM('ENTRETIEN', 'FOOD', 'WEAPON', 'ARMOR'),
	LIB_ITEM VARCHAR(20),
	PRIX_ITEM INT(10),
	FAMILY_ITEM ENUM('CONSUMABLE', 'EQUIPMENT'),
	ID_PLAYER INT(10) NOT NULL,
	ID_QUEST INT(10) NOT NULL,
	PRIMARY KEY (ID_ITEM)
);

DROP TABLE IF EXISTS ACCOUNT ;
CREATE TABLE ACCOUNT (
	ID_ACCOUNT INT(10) AUTO_INCREMENT NOT NULL,
	PSEUDO VARCHAR(20),
	EMAIL VARCHAR(50),
	PASSWORD VARCHAR(20),
	IP VARCHAR(15),
	DATE_INSCRIPTION DATETIME,
	PRIMARY KEY (ID_ACCOUNT)
);

DROP TABLE IF EXISTS PTRANSACTION ;
CREATE TABLE PTRANSACTION (
	ID_PTRANSACTION INT(10) AUTO_INCREMENT NOT NULL,
	AMOUNT INT(10),
	PTRANSACTION_DATE DATETIME,
	ID_PLAYER INT(10) NOT NULL,
	PRIMARY KEY (ID_PTRANSACTION)
);

DROP TABLE IF EXISTS NEWS ;
CREATE TABLE NEWS (
	ID_NEWS INT(10) AUTO_INCREMENT NOT NULL,
	TITLE VARCHAR(20),
	PICTURE VARCHAR(20),
	CONTENT VARCHAR(200),
	ID_NEWSPAPER INT(10) NOT NULL,
	PRIMARY KEY (ID_NEWS)
);

DROP TABLE IF EXISTS QUEST ;
CREATE TABLE QUEST (
	ID_QUEST INT(10) AUTO_INCREMENT NOT NULL,
	FEE FLOAT(10),
	DATE_DEB DATE,
	DURATION INT(5),
	IS_COMPLETED BOOL,
	PRIMARY KEY (ID_QUEST)
);

DROP TABLE IF EXISTS PARK ;
CREATE TABLE PARK (
    ID_PARK INT(10) AUTO_INCREMENT NOT NULL,
    NAME_PARK VARCHAR(20),
    CAPACITY_ENCLOSURE INT(10),
    ID_PLAYER INT(10),
    PRIMARY KEY (ID_PARK)
);

DROP TABLE IF EXISTS MATURITY ;
CREATE TABLE MATURITY (
	ID_MATURITY INT(10) AUTO_INCREMENT NOT NULL,
	MATURITY_LEVEL INT(5),
	LIB_MATURITY VARCHAR(20),
	TIME_REQUIRE INT(10),
	PRIMARY KEY (ID_MATURITY)
);

DROP TABLE IF EXISTS NEWSPAPER ;
CREATE TABLE NEWSPAPER (
	ID_NEWSPAPER INT(10) AUTO_INCREMENT NOT NULL,
	PUBLICATION DATE,
	PRIMARY KEY (ID_NEWSPAPER)
);

DROP TABLE IF EXISTS ASSOC_MONSTER_ELEMENT ;
CREATE TABLE ASSOC_MONSTER_ELEMENT (
	ID_ELEMENT INT(10) AUTO_INCREMENT NOT NULL,
	ID_MONSTER INT(10) NOT NULL,
	PRIMARY KEY (ID_ELEMENT, ID_MONSTER)
);

DROP TABLE IF EXISTS ASSOC_PLAYER_ENCLOSURE ;
CREATE TABLE ASSOC_PLAYER_ENCLOSURE (
	ID_ENCLOSURE INT(10) AUTO_INCREMENT NOT NULL,
	ID_PLAYER INT(10) NOT NULL,
	PRIMARY KEY (ID_ENCLOSURE, ID_PLAYER)
);

DROP TABLE IF EXISTS ASSOC_PLAYER_ACCOUNT ;
CREATE TABLE ASSOC_PLAYER_ACCOUNT (
	ID_PLAYER INT(10) AUTO_INCREMENT NOT NULL,
	ID_ACCOUNT INT(10) NOT NULL,
	DATE_CONNEXION DATETIME,
	PRIMARY KEY (ID_PLAYER, ID_ACCOUNT)
);

DROP TABLE IF EXISTS ASSOC_PLAYER_QUEST ;
CREATE TABLE ASSOC_PLAYER_QUEST (
	ID_QUEST INT(10) AUTO_INCREMENT NOT NULL,
	ID_PLAYER INT(10) NOT NULL,
	ASSOC_PLAYER_QUEST_COST INT(10),
	PRIMARY KEY (ID_QUEST, ID_PLAYER)
);

ALTER TABLE MONSTER ADD CONSTRAINT FK_MONSTER_ID_ENCLOSURE FOREIGN KEY (ID_ENCLOSURE) REFERENCES ENCLOSURE (ID_ENCLOSURE);
ALTER TABLE MONSTER ADD CONSTRAINT FK_MONSTER_ID_MATURITY FOREIGN KEY (ID_MATURITY) REFERENCES MATURITY (ID_MATURITY);
ALTER TABLE MONSTER ADD CONSTRAINT FK_MONSTER_ID_JOUEUR FOREIGN KEY (ID_PLAYER) REFERENCES PLAYER (ID_PLAYER);
ALTER TABLE SUB_SPECIE ADD CONSTRAINT FK_SUB_SPECIE_ID_SPECIE FOREIGN KEY (ID_SPECIE) REFERENCES SPECIE (ID_SPECIE);
ALTER TABLE ENCLOSURE ADD CONSTRAINT FK_ENCLOSURE_ID_SUB_SPECIE FOREIGN KEY (ID_SUB_SPECIE) REFERENCES SUB_SPECIE (ID_SUB_SPECIE);
ALTER TABLE ENCLOSURE ADD CONSTRAINT FK_ENCLOSURE_ID_PARK FOREIGN KEY (ID_PARK) REFERENCES PARK (ID_PARK);
ALTER TABLE ITEM ADD CONSTRAINT FK_ITEM_ID_JOUEUR FOREIGN KEY (ID_PLAYER) REFERENCES PLAYER (ID_PLAYER);
ALTER TABLE ITEM ADD CONSTRAINT FK_ITEM_ID_QUEST FOREIGN KEY (ID_QUEST) REFERENCES QUEST (ID_QUEST);
ALTER TABLE PTRANSACTION ADD CONSTRAINT FK_PTRANSACTION_ID_JOUEUR FOREIGN KEY (ID_PLAYER) REFERENCES PLAYER (ID_PLAYER);
ALTER TABLE NEWS ADD CONSTRAINT FK_NEWS_ID_NEWSPAPER FOREIGN KEY (ID_NEWSPAPER) REFERENCES NEWSPAPER (ID_NEWSPAPER);
ALTER TABLE PARK ADD CONSTRAINT FK_PARK_ID_JOUEUR FOREIGN KEY (ID_PLAYER) REFERENCES PLAYER (ID_PLAYER);
ALTER TABLE ASSOC_MONSTER_ELEMENT ADD CONSTRAINT FK_ASSOC_MONSTER_ELEMENT_ID_ELEMENT FOREIGN KEY (ID_ELEMENT) REFERENCES ELEMENT (ID_ELEMENT);
ALTER TABLE ASSOC_MONSTER_ELEMENT ADD CONSTRAINT FK_ASSOC_MONSTER_ELEMENT_ID_MONSTER FOREIGN KEY (ID_MONSTER) REFERENCES MONSTER (ID_MONSTER);
ALTER TABLE ASSOC_PLAYER_ENCLOSURE ADD CONSTRAINT FK_ASSOC_PLAYER_ENCLOSURE_ID_ENCLOSURE FOREIGN KEY (ID_ENCLOSURE) REFERENCES ENCLOSURE (ID_ENCLOSURE);
ALTER TABLE ASSOC_PLAYER_ENCLOSURE ADD CONSTRAINT FK_ASSOC_PLAYER_ENCLOSURE_ID_JOUEUR FOREIGN KEY (ID_PLAYER) REFERENCES PLAYER (ID_PLAYER);
ALTER TABLE ASSOC_PLAYER_ACCOUNT ADD CONSTRAINT FK_ASSOC_PLAYER_ACCOUNT_ID_JOUEUR FOREIGN KEY (ID_PLAYER) REFERENCES PLAYER (ID_PLAYER);
ALTER TABLE ASSOC_PLAYER_ACCOUNT ADD CONSTRAINT FK_ASSOC_PLAYER_ACCOUNT_ID_ACCOUNT FOREIGN KEY (ID_ACCOUNT) REFERENCES ACCOUNT (ID_ACCOUNT);
ALTER TABLE ASSOC_PLAYER_QUEST ADD CONSTRAINT FK_ASSOC_PLAYER_QUEST_ID_QUEST FOREIGN KEY (ID_QUEST) REFERENCES QUEST (ID_QUEST);
ALTER TABLE ASSOC_PLAYER_QUEST ADD CONSTRAINT FK_ASSOC_PLAYER_QUEST_ID_JOUEUR FOREIGN KEY (ID_PLAYER) REFERENCES PLAYER (ID_PLAYER);
