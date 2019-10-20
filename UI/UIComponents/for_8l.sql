

/******************************************************************************/
/***                           Stored Procedures                            ***/
/******************************************************************************/

CREATE PROCEDURE EX_PROC (
    NEW_CENA DOUBLE PRECISION,
    ID_TOV INTEGER)
AS
BEGIN
  EXIT;
END^





CREATE PROCEDURE NEW_PROCEDURE (
    NOM_NAKL INTEGER)
RETURNS (
    ID_TOV INTEGER,
    STOIM DOUBLE PRECISION,
    NOM_STR INTEGER)
AS
BEGIN
  SUSPEND;
END^






SET TERM ; ^



/******************************************************************************/
/***                                Triggers                                ***/
/******************************************************************************/


SET TERM ^ ;



/******************************************************************************/
/***                          Triggers for tables                           ***/
/******************************************************************************/



/* Trigger: TRIG_FOR_PROC */
CREATE TRIGGER TRIG_FOR_PROC FOR TOVAR
ACTIVE AFTER UPDATE POSITION 0
AS
begin
    execute procedure ex_proc new.cena, new.nom_tov;
  /* Trigger text */
end
^

SET TERM ; ^



/******************************************************************************/
/***                           Stored Procedures                            ***/
/******************************************************************************/


SET TERM ^ ;

ALTER PROCEDURE EX_PROC (
    NEW_CENA DOUBLE PRECISION,
    ID_TOV INTEGER)
AS
begin
  update strn set strn.stoim = strn.kolvo * :new_cena where strn.nom_tov = :id_tov;
  suspend;
end^


ALTER PROCEDURE NEW_PROCEDURE (
    NOM_NAKL INTEGER)
RETURNS (
    ID_TOV INTEGER,
    STOIM DOUBLE PRECISION,
    NOM_STR INTEGER)
AS
begin

  for
  select strn.nom_strn, strn.stoim, strn.nom_tov
  from strn
  where strn.nakl_n = :nom_nakl
  into :nom_str,:stoim, :id_tov
  do
  suspend;
end^



SET TERM ; ^
