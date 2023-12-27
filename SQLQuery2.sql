create database escuela;
use escuela;

-- Tabla materia

-- Go agrupa un conjunto de sentencias
go
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

/* operadores relacionales  > < <= >= = <> */
select nom_c from carrera 
where clave_c>=3


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

select * from alumno where nombre_alu <> 'Maria'

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
insert into alumno values (8,'Jose',28,6,'H',2);
insert into alumno values (9,'Juan',20,6,'H',2);
insert into alumno values (4,'Maria',19,6,'Mujer',2);
insert into alumno values (5,'Josefina',18,6,'Mujer',2);

SELECT * FROM alumno

TRUNCATE TABLE ALUMNO

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

select * from alumno

use escuela
drop database modificar

/* antes de borrar una base de datos debes usar otra porque no te va a dejar borrarla*/

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


SELECT nom_prod, ISNULL (precio,0) as NuevoValor from producto


-- eliminacion

/*

delete --> elimina registros

drop --> elimina la estructura (tabla)

truncate ---> elimina registros  resetea todo, y  los autoincrementables

*/



insert into Tabla_prueba values (1,'ana','perez',1234,'Republica',0,0)
insert into Tabla_prueba values (2,'maria','hernandez',1234,'Republica',null,null)


select * from Tabla_prueba

create table Tabla_prueba(

id int not null,
nombre varchar(50) not null,
apellido varchar(50) not null,
telefono bigint null,
calle varchar(50) null,
casa int null,
urbanizacion varchar(50) null

)




delete from Tabla_prueba

select * from Tabla_prueba

delete from Tabla_prueba
where id=1

select * from Tabla_prueba

select * from profesor

update profesor set nom_p='David'
where clave_p =2


/*

identity? es como un autoincrement 

por defecto el identity empieza en 1 y su incremento es de 1
autoincrement

*/

create table usuarios(

id int identity,
nombre varchar(50) not null,
usuario varchar(50) not null,
contrasea varchar(50) not null,
tipo_usuario varchar(50) not null, 
apellido varchar(50) null,
telefono bigint null,
calle varchar(50) null,
casa int null,
urbanizacion varchar(50) null,
edad int,
sexo varchar(1)
)

drop table usuarios
create table usuarios2(

id int identity,
nombre varchar(50) not null,


)


insert into usuarios2 values ('ana')
insert into usuarios2 values ('ana')
insert into usuarios2 values ('jose')

select * from usuarios2

/* saber desde donde esta iniciando la cuenta*/


select IDENT_SEED('usuarios2');

create table usuarios3(

id int identity(56,3),
nombre varchar(50) not null,
)

select * from usuarios3

insert into usuarios3 values ('ana')
insert into usuarios3 values ('pedro')
insert into usuarios3 values ('jose')

delete usuarios3
/* vacia la tabla*/
/* pero no resetea los identificadores 
autoincrementables */


create table libros(

id int identity (1,1) primary key,
titulo varchar(50) not null,
descripcion varchar(100),
autor varchar(50) not null,
precio_venta float not null ,
precio_compra float not null
)

drop table libros

truncate table libros

insert into libros values ('el arbol mistico','libro de misterio','ana',50,30);

insert into libros values ('Pica piedras','antiguo','ana',50,30);

select id, nombre, (precio_venta - precio_compra)
as RESULTADO from libros 

/*vender con un 10% mas 
*/

update libros set precio_venta = precio_venta + (precio_venta*0.1)
where id =1

select * from libros

/*
concatenacion = la union de 2 o mas cadenas
*/

select 'libro: '+nombre from libros
select 'libro: '+nombre+'/'+nombre as consulta from libros

/*
Funciones de agregado

SUM , COUNT, MIN , MAX
*/

select count(titulo) as cantidad_de_libros from libros 
where precio_venta <50


select  max(precio_compra) from libros


select  min(precio_venta) from libros


/*  manejo de cadenas */

select substring ('Hola a todos',8,5)

select str(123)

select stuff('Tutoriales Hackro',12,6,'Mexico')

/* devuelve la longitud de una cadena*/
select LEN('hola mi nombre es lismar')

/*devuelve el caracter*/
select char(43);

/* convertir minusculas a mayusculas y mayusculas a minusculas*/

select lower('TUTORIALES MIOS');
select UPPER('mis tutoriales');

select ltrim('    algo')

select rtrim('algo  jose')


/* reemplazar cadenas */

select replace('hola a todo saludos desde vzla','vzla','anaco')

select reverse('anita lava la tina')

/* Buscar coincidencias*/


/* regresa la cntidad de caracteres desde inicia la coincidencia*/
select patindex('%mexico%','hola a todos desde mexico')


select replicate('hola ', 7)

/* colocar espacios entre las cadenas*/

select 'tutoriales'+space(1)+'Hacking'

select * from libros
order by titulo desc
;

select * from libros
order by titulo asc,precio_venta desc;

/* operadores logicos

not !=
and &&
or ||

*/

select * from libros where not id =1

select * from libros where  id =1 or id=2 ( se puede cumplir una y otra no)

select * from libros where  id =1 and id=2 (se deben cumplir las dos condiciones)


/*funciones de fecha*/

select getdate() -- fecha y hora

select datepart(year,getdate())
select datepart(month,getdate())
select datepart(day,getdate())

select DATENAME(month,getdate()) --nombre de una parte de la fecha

/* calcula el tiempo transcurrido*/
select datediff(YEAR, '2014/01/03','2068/04/04')

select datediff(YEAR, '1989/04/03','2023/12/06')

SELECT YEAR(GETDATE()) /* OBTIENE EL AÑO*/

SELECT * FROM libros

SELECT * FROM libros where precio_venta between 200 and 300

SELECT * FROM libros where precio_venta between 50 and 100

select * from libros where not titulo is null

select * from libros where titulo like 'p%%'
/* encuentra los titulos que empiezan por p*/


select * from libros where titulo like 'p_%'

select count(*) from libros
select count(id) as cantidad from libros where id >10


/*

FUNCIONES DE AGREGACION 
esto solo aplica para numeros
count cuenta
sum suma
avg promedio
*/

select * from usuarios

insert into usuarios values ('ana','perez',1224, 'el que es', null, 112,'calle',5,'No se',25,'F')

insert into usuarios values ('JOSE','perez',1224, 'el que es', null, 112,'calle',5,'No se',25,'M')

insert into usuarios values ('Julio','perez',1224, 'el que es', null, 112,'calle',5,'No se',15,'M')


insert into usuarios values ('JUAN','perez',1224, 'el que es', null, 112,'calle',5,'No se',35,'M')


select count(id) from usuarios

select count(*) from usuarios

select sum(EDAD) from usuarios where sexo ='F'

select AVG(EDAD) from usuarios

select min(edad) from usuarios

select AVG(edad) from usuarios where sexo ='M'

select max(edad) from usuarios

select min(edad) from usuarios where sexo ='F'

/* HAVING ES UN FILTRO POR GRUPO DE REGISTROS,
el insert para las funciones de agregacion  */

SELECT nombre, avg(edad) from usuarios where sexo ='M'
GROUP BY nombre 
having avg(edad) >20

select nombre, edad from usuarios where sexo ='F'

select min(edad) from usuarios where sexo = 'F'

-- distinct - filtrará repeticiones de la consulta

select distinct edad from usuarios order by edad

select sum( distinct edad) from usuarios 

-- top limita la cantidad de registros
select top 2 * from usuarios order by id desc;


create table datos(
id_datos int identity (1,1) primary key, 
id_alumno int, 
edad_alu int, 
mail varchar(50),
constraint fk_id_alumno1 foreign key(id_alumno) references alumno(mat_alu)
);


insert into datos values (1,18, 'xl')
insert into datos values (2,19, 'sx')
insert into datos values (3,20, 'xm')

insert into datos values (4,19, 'xm')
insert into datos values (5,18, 'lx')
insert into datos values (6,19, 'x@')
insert into datos values (7,18, 'x')
insert into datos values (8,28, 'x')
insert into datos values (9,20, 'x')

select * from datos

select * from usuarios

select * from alumno

select * from carrera

select * from materia_alum

select * from materia_alum  join alumno on  materia_alum.mat_alu2=alumno.mat_alu join carrera on alumno.clave_c1=carrera.clave_c

select alumno.nombre_alu, carrera.nom_c from datos inner join alumno
on datos.id_alumno=alumno.mat_alu join carrera on alumno.clave_c1=carrera.clave_c where datos.edad_alu >18

group by alumno.nombre_alu,carrera.nom_c

select *  from alumno left join datos on datos.id_alumno =alumno.mat_alu;

update  alumno set nombre_alu = 'Cambio'
from alumno join carrera
on alumno.clave_c1=carrera.clave_c
where carrera.clave_c =12

delete alumno 
from alumno join carrera
on alumno.clave_c1=carrera.clave_c


select * from carrera

select * from alumno


alter table carrera 
add cupo_limitado int 

alter table carrera 
add cupo_minimo int

alter table carrera
drop column cupo_limitado

-- campos calculados 

alter table carrera
add suma as (cupo_limitado - 100)
alter table carrera 
add resta as (cupo_minimo + 100)

INSERT INTO carrera (cupo_minimo, cupo_limitado) VALUES (10,0);

INSERT INTO carrera (cupo_minimo, cupo_limitado) VALUES (15,0);
INSERT INTO carrera (cupo_minimo, cupo_limitado) VALUES (20,0);



INSERT INTO carrera  VALUES (4,'Medicina',10,20,30 );

select * from carrera
select * from libros
update  carrera set cupo_minimo = 10,cupo_limitado=20

where carrera.clave_c =1

-- subconsultas
select * from carrera where carrera.clave_c= (select clave_c from carrera where clave_c=1)

select * from libros where id = (select id from libros where titulo ='el arbol mistico')

select * from libros where id in(2,4)

alter table libros
add num_pag int 

update  libros set num_pag = 100
where libros.id =1

update  libros set num_pag = 500
where libros.id =2

select * from libros where id in (select id from libros where num_pag>=500)

select * from usuarios 
where sexo ='F' and edad=any(select edad from usuarios
where sexo='M')

select * from usuarios 
where sexo ='M' and edad=any(select edad from usuarios
where sexo='F') 

update usuarios set tipo_usuario ='Root' where id = any
(select id from usuarios where edad >24 )


update usuarios set tipo_usuario ='Root' where edad >24 

delete usuarios where tipo_usuario = any (
select tipo_usuario from usuarios
where edad <=15
)

select * from usuarios

insert into nombre ('nombre')
select nombre
from usuarios

--https://www.youtube.com/watch?v=IXmsQsvMJJs

--las vitsas son tablas virtuales creadas atraves de una consulta

create view usuarios_vista as 

select nombre from usuarios

/* las diferencia entre vista y tabla es que las tablas tiene relaciones
las vistas no porque son tablas virtuales
*/

drop view usuarios_vista

create view mujeres as
select * from usuarios where sexo='F'

select * from mujeres order by edad

update mujeres set tipo_usuario='Root'
where edad >25

delete view mujeres


create view copy as 
select * from usuarios 
where sexo='M'
with check option

select * from copy

sp_helptext copy

alter view copy
as select * from usuarios

/* se actualiza la tabla vuelviendose  a seleccionar todos los usuarios
*/
select * from copy

drop view copy

select * from usuarios

create view copy 
with encryption as select * from usuarios

/*
Lenguaje de control de flujo CASE */

select id, nombre, edad =
case edad	
	when 25 then 'Menor'
	when 35 then 'Mayor'
end
from usuarios 

/*
CONRTOL DE FLUJO IF */



