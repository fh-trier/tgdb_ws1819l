/*==============================================================*/
/* DELETE/DROP: All resources                                   */
/*==============================================================*/
BEGIN
  FOR cur_rec IN (
    SELECT object_name, object_type
    FROM user_objects
    WHERE object_type IN (
      'TABLE',
      'VIEW',
      'PACKAGE',
      'PROCEDURE',
      'FUNCTION',
      'SEQUENCE',
      'SYNONYM',
      'PACKAGE BODY',
      'TYPE'
    )
  ) LOOP
    BEGIN
      IF cur_rec.object_type = 'TABLE' THEN
        EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '" CASCADE CONSTRAINTS';
      ELSIF cur_rec.object_type = 'TYPE' THEN
        EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '" FORCE';
      ELSE
        EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"';
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE ('FAILED: DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"');
      END;
   END LOOP;
   EXECUTE IMMEDIATE 'PURGE RECYCLEBIN';
END;
/
