


/******************************************************************************/
/***                               Generators                               ***/
/******************************************************************************/

CREATE GENERATOR GEN_NAKL_ID;
SET GENERATOR GEN_NAKL_ID TO 2;

CREATE GENERATOR GEN_OTDEL_ID;
SET GENERATOR GEN_OTDEL_ID TO 1;

CREATE GENERATOR GEN_STRN_ID;
SET GENERATOR GEN_STRN_ID TO 2;

CREATE GENERATOR GEN_TOVAR_ID;
SET GENERATOR GEN_TOVAR_ID TO 2;



/******************************************************************************/
/***                               Exceptions                               ***/
/******************************************************************************/

CREATE EXCEPTION TOV_EXP 'У данного товара не задана цена';



/******************************************************************************/
/***                                 Tables                                 ***/
/******************************************************************************/



CREATE TABLE NAKL (
    NAKL_N   INTEGER NOT NULL,
    NOMER_N  INTEGER,
    N_DATA   DATE,
    ITOGO    DOUBLE PRECISION,
    MOL1     VARCHAR(50),
    N_OTD    INTEGER NOT NULL
);

CREATE TABLE OTDEL (
    N_OTD    INTEGER NOT NULL,
    NAZV_OT  VARCHAR(50),
    MOL2     VARCHAR(50)
);

CREATE TABLE STRN (
    NOM_STRN  INTEGER NOT NULL,
    KOLVO     INTEGER,
    STOIM     DOUBLE PRECISION,
    NAKL_N    INTEGER NOT NULL,
    NOM_TOV   INTEGER NOT NULL
);

CREATE TABLE TEST_TRIGGERS (
    PK             INTEGER NOT NULL,
    COLV           INTEGER,
    ONE            INTEGER,
    SUMA           INTEGER,
    GET_TOV        INTEGER,
    SET_FROM_NAKL  INTEGER,
    "4"            INTEGER,
    "5"            INTEGER,
    "6"            INTEGER,
    "7"            INTEGER
);

CREATE TABLE TOVAR (
    NOM_TOV  INTEGER NOT NULL,
    NAZV     VARCHAR(50),
    CENA     DOUBLE PRECISION
);



/******************************************************************************/
/***                              Primary Keys                              ***/
/******************************************************************************/

ALTER TABLE NAKL ADD CONSTRAINT PK_NAKL PRIMARY KEY (NAKL_N);
ALTER TABLE OTDEL ADD CONSTRAINT PK_OTDEL PRIMARY KEY (N_OTD);
ALTER TABLE STRN ADD CONSTRAINT PK_STRN PRIMARY KEY (NOM_STRN, NAKL_N);
ALTER TABLE TEST_TRIGGERS ADD CONSTRAINT PK_TEST_TRIGGERS PRIMARY KEY (PK);
ALTER TABLE TOVAR ADD CONSTRAINT PK_TOVAR PRIMARY KEY (NOM_TOV);


/******************************************************************************/
/***                              Foreign Keys                              ***/
/******************************************************************************/

ALTER TABLE NAKL ADD CONSTRAINT FK_NAKL_1 FOREIGN KEY (N_OTD) REFERENCES OTDEL (N_OTD);
ALTER TABLE STRN ADD CONSTRAINT FK_STRN_1 FOREIGN KEY (NAKL_N) REFERENCES NAKL (NAKL_N) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE STRN ADD CONSTRAINT FK_STRN_2 FOREIGN KEY (NOM_TOV) REFERENCES TOVAR (NOM_TOV) ON DELETE CASCADE ON UPDATE CASCADE;


/******************************************************************************/
/***                                Triggers                                ***/
/******************************************************************************/


SET TERM ^ ;



/******************************************************************************/
/***                          Triggers for tables                           ***/
/******************************************************************************/



/* Trigger: GET_CENA */
CREATE TRIGGER GET_CENA FOR STRN
ACTIVE BEFORE INSERT OR UPDATE POSITION 0
AS
declare variable cen double precision;
begin
   select tovar.cena from tovar where tovar.nom_tov = new.nom_tov into :cen;
   if(cen is null) then
        exception tov_exp;
   else
   begin
   new.stoim = 0;
   new.stoim = new.kolvo * cen;
   end

end
^

/* Trigger: NAKL_BI */
CREATE TRIGGER NAKL_BI FOR NAKL
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.nakl_n is null) then
    new.nakl_n = gen_id(gen_nakl_id,1);
end
^

/* Trigger: OTDEL_BI */
CREATE TRIGGER OTDEL_BI FOR OTDEL
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.n_otd is null) then
    new.n_otd = gen_id(gen_otdel_id,1);
end
^

/* Trigger: STRN_BI */
CREATE TRIGGER STRN_BI FOR STRN
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.nom_strn is null) then
    new.nom_strn = gen_id(gen_strn_id,1);
end
^

/* Trigger: TEST_TRIG1 */
CREATE TRIGGER TEST_TRIG1 FOR TEST_TRIGGERS
ACTIVE BEFORE INSERT POSITION 0
AS
begin
  new.suma = new.one * new.colv;
  /* Trigger text */
end
^

/* Trigger: TEST_TRIG2 */
CREATE TRIGGER TEST_TRIG2 FOR TEST_TRIGGERS
ACTIVE BEFORE INSERT POSITION 0
AS
declare variable a integer;
begin
   select tovar.cena from tovar where tovar.nom_tov = new.one into :a;
   new.get_tov = a;
  /* Trigger text */
end
^

/* Trigger: TEST_TRIG3 */
CREATE TRIGGER TEST_TRIG3 FOR TEST_TRIGGERS
ACTIVE BEFORE INSERT POSITION 0
AS
begin
  select nakl.nomer_n from nakl where nakl.nakl_n = new.pk into new.set_from_nakl  ;
end
^

/* Trigger: TOVAR_BI */
CREATE TRIGGER TOVAR_BI FOR TOVAR
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.nom_tov is null) then
    new.nom_tov = gen_id(gen_tovar_id,1);
end
^

SET TERM ; ^

