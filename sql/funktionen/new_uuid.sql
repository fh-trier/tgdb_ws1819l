CREATE OR REPLACE AND COMPILE
JAVA SOURCE NAMED "NEW_UUID"
AS
public class FrontBackEndUtils {
   public static String randomUUID() {
        return java.util.UUID.randomUUID().toString();
   }
}
/

CREATE OR REPLACE FUNCTION NEW_UUID
RETURN VARCHAR2
AS LANGUAGE JAVA
NAME 'FrontBackEndUtils.randomUUID() return java.lang.String';
/
