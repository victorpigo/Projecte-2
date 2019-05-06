#!/bin/bash
cert=1
fals=0

identificador_usuari=`id -u`
usuari_existent=cert

#Verificar si ets root
if [ $identificador_usuari -ne 0 ];then
   echo Has de ser root per afegir un usuari
   exit 1
else
    #Bucle que es repetirà quan l'usuari ja es trobi en el sistema
    while [ $usuari_existent == "cert" ]
      do

	echo "Escriu el nom de l'usuari: " $1


	echo "Escriu el nom complet de l'usuari: " $2


#Genera una contrasenya amb la longitud indicada	 
echo "Inserta la longitud de la contrasenya:"
read contrasenya
for p in $(seq 1);
do
     openssl rand -base64 48 | cut -c1-$contrasenya
done




	useradd -c ${1} -m ${1} > /dev/null 2>&1

#Comprova si l'usuari existeix
	if [ $? -gt 0 ]; then
		echo "l'usuari $1 ja existeix"
	else
	    usuari_existent=fals

	    echo -e "${contrasenya}\n${contrasenya}" | passwd ${1} > /dev/null 2>&1


	    if [ $? -eq 0 ];then
	    	echo "L'usuari $nom_usuari s'ha creat correctament"


	    	passwd -e ${1}

#Mostra les dades
	    	echo "Usuari: $1"

	    	echo "Longitud Contrasenya: $contrasenya"

	    	echo "Host: `hostname`"
	   else
		echo "Contrasenya no especificada"
		exit 1
	  fi
	fi
  done
fi
