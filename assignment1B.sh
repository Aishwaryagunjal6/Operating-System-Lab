fileExists(){
	if [ ! -e record.txt ]
	then 
		echo "File does not exist"
		return
	fi
}

createFile(){
	if [ ! -e record.txt ]
	then 
		touch record.txt
		echo "Name  id  Address  PhoneNo.  Email" > record.txt
	fi
}		

insertRecord(){
	if [ ! -e record.txt ]
	then 
		echo "File does not exist"
		return
	fi
	
	read -p "Enter the name: " name
	read -p "Enter the id: " id
	read -p "Enter the address: " address
	while true; do
	    read -p "Enter the phone no: " phn
	    if [[ "$phn" =~ ^[0-9]{10}$ ]]
	    then
	    	break
	    else
	    	echo "Invalid Number"
	    fi
	done    
	    		
	while true; do
	    read -p "Enter the E-Mail: " email
	    if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]
	    then
	    	break
	    else
	    	echo "Invalid Email"
	    fi
	done
	
	echo "$name  $id  $address  $phn  $email" >> record.txt
}

viewFile(){
	if [ ! -e record.txt ]
	then 
		echo "File does not exist"
		return
	fi
	
	if [ -s record.txt ]
	then 
		cat record.txt
	else
		echo "File is empty"
	fi
}

deleteRecord() {
	if [ ! -e record.txt ]
	then
		echo "File does not exist"
		return
	fi
	
	if [ ! -s record.txt ]
	then
		echo "File is empty"
		return
	fi
	
	read -p "Enter the name to delete: " name
	
	sed -i "/$name/d" record.txt
	echo "Record deleted, if it existed."
}

searchRecord(){
	if [ ! -e record.txt ]
	then 
		echo "File does not exist"
		return
	fi
	
	read -p "Enter the name to search: " name
	
	if grep -i "$name" record.txt; then
		echo "Record found!"
	else
		echo "No matching record found."
	fi
}	

updateRecord() {
	if [ ! -e record.txt ]
	then
		echo "File does not exist"
		return
	fi
	
	read -p "Enter the name to update: " name
	
	if [ -z "$(grep -i "$name" record.txt)" ]
	then
		echo "Record not found"
		return
	fi
	
	sed -i "/$name/d" record.txt
	
	read -p "Enter the new name: " new_name
	read -p "Enter the new id: " id
	read -p "Enter the new address: " address
	while true; do
	    read -p "Enter the phone no: " phn
	    if [[ "$phn" =~ ^[0-9]{10}$ ]]
	    then
	    	break
	    else
	    	echo "Invalid Number"
	    fi
	done  
	while true; do
	    read -p "Enter the E-Mail: " email
	    if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]
	    then
	    	break
	    else
	    	echo "Invalid Email"
	    fi
	done
	
	echo "$new_name  $id  $address  $phn  $email" >> record.txt
	echo "Record updated."
}

choice=0
while [[ $choice -lt 7 ]];
do
	echo "1. Create File"
	echo "2. Insert into File"
	echo "3. View File"
	echo "4. Update Record"
	echo "5. Search Record"
	echo "6. Delete Record"
	echo "7. Exit"
	
	read -p "Enter your choice: " choice
	
	case $choice in
		1 )
			createFile ;;
		2 )
			read -p "Enter the number of records to insert: " n
			i=0
			while [ $i -lt $n ];
			do
				insertRecord
				i=$((i + 1))
			done ;;
		3 )
			viewFile 
            echo "-------------------------------------------------------" 
            echo " " ;;
		4 )
			updateRecord ;;
		5 )
			searchRecord ;;
		6 )
			deleteRecord ;;
		7 )
			exit ;;
		* )
		   echo "Invalid choice. Please enter a number between 1 and 7."
	esac   	
done

