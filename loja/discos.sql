--Banco de Dados - Banco de Dados Loja (Discos)
--Felipe Daniel Dias dos Santos - 11711ECP004
--Graduação em Engenharia de Computação - Faculdade de Engenharia Elétrica - Universidade Federal de Uberlândia

create table Playlist(

PlaylistId serial not null,
pName varchar(30),
primary key (PlaylistId)	
);

create table MediaType(
	
MediaTypeId serial not null,
mName varchar(30),
primary key (MediaTypeId)
);

create table Genre(
	
GenreId serial not null,
gName varchar(30),
primary key (GenreId)
);

create table Artist(
	
ArtistId serial not null,
aName varchar(30),
primary key (ArtistId)
);

create table Album(
	
AlbumId serial not null,
Title varchar(20),
ArtistId int not null,
primary key (AlbumId),
foreign key (ArtistId) references Artist (ArtistId)
);

create table Track(
	
TrackId serial not null,
tName varchar(30),
AlbumId int not null,
MediaTypeId int not null,
GenreId int not null,
Composer varchar(30),
Milisseconds int,
Bytes int,
UnitPrice numeric(5,2),
primary key (TrackId),
foreign key (MediaTypeId) references MediaType (MediaTypeId),
foreign key (AlbumId) references Album (AlbumId),
foreign key (GenreId) references Genre (GenreId)
);

create table PlaylistTrack(

PlaylistTrackId serial not null,
TrackId int not null,
PlaylistId int not null,
primary key (PlaylistTrackId),
foreign key (PlaylistId) references Playlist (PlaylistId),
foreign key (TrackId) references Track (TrackId)
);

create table Customer(
	
CustomerId serial not null,
FirstName varchar(20),
LastName varchar(20),
Company varchar(20),
Address varchar(30),
City varchar(20),
CState varchar(20),
Country varchar(20),
PostalCode varchar(20),
Phone varchar(10),
Fax varchar(20),
Email varchar(30),
SupportRepId int,
primary key (CustomerId)
);

create table Invoice(
	
InvoiceId serial not null,
CustomerId int not null,
InvoiceDate date,
BillingAddress varchar(30),
BillingCity varchar(20),
BillingState varchar(20),
BillingCountry varchar(20),
BillingPostalCode varchar(20),
Total numeric(5, 2),
primary key (InvoiceId),
foreign key (CustomerId) references Customer (CustomerId)
);

create table InvoiceLine(
	
InvoiceLineId serial not null,
InvoiceId int not null,
TrackId int not null,
UnitPrice numeric(5, 2),
Quantity int,
primary key (InvoiceLineId),
foreign key (InvoiceId) references Invoice (InvoiceId),
foreign key (TrackId) references Track (TrackId)	
);
