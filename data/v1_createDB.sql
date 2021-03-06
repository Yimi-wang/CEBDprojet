-- TODO 1.3 : Créer les tables manquantes et modifier celles ci-dessous
create table LesSpectacles(
    noSpec integer not null,
    nomSpec varchar(50) not null,
    prixBaseSpec decimal (6,2) not null,
    constraint pr_soec_noS primary key (noSpec),
    constraint ck_spec_noSpec check (noSpec > 0),
    constraint ck_spec_prixBaseSpec check (prixBaseSpec >= 0)
);

create table LesRepresentations_base(
    dateRep date not null,
    noSpec integer not null,
    promoRep decimal (4,2) not null,
    constraint pr_repr_date primary key (dateRep),
    constraint ck_rep_noSpec check (noSpec > 0),
    constraint ck_rep_promoRep check (promoRep >= 0 and promoRep <=1),
    constraint fk_rep_noSpec foreign key (noSpec) references LesSpectacles(noSpec)
);

create table LesZones(
    noZone integer not null,
    catZone varchar (50) not null,
    tauxZone decimal (4,2) not null,
    constraint pk_Zone_noZ primary key (noZone),
    constraint ck_Zone_noZone check (noZone > 0),
    constraint ck_Zone_catZone check (catZone in ('orchestre', 'balcon', 'poulailler')),
    constraint ck_Zone_tauxZone check (tauxZone >= 0)
);

create table LesPlaces(
    noPlace integer,
    noRang integer,
    noZone integer not null,
    constraint pk_Pla_noP_noR primary key (noPlace,noRang),
    constraint ck_Pla_noP check (noPlace > 0),
    constraint ck_Pla_noR check (noRang > 0),
    constraint ck_Pla_noZone check (noZone > 0),
    constraint fk_Pla_noZone foreign key (noZone) references LesZones(noZone)
);

create table LesVentes (
    noPlace integer,
    noRang integer,
    dateRep date,
    noDos integer not null,
    catR integer not null,
    constraint pk_Ven_noR_noP_dateR primary key (noPlace, noRang, dateRep),
    constraint ck_Ven_noP check (noPlace > 0),
    constraint ck_Ven_noR check (noRang > 0),
    constraint fk_Ven_noP foreign key (noPlace,noRang) references LesPlaces(noPlace,noRang),
    constraint fk_Ven_dateR foreign key (dateRep) references LesRepresentations_base (dateRep),
    constraint fk_Ven_noD foreign key (noDos) references LesDossiers_base (noDos),
    constraint fk_Ven_catR foreign key (catR) references LesReductions(catR)
);

create table LesDossiers_base (
    noDos integer not null,
    dateAchat date not null,
    constraint pk_dos_noD_date primary key (noDos),
    constraint ck_dos_noD check (noDos > 0)
);

create table LesReductions (
    catR varchar(50) not null,
    tauxR integer not null,
    constraint pk_red_catR primary key (catR),
   -- constraint ck_Zone_catR check (catR in ('etudiants', 'scolaires', 'militaires','seniors','personneNormal','adherent')),
    constraint ck_red_tauxR check (tauxR >= 0 and tauxR <1)
);

-- TODO 1.4 : Créer une vue LesRepresentations ajoutant le nombre de places disponible et d'autres possibles attributs calculés.
create view LesPlaceDisponibleView (dateRep, noPlace, noRang) as
    select dateRep, noPlace, noRang
    from LesRepresentations_base
    cross join LesPlaces
    except
    select dateRep, noPlace, noRang
    from LesVentes;

create view LesRepresentationsView(dataRep, promoRep, ptixRep, noSPec,placeDisp) as
    SELECT dateRep, promoRep, prixBaseSpec*promoRep as prixRep, noSpec,count(dateRep) as placeDosp
    FROM LesPlaceDisponibleView join LesRepresentations_base USING (dateRep)
    join LesSpectacles USING (noSpec)
    group by dateRep, promoRep, prixBaseSpec*promoRep, noSpec;

-- TODO 1.5 : Créer une vue  avec le noDos et le montant total correspondant.
create view LesTicketsView (noPlace, noRang, dateRep, prixTic) as
    select noPlace,noRang, dateRep,round(((prixBaseSpec * (promoRep) * tauxZone) * (1 - tauxR)),2) as prixTic
    from LesVentes join LesPlaces using (noPlace, noRang)
    join LesZones using (noZone)
    join LesReductions using (catR)
    join LesRepresentations_base using (dateRep)
    join LesSpectacles using (noSpec);

create view LesDossiersView (noDos, prixTotal) as
    select noDos, round(SUM(prixTic),2) as prixTotal
    from LesVentes
    join LesTicketsView
    using (noPlace,noRang,dateRep)
    group by noDos;
--2.1
create view SpeSanResView(dateRep) as
    select distinct dateRep
    from LesRepresentations_base
    except
    select distinct dateRep
    from LesVentes;
--2.2
create view PlaceReserveView(nomSpec, dateSpec,placeReservees) as
    select nomSpec, dateRep, count(noPlace) as placeReservees
    from LesSpectacles join LesRepresentations_base using (noSpec)
    left join LesVentes using (dateRep)
    group by nomSpec, dateRep
-- TODO 3.3 : Ajouter les éléments nécessaires pour créer le trigger (attention, syntaxe SQLite différent qu'Oracle)