INSERT INTO LesSpectacles SELECT DISTINCT noSpec, nomSpec, prixBaseSpec FROM V0_LesRepresentations;
INSERT INTO LesRepresentations_base SELECT dateRep, promoRep, noSpec FROM V0_LesRepresentations;
INSERT INTO LesPlaces SELECT DISTINCT noPlace, noRang, noZone FROM V0_LesPlaces;
INSERT INTO LesZones SELECT DISTINCT noZone, catZone, tauxZone FROM V0_LesPlaces;

INSERT INTO LesReductions VALUES ('senior',0.8);
INSERT INTO LesReductions VALUES ('adherent',0.5);
INSERT INTO LesReductions VALUES ('etudiant',0.8);
INSERT INTO LesReductions VALUES ('militaire',0.4);
INSERT INTO LesReductions VALUES ('scolaire',0.3);
INSERT INTO LesReductions VALUES ('personneNormal',0);

INSERT INTO LesDossiers_base VALUES (1,'24/12/2019 21:00');
INSERT INTO LesDossiers_base VALUES (2,'24/12/2019 11:00');
INSERT INTO LesDossiers_base VALUES (3,'23/12/2019 17:00';
INSERT INTO LesDossiers_base VALUES (4,'20/12/2019 18:00');
INSERT INTO LesDossiers_base VALUES (5,'21/12/2019 19:00');
INSERT INTO LesDossiers_base VALUES (6,'25/12/2019 17:00');
INSERT INTO LesDossiers_base VALUES (7,'25/12/2019 21:00');

INSERT INTO LesVentes VALUES (1,1,'24/12/2019 17:00',1,'senior');
INSERT INTO LesVentes VALUES (2,2,'24/12/2019 17:00',1,'personneNormal');
INSERT INTO LesVentes VALUES (2,1,'24/12/2019 17:00',1,'etudiant');
INSERT INTO LesVentes VALUES (4,1,'24/12/2019 17:00',1,'personneNormal');
INSERT INTO LesVentes VALUES (1,1,'25/12/2019 20:00',2,'militaire');
INSERT INTO LesVentes VALUES (1,2,'25/12/2019 20:00',2,'senior');
INSERT INTO LesVentes VALUES (1,3,'25/12/2019 20:00',2,'personneNormal');
INSERT INTO LesVentes VALUES (1,4,'25/12/2019 20:00',2,'personneNormal');
INSERT INTO LesVentes VALUES (1,4,'24/12/2019 17:00',3,'scolaire');
INSERT INTO LesVentes VALUES (2,4,'24/12/2019 17:00',3,'militaire');
INSERT INTO LesVentes VALUES (3,2,'26/12/2019 21:00',4,'personneNormal');
INSERT INTO LesVentes VALUES (3,3,'26/12/2019 21:00',4,'senior');
INSERT INTO LesVentes VALUES (3,1,'24/12/2019 21:00',5,'personneNormal');
INSERT INTO LesVentes VALUES (4,1,'24/12/2019 21:00',5,'etudiant');
INSERT INTO LesVentes VALUES (2,3,'24/12/2019 21:00',5,'adherent');
INSERT INTO LesVentes VALUES (2,4,'24/12/2019 21:00',5,'personneNormal');
INSERT INTO LesVentes VALUES (1,1,'25/12/2019 23:00',6,'personneNormal');
INSERT INTO LesVentes VALUES (1,2,'25/12/2019 23:00',6,'etudiant');
INSERT INTO LesVentes VALUES (3,1,'25/12/2019 23:00',7,'personneNormal');