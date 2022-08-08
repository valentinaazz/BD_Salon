--Crearea tabelelor
CREATE TABLE angajati_salon
( id_angajat number(5) CONSTRAINT pk_angajat PRIMARY KEY,
  nume varchar2(20) NOT NULL,
  prenume varchar2(20) NOT NULL,
  denumire_functie varchar2(20) NOT NULL,
  salariul number(6) );

ALTER TABLE angajati_salon
ADD CONSTRAINT ang_salon_salariul_min
CHECK (salariul>0);

CREATE TABLE clienti_salon
( id_client number(5) CONSTRAINT pk_client PRIMARY KEY,
  nume varchar2(20) NOT NULL,
  prenume varchar2(20) NOT NULL,
  telefon varchar2(10) NOT NULL,
  email varchar(25) NOT NULL,
  CONSTRAINT uq_email UNIQUE(email) );

CREATE TABLE programari
(id_programare number(5) CONSTRAINT pk_programare PRIMARY KEY,
data timestamp(6) with time zone NOT NULL,
id_client number(5),
id_angajat number(5),
CONSTRAINT fk_client_salon FOREIGN KEY (id_client) REFERENCES clienti_salon(id_client),
CONSTRAINT fk_ang_salon FOREIGN KEY (id_angajat) REFERENCES angajati_salon(id_angajat));
CREATE TABLE furnizori
(id_furnizor number(5) CONSTRAINT pk_furnizor PRIMARY KEY,
nume varchar2(20) NOT NULL,
prenume varchar2(20) NOT NULL,
telefon varchar2(10) NOT NULL,
email varchar(25) NOT NULL,
CONSTRAINT uq_email_f UNIQUE(email) );


CREATE TABLE comenzi_salon
(id_comanda number(5) CONSTRAINT pk_comanda PRIMARY KEY,
data timestamp(6) with local time zone NOT NULL,
id_angajat number(5),
id_furnizor number(5),
CONSTRAINT fk_ang_salon1 FOREIGN KEY (id_angajat) REFERENCES angajati_salon(id_angajat),
CONSTRAINT fk_furnizor FOREIGN KEY (id_furnizor) REFERENCES furnizori(id_furnizor));


CREATE TABLE produse_salon
(id_produs number(5) CONSTRAINT pk_idprodsal PRIMARY KEY,
denumire_produs varchar2(20),
stoc number(5) NOT NULL);



CREATE TABLE lista_comenzi
(id_comanda number(5) NOT NULL,
id_produs number(5) NOT NULL,
pret number(8,2) CHECK(pret>=0),
cantitate number(5) CHECK(cantitate>=0),
CONSTRAINT pk_listacomenzi PRIMARY KEY(id_comanda,id_produs),
CONSTRAINT fk_idcom FOREIGN KEY (id_comanda) REFERENCES comenzi_salon(id_comanda),
CONSTRAINT fk_idprods FOREIGN KEY (id_produs) REFERENCES produse_salon(id_produs) );




CREATE TABLE servicii_salon
(id_serviciu number(5) CONSTRAINT pk_serviciu PRIMARY KEY,
denumire_serviciu varchar2(20) NOT NULL,
pret number(8,2) CHECK (pret>=0));

CREATE TABLE detalii_programari
(id_programare number(5) NOT NULL,
id_serviciu number(5) NOT NULL,

CONSTRAINT pk_detaliiprog PRIMARY KEY(id_programare,id_serviciu),
CONSTRAINT fk_idprogr FOREIGN KEY (id_programare) REFERENCES programari(id_programare),
CONSTRAINT fk_idserv FOREIGN KEY (id_serviciu) REFERENCES servicii_salon(id_serviciu));

CREATE TABLE detalii_servicii
(id_produs number(5) NOT NULL,
id_serviciu number(5) NOT NULL,
cantitate number(5) NOT NULL,
CONSTRAINT fk_idproddus FOREIGN KEY (id_produs) REFERENCES produse_salon(id_produs),
CONSTRAINT fk_idservic FOREIGN KEY (id_serviciu) REFERENCES servicii_salon(id_serviciu));


--Adaugarea datelor in tabele

INSERT INTO angajati_salon 
VALUES (2,'Ionescu','Matei', 'Frizer', 2700 );

INSERT INTO angajati_salon 
VALUES (3,'Morariu','Vlad', 'Stilist', 3000 );

INSERT INTO angajati_salon 
VALUES (4,'Micu','Beatrice', 'Tehnician Unghii', 2400 );

INSERT INTO angajati_salon 
VALUES (5,'Bodnaras','Denisa', 'Make-up Artist', 2200 );

INSERT INTO angajati_salon 
VALUES (1,'Popescu','Andreea', Cosmetician, 2500 );

INSERT INTO angajati_salon 
VALUES (6,'Stefanescu','Mihai', 'Frizer', 2800 );

INSERT INTO angajati_salon 
VALUES (7,'Chiroiu','Alexandra', 'Stilist', 3200 );

INSERT INTO angajati_salon 
VALUES (8,'Burdun','Ana', 'Tehnician Unghii', 2400 );

INSERT INTO angajati_salon 
VALUES (9,'Copaci','Maria', 'Make-up Artist', 2400 );
INSERT INTO angajati_salon 
VALUES (10,'Codina','Cristina', 'Cosmetician', 2200 );




INSERT INTO clienti_salon
VALUES (1,'Ianus', 'Andrei', '0732233642', 'ianus.andrei@yahoo.com' );

INSERT INTO clienti_salon
VALUES (2,'Radu', 'Andrei', '0731243644', 'radu.andrei@yahoo.com' );

INSERT INTO clienti_salon
VALUES (3,'Manea', 'Veronica', '0721253242', 'mveronica@yahoo.com' );

INSERT INTO clienti_salon
VALUES (4,'Tica', 'Andreea', '0745235612', 'tica_andreea@yahoo.com' );

INSERT INTO clienti_salon
VALUES (5,'Calin', 'Robert', '0764133651', 'robertcalin@yahoo.com' );

INSERT INTO clienti_salon
VALUES (6,'Bogaciu', 'Maria', '0739273611', 'mbogaciu@yahoo.com' );

INSERT INTO clienti_salon
VALUES (7,'Verboncu', 'Andreea', '0723543842', 'averboncu@yahoo.com' );

INSERT INTO clienti_salon
VALUES (8,'Voiculescu', 'Mihai', '0744653687', 'voiculescumihai@yahoo.com' );

INSERT INTO clienti_salon
VALUES (9,'Vaciu', 'Mihnea', '0779243567', 'vc.mihnea@yahoo.com' );

INSERT INTO clienti_salon
VALUES (10,'Costache', 'Diana', '0731673619', 'dianacostache@yahoo.com' );





INSERT INTO programari
VALUES(1,to_timestamp('02-12-2020 10:30:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1,2);

INSERT INTO programari
VALUES(2,to_timestamp('02-12-2020 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 2,6);

INSERT INTO programari
VALUES(3,to_timestamp('03-12-2020 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 3,8);

INSERT INTO programari
VALUES(4,to_timestamp('03-12-2020 14:30:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 3,9);

INSERT INTO programari
VALUES(5,to_timestamp('05-12-2020 16:15:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 4,1);

INSERT INTO programari
VALUES(6,to_timestamp('05-12-2020 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 5,2);

INSERT INTO programari
VALUES(7,to_timestamp('05-12-2020 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 6,1);

INSERT INTO programari
VALUES(8,to_timestamp('07-12-2020 12:45:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 7,3);

INSERT INTO programari
VALUES(9,to_timestamp('10-12-2020 13:50:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 8,2);

INSERT INTO programari
VALUES(10,to_timestamp('10-12-2020 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 9,6);

INSERT INTO programari
VALUES(11,to_timestamp('10-12-2020 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 10,5);

INSERT INTO furnizori
VALUES (1, 'Tudorache','Ioana','0745332156', 'tudorace.irina@yahoo.com' );

INSERT INTO furnizori
VALUES (2, 'Petrescu','Ruxandra','0734662756', 'rpetrescu@yahoo.com' );

INSERT INTO furnizori
VALUES (3, 'Ianculescu','Denise','0722562159', 'dianculescu@yahoo.com' );

INSERT INTO furnizori
VALUES (4, 'Marin','Diana','0721852157', 'dianamarin@yahoo.com' );

INSERT INTO furnizori
VALUES (5, 'Marinescu','Cristian','0799653441', 'mcristian@yahoo.com' );





INSERT INTO comenzi_salon
VALUES (1, to_timestamp('15-11-2020 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 3,1  );

INSERT INTO comenzi_salon
VALUES (2, to_timestamp('15-11-2020 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 4,2  );

INSERT INTO comenzi_salon
VALUES (3, to_timestamp('17-11-2020 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 5,3  );
INSERT INTO comenzi_salon
VALUES (4, to_timestamp('18-11-2020 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1,4  );

INSERT INTO comenzi_salon
VALUES (5, to_timestamp('21-11-2020 13:30:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 2,5  );
INSERT INTO produse_salon
VALUES (1,'Sampon', 100 );

INSERT INTO produse_salon
VALUES(2,'Balsam',90);

INSERT INTO produse_salon
VALUES(3,'Masca', 50);

INSERT INTO produse_salon
VALUES(4,'Ceara',75);

INSERT INTO produse_salon
VALUES(5,'Benzi',200);

INSERT INTO produse_salon
VALUES(6,'Ulei',50);


INSERT INTO produse_salon
VALUES(7,'Fixativ',80);


INSERT INTO produse_salon
VALUES(8,'Gel unghii',25);

INSERT INTO produse_salon
VALUES(9,'Oja',200);

INSERT INTO produse_salon
VALUES(10,'Pila',60);

INSERT INTO produse_salon
VALUES(11,'Fond de ten',30);

INSERT INTO produse_salon
VALUES(12,'Pudra',25);

INSERT INTO produse_salon
VALUES(13,'Fard pleoape',35);

INSERT INTO produse_salon
VALUES(14,'Rimel',20);

INSERT INTO produse_salon
VALUES(15,'Creion de ochi',15);

INSERT INTO produse_salon
VALUES(16,'Ruj',18);


INSERT INTO produse_salon
VALUES(17,'Pensule',35);

INSERT INTO produse_salon
VALUES(18,'Vopsea',75);


INSERT INTO produse_salon
VALUES(19,'Decolorant',65);

INSERT INTO produse_salon
VALUES(20,'Blush',10);

INSERT INTO produse_salon
VALUES(21,'Foarfeca',15);

INSERT INTO produse_salon
VALUES(22,'Perie',16);

INSERT INTO produse_salon
VALUES(23,'Uscator de par',5);

INSERT INTO produse_salon
VALUES(24,'Penseta',10);

INSERT INTO produse_salon
VALUES(25,'Crema hidratanta',20);

INSERT INTO produse_salon
VALUES(26,'Masina de tuns',10);



INSERT INTO lista_comenzi
VALUES (1,1,5,50);

INSERT INTO lista_comenzi
VALUES (2,9,21,25);

INSERT INTO lista_comenzi
VALUES (3,10,4,30);

INSERT INTO lista_comenzi
VALUES (4,14,33.5,20);

INSERT INTO lista_comenzi
VALUES (5,18,15.5,50);


INSERT INTO servicii_salon
VALUES (1,'Spalare', 20);

INSERT INTO servicii_salon
VALUES (2, 'Tuns', 30);

INSERT INTO servicii_salon
VALUES (3, 'Coafat', 30);
INSERT INTO servicii_salon
VALUES (4,'Vopsit par scurt', 100);

INSERT INTO servicii_salon
VALUES (5, 'Vopsit par lung', 250);

INSERT INTO servicii_salon
VALUES (6, 'Manichiura',80);

INSERT INTO servicii_salon
VALUES (7, 'Pedichiura', 50);

INSERT INTO servicii_salon
VALUES (8, 'Epilat total', 150);

INSERT INTO servicii_salon
VALUES (9, 'Epilat partial', 80);

INSERT INTO servicii_salon
VALUES (10, 'Pensat', 30);
INSERT INTO servicii_salon
VALUES (11, 'Tratament facial', 150);

INSERT INTO servicii_salon
VALUES (12, 'Machiaj de zi', 200);

INSERT INTO servicii_salon
VALUES (13,'Machiaj de seara', 250);
INSERT INTO servicii_salon
VALUES (14, 'Machiaj mireasa', 300);

INSERT INTO servicii_salon
VALUES (15, 'Barbierit', 50);



INSERT INTO detalii_servicii
VALUES(1,1,1);

INSERT INTO detalii_servicii
VALUES(2,1,1);

INSERT INTO detalii_servicii
VALUES(3,1,1);

INSERT INTO detalii_servicii
VALUES(21,2,1);
INSERT INTO detalii_servicii
VALUES(22,2,1);

INSERT INTO detalii_servicii
VALUES(23,2,1);

INSERT INTO detalii_servicii
VALUES(22,3,1);

INSERT INTO detalii_servicii
VALUES(23,3,1);

INSERT INTO detalii_servicii
VALUES(7,3,1);

INSERT INTO detalii_servicii
VALUES(17,4,1);

INSERT INTO detalii_servicii
VALUES(18,4,1);

INSERT INTO detalii_servicii
VALUES(17,5,1);

INSERT INTO detalii_servicii
VALUES(18,5,2);


INSERT INTO detalii_servicii
VALUES(9,6,1);

INSERT INTO detalii_servicii
VALUES(10,6,1);


INSERT INTO detalii_servicii
VALUES(9,7,1);

INSERT INTO detalii_servicii
VALUES(10,7,1);

INSERT INTO detalii_servicii
VALUES(4,8,1);

INSERT INTO detalii_servicii
VALUES(5,8,1);

INSERT INTO detalii_servicii
VALUES(4,9,1);

INSERT INTO detalii_servicii
VALUES(5,9,1);

INSERT INTO detalii_servicii
VALUES(24,10,1);

INSERT INTO detalii_servicii
VALUES(25,11,1);

INSERT INTO detalii_servicii
VALUES(11,12,1);


INSERT INTO detalii_servicii
VALUES(12,12,1);

INSERT INTO detalii_servicii
VALUES(13,12,1);

INSERT INTO detalii_servicii
VALUES(14,12,1);

INSERT INTO detalii_servicii
VALUES(11,13,1);

INSERT INTO detalii_servicii
VALUES(12,13,1);

INSERT INTO detalii_servicii
VALUES(13,13,1);

INSERT INTO detalii_servicii
VALUES(14,13,1);

INSERT INTO detalii_servicii
VALUES(15,13,1);

INSERT INTO detalii_servicii
VALUES(16,13,1);


INSERT INTO detalii_servicii
VALUES(11,14,1);

INSERT INTO detalii_servicii
VALUES(12,14,1);

INSERT INTO detalii_servicii
VALUES(13,14,1);

INSERT INTO detalii_servicii
VALUES(14,14,1);

INSERT INTO detalii_servicii
VALUES(15,14,1);

INSERT INTO detalii_servicii
VALUES(16,14,1);

INSERT INTO detalii_servicii
VALUES(21,15,1);

INSERT INTO detalii_servicii
VALUES(26,15,1);





INSERT INTO detalii_programari
VALUES (1,2);

INSERT INTO detalii_programari
VALUES (1,15);

INSERT INTO detalii_programari
VALUES (2,15);

INSERT INTO detalii_programari
VALUES (3,6);

INSERT INTO detalii_programari
VALUES (3,7);

INSERT INTO detalii_programari
VALUES (4,12);

INSERT INTO detalii_programari
VALUES (5,10);

INSERT INTO detalii_programari
VALUES (5,11);

INSERT INTO detalii_programari
VALUES (6,2);


INSERT INTO detalii_programari
VALUES (7,8);

INSERT INTO detalii_programari
VALUES (8,4);

INSERT INTO detalii_programari
VALUES (8,1);

INSERT INTO detalii_programari
VALUES (8,2);

INSERT INTO detalii_programari
VALUES (8,3);

INSERT INTO detalii_programari
VALUES (9,15);

INSERT INTO detalii_programari
VALUES (10,15);

INSERT INTO detalii_programari
VALUES (11,14);
   


--Interogari

--sa se afiseze pentru fiecare angajat id-ul,numele, prenumele si numarul de comenzi date

select a.id_angajat, nume, prenume, count(id_comanda) AS "Numarul de comenzi date"
from angajati_salon a, comenzi_salon c
where a.id_angajat=c.id_angajat
group by a.id_angajat, nume, prenume;



--sa se afiseze angajatii care au salariul mai mare ca media salariilor

select id_angajat, nume, prenume, salariul
from angajati_salon
where salariul> (select AVG(salariul) from angajati_salon);



--sa se afiseze pentru fiecare angajat numarul de programari

select a.id_angajat, nume, count(id_programare) as “Numarul de programari”
from angajati_salon a, programari p
where a.id_angajat=p.id_angajat 
group by a.id_angajat, nume;




--sa se afiseze numele si prenumele clientilor care au programari in luna decembrie

select c.id_client, nume, prenume, data
from clienti_salon c, programari p
where c.id_client=p.id_client AND
extract (month from data)=12;



--sa se afiseze id-ul si numele produselor folosite pentru serviciul cu id-ul=12;

select d.id_produs, id_serviciu, denumire_produs
from detalii_servicii d, produse_salon p
where id_serviciu=12 AND d.id_produs=p.id_produs;




--sa se afiseze salariul marit al angajatiilor astfel: cu 5% celor cu functia de Frizer, cu 10% celor cu functia de Cosmetician  si cu 15% celorlalti

select nume, prenume, salariul, denumire_functie,
CASE when denumire_functie= 'Frizer' then salariul*1.05
when denumire_functie='Cosmetician' then salariul*1.1
else salariul*1.15
END AS Salariul_marit
from angajati_salon;


--sa se mareasca stocul produselor astfel: cele cu denumire_produs "Fixativ" cu 10 bucati, cele cu denumire_produs "Masina de tuns" cu 5 bucati iar restul cu 3 bucati.

select id_produs, denumire_produs, stoc,
decode(denumire_produs, 'Fixativ',10, 'Masina de tuns',5,3)+stoc AS Stoc_actualizat
from produse_salon;




--sa se afiseze id-ul si denumirea serviciilor care necesita mai mult de 3 produse

select d.id_serviciu, denumire_serviciu,count(id_produs)
from detalii_servicii d, servicii_salon s
where d.id_serviciu=s.id_serviciu
having count(id_produs)>3
group by d.id_serviciu, denumire_serviciu;



--sa se afiseze comenzile plasate prin intermediul furnizorului cu numele Marin

select c.id_furnizor, nume, prenume, id_comanda
from furnizori f, comenzi_salon c
where f.id_furnizor=c.id_furnizor
AND nume='Marin';




--sa se afiseze angajatii care nu au plasat comenzi

select id_angajat, nume, prenume
from angajati_salon
where id_angajat NOT IN (select id_angajat
from comenzi_salon);



--sa se afiseze in ordine descrescatoare serviciile cu pretul mai mare decat media preturilor

select id_serviciu, denumire_serviciu, pret
from servicii_salon
where pret> (select AVG(pret) from servicii_salon)
order by pret desc;



--sa se creeze tabela copy_angajati_salon pe baza angajati_salon, sa se stearga angajatul cu id-ul=2 din tabela copie si sa se  mareasca salariul tuturor angajatilor din tabela angajati_salon. 
--sa se updateze sau insereze in tabela copy_angajati_salon pe baza tabelei angajati_salon.
create table copy_angajati_salon
as select * from  angajati_salon;
delete from copy_angajati_salon
where id_angajat=2;
update angajati_salon
set salariul=salariul*1.1;
merge into copy_angajati_salon c using angajati_salon a
on (c.id_angajat=a.id_angajat)
when matched then update
set 
c.nume=a.nume,
c.prenume=a.prenume,
c.denumire_functie=a.denumire_functie,
c.salariul=a.salariul
when not matched then insert
values (a.id_angajat, a.nume, a.prenume, a.denumire_functie,a.salariul);



--creează o tabelă nouă, numită Clienti_dec, pe baza tabelei Clienti_salon. Noua tabelă va conține informații despre clienții care au avut programări în luna decembrie.

create table Clienti_dec
as select * from clienti_salon
where id_client in (select id_client
from programari
where extract(month from data)=12)




--dublează prețul produselor achizitionate de la furnizorul cu numele Marin.

update lista_comenzi
set pret=pret*2
where id_comanda= ( select id_comanda
from furnizori f, comenzi_salon c
where f.id_furnizor=c.id_furnizor
AND nume='Marin')



--sa se afiseze id-ul si denumirea serviciilor cu majuscule care necesita mai mult de 3 produse

select d.id_serviciu, UPPER(denumire_serviciu) AS Serviciu, count(id_produs) AS "Numarul de produse utilizate"
from detalii_servicii d, servicii_salon s
where d.id_serviciu=s.id_serviciu
having count(id_produs)>3
group by d.id_serviciu, denumire_serviciu;



--sa se creeze view-ul frizeri care sa contina id-ul, numele si prenumele angajatilor care au denumirea functiei frizer.

create or replace view frizeri
as select id_angajat, nume, prenume
from angajati_salon
where LOWER(denumire_functie)='frizer'
with read only;





--sa se creeze view-ul programari decembrie care sa contina id_programare, data  si numele angajatului

create or replace view Programari_decembrie
as select  a.id_angajat,nume, data,  id_programare
from programari p, angajati_salon a
where a.id_angajat=p.id_angajat and extract(month from data)=12
order by data;

 



--sa se creeze tabela echipamente_salon care sa contina id_echipament, denumire_echipament si cantitate. Sa se insereze valori folosind secvente.

create table echipamente_salon
(  id_echipament number(5) CONSTRAINT pk_echipament PRIMARY KEY,
    denumire_echipament varchar2(25),
    cantitate number(5));

create sequence id_echipament_seq
increment by 1
start with 1
maxvalue 500
nocache
nocycle;
insert into echipamente_salon
values (id_echipament_seq.NEXTVAL, 'Canapea', 3);
insert into echipamente_salon
values (id_echipament_seq.NEXTVAL, 'Imprimanta', 1);
insert into echipamente_salon
values (id_echipament_seq.NEXTVAL, 'Televizor', 2);


--sa se creeze un index pentru numele si prenumele angajatilor.
create index nume_idx
on angajati_salon(nume,prenume);




--sa se creeze un sinonim pentru tabela copy_angajati_salon
create synonym cp_ang
for copy_angajati_salon;



select *
from cp_ang;

 
