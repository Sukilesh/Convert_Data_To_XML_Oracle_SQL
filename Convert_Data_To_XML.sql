--Convert Data to XML Format

SELECT XMLAGG(
         XMLELEMENT("employee", 
           XMLFOREST(
             emp_id AS "id", 
             emp_name AS "name", 
             department AS "dept"
           )
         )
         ORDER BY emp_id
       ).getClobVal() AS employee_xml
FROM employees;

--Generate comma seperated resultset for large charecter output
-- First convert Data to XML as CLOB then extract text from CLOB

SELECT LTRIM(RTRIM(XMLAGG(
         XMLELEMENT("employee", 
           XMLFOREST( 
             emp_name||',' AS "name" 
           )
         )
         ORDER BY emp_id
       ).EXTRACT('//text()').getClobVal(),','),',') AS employee_name_list
FROM employees;