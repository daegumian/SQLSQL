
���� 14
--DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�

--�ο���
SELECT DEPARTMENT_ID, COUNT(*) 
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY COUNT(*) DESC;

SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.MANAGER_ID, A.�����
FROM DEPARTMENTS D
RIGHT JOIN (SELECT DEPARTMENT_ID, COUNT(*) AS �����
                                                     FROM EMPLOYEES
                                                    GROUP BY DEPARTMENT_ID
                                                    ) A
ON(D.DEPARTMENT_ID = A.DEPARTMENT_ID)
ORDER BY A.����� DESC;
                                        

���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���
--�μ��� ����� ������ 0���� ����ϼ��� -> NVL

SELECT * FROM DEPARTMENTS;
SELECT DEPARTMENT_NAME FROM DEPARTMENTS;

--�μ��� ��� ����
SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY))
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT * FROM LOCATIONS;
--��ġ��
SELECT L.STREET_ADDRESS, L.POSTAL_CODE, NVL(�������, 0)
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY)) AS �������
                 FROM EMPLOYEES 
                 GROUP BY DEPARTMENT_ID) E
ON (D.DEPARTMENT_ID = E.DEPARTMENT_ID)
JOIN (SELECT * FROM LOCATIONS) L
ON (D.LOCATION_ID = L.LOCATION_ID);


���� 16
-���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
����ϼ���

SELECT
FROM(SELECT L.STREET_ADDRESS, L.POSTAL_CODE, NVL(�������, 0), ROWNUM AS RN
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY)) AS �������
                                     FROM EMPLOYEES 
                                     GROUP BY DEPARTMENT_ID) E
                    ON (D.DEPARTMENT_ID = E.DEPARTMENT_ID)
                    JOIN (SELECT * FROM LOCATIONS) L
                    ON (D.LOCATION_ID = L.LOCATION_ID)
                    ORDER BY D.DEPARTMENT_ID DESC
                    )
WHERE 1 < RN AND 

SELECT L.STREET_ADDRESS, L.POSTAL_CODE, NVL(�������, 0), ROWNUM AS RN
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY)) AS �������
                 FROM EMPLOYEES 
                 GROUP BY DEPARTMENT_ID) E
ON (D.DEPARTMENT_ID = E.DEPARTMENT_ID)
JOIN (SELECT * FROM LOCATIONS) L
ON (D.LOCATION_ID = L.LOCATION_ID)
ORDER BY D.DEPARTMENT_ID DESC
WHERE RN > 1 AND RN < 10;




