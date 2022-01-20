# Connect

Join LibreOffice Calc with POSTGRESQL

## Script





## Install LibreOffice Base

The current version of LibreOffice is 6.2, but your operating system may have
installed from Package manager a older version.

This project is based on top of Ubuntu 19.10 on development platform and
the version for LibreOffice  6.0.7.3 with psql (PostgreSQL) 10.19

In order to connect to postgresql the following components must be installed

* LibreOffice Base
* A postgreSQL sdbc connector

```
{
  user@host:~$ libreoffice --version
  user@host:~$ psql --version
  user@host:~$ sudo apt-get update && sudo apt-get upgrade
  user@host:~$ sudo apt install libreoffice-base && libreoffice-sdbc-postgresql
}
```
### Connecting to a postgreSQL database


LibreOffice uses a Base file (filename) to connect with postgreSQL providing a connection to the Calc spreadsheet.

 - similar to a ODBC connection in Office.
 - Base files used are saved in (or on a network share) and do not contain any data.

<!--  
TODO
Connecting to a postgreSQL database
https://www.uzerp.com/blog/2019/05/06/libreoffice_postgres/


https://medium.com/imdoneio/the-imdone-pitch-feedback-welcome-386430accf01

-->
