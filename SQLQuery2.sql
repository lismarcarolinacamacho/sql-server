create database escuela;
use escuela;

-- Tabla materia
create table materia(
 clave_m int,
 nom_m varchar(50), 
 cred_m float,  
 constraint pk_cm primary key(clave_m)
);


insert into materia values(1,'Matematicas',4);
insert into materia values(2,'Ingles Técnico',3);


select * from materia;

-- Tabla profesor 
create table profesor(
clave_p int, 
nom_p varchar(150),
dir_p varchar(200),
tel_p bigint,
horario_p datetime,
constraint pk_cp primary key(clave_p) 
);

insert into profesor values(1,'José Perez','Calle 1',412122,'14:00');
insert into profesor values (2,'Maria Jose','Calle 1',412122,'9:00');

select * from profesor;

--Tabla carrera
create table carrera(
clave_c int,
nom_c varchar(50),
durac_c float, 
constraint pk_cc primary key(clave_c)
);


insert into carrera values(1,'Derecho',3);
insert into carrera values(2,'Ingenieria en Sistemas',4);

select * from carrera;

 
/* Tabla alumno
(con una clave foranea) */
create table alumno(
mat_alu int, 
nombre_alu varchar(150), 
edad_alu int, 
sem_alu int, 
gen_alu varchar(10),
clave_c1 int, 
constraint pk_calu primary key(mat_alu),
constraint fk_fc1 foreign key(clave_c1) references carrera(clave_c)
);


insert into alumno values (1,'Ana',18,6,'Mujer',2);

select * from alumno;

select nombre_alu,gen_alu from alumno;


-- Tabla  alumno- profesor
 create table alumno_prof(
 mat_alu1 int,
 clave_p1 int,
 constraint fk_falu1 foreign key(mat_alu1) references alumno(mat_alu),
 constraint fk_fp1 foreign key(clave_p1) references profesor(clave_p)
 );

 insert into alumno_prof values (1,1);

 select * from alumno_prof;


 --Tabla Materia - alumno

 create table materia_alum(
 clave_m1 int,
 mat_alu2 int,
 constraint fk_fm1 foreign key(clave_m1) references materia(clave_m),
 constraint fk_falu2 foreign key(mat_alu2) references alumno(mat_alu)
 );

  insert into materia_alum values (1,1);

 select * from materia_alum;


create table materia_prof(
clave_m2 int,
clave_p2 int,
constraint fk_fm2 foreign key(clave_m2) references materia(clave_m),
constraint fk_p2 foreign key(clave_p2) references profesor(clave_p)
);

  insert into materia_prof values (1,2);

 select * from materia_prof;


 --Tabla carrera
insert into carrera values (3,'Diseño',3)

--Tabla materia
insert into materia values(3,'Dibujo',15)
insert into materia values(4,'Programación',20)

--Tabla alumno
insert into alumno values(2,'Sergio',19,7,'Hombre',2)
insert into alumno values(3,'Julieta',20,6,'Mujer',3)

--Alumno-Profesor
insert into alumno_prof values(2,2)
insert into alumno_prof values(3,2)

--Materia-ALumno
insert into materia_alum values(4,2)
insert into materia_alum values(3,3)
insert into materia_alum values(4,1)


select nombre_alu, edad_alu, sem_alu, nom_c,nom_p,nom_m  from alumno 
inner join carrera on alumno.clave_c1=carrera.clave_c
inner join alumno_prof on alumno_prof.mat_alu1=alumno.mat_alu
inner join profesor on profesor.clave_p=alumno_prof.clave_p1
inner join materia on materia.clave_m= alumno.mat_alu
inner join materia_alum on materia_alum.mat_alu2=alumno.mat_alu
where edad_alu>=18


-- Modificar BD

create database modificar

use modificar

create table producto(
clave_prod int,
nom_prod varchar(20),
precio float,
constraint pk_cp primary key (clave_prod))

create table cliente(
clave_clie int,
nom_clie varchar(20),
constraint pk_cc primary key (clave_clie))

create table nota(
folio int,
clave_prod1 int,
clave_clie1 int,
cant int,
subtot float,
constraint fk_cp1 foreign key (clave_prod1) references producto (clave_prod),
constraint fk_cc1 foreign key (clave_clie1) references cliente (clave_clie))

insert into producto values (1,'papas',7)
insert into producto values (2,'refresco',9)
insert into producto values (3,'refresco','')
insert into producto values (4,'refresco',NULL)


insert into cliente values (1,'ana')
insert into cliente values (2,'sergio')

insert into nota values (1,1,1,4,null)
insert into nota values (2,2,2,1,null)

select * from nota 


update cliente
set nom_clie ='laura'
where clave_clie=1 /* si no le coloco el 
where el update se aplica a todos los registros*/

select * from cliente

update nota 
set subtot=cant*precio
from nota inner join producto on producto.clave_prod=nota.clave_prod1


select * from nota

--drop , delet y truncate

--elimina todoslos registros de cliente
delete from cliente

--elimina un registro
delete from producto where clave_prod=3

delete from producto where precio=9 and clave_prod=1

select * from producto
--elimina toda la estructura de la tabla y los registros que contenga

drop table nota
use escuela
select * from alumno


drop database modificar

select * from producto

--vaciar la tabla
truncate table producto

--eliminar primero las relaciones y luego truncar las tablas en sistemas grandes se usa  mas truncate y delete


/*
para verificar si falta un valor en una columna, se puede usar IS NOT NULL
*/

SELECT nom_prod, precio from producto
where precio IS  NULL


/* la mejor manera de averiguar si una columna contiene un valor en blanco es buscar 
una columna donde la longitud que se representa como LEN sea mayor a 0,
como un valor en blanco es un campo sin nada puede excluir valores en blanco devolviendo
filas solo donde la longitud del campo es mayor que 0.*/

SELECT nom_prod, precio from producto
where len(precio)>0
