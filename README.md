# Airbnb datamart project

MySQL database of a reservation system with the functionality a company like Airbnb would require.


## Schema details

In the following picture, the details of the schema have been shown. Using the “SHOW TABLE STATUS FROM db” query, I extract the schema information in a .csv file which is available in the finalization directory.
![schema details](https://github.com/mohamadsolouki/airbnb-datamart/blob/main/03-Finalisation/metadata.jpg)


## Installation

It is first necessary to install MySQL on your system. Afterward, the data mart can be used with any MySQL database system. I suggest the MySQL Workbench community version, a free DBMS that can also open the model file, which is a .mwb file located in the development directory.

MySQL can be installed from [here](https://dev.mysql.com/downloads/installer/).

MySQL Workbench can be installed from [here](https://dev.mysql.com/downloads/workbench/).

After creating a database connection and a schema, using the data import tool in the server tab, you can import the **dump.sql** file, which is located in the finalization directory.
