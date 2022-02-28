#!/bin/bash
#

SAVEIFS=$IFS
#IFS=$(echo -en "\n\b")
IFS=$'\n'
files=()
mount=()
debug=0
numberofmounts=2
prevmount=0

echo "" > debug.txt

show_movies () {
  movie=$(($RANDOM % ${#files[@]}+1))
  echo "Mnt: ${mount[$movie]} - Movie: ${files[$movie]}"
}

for((i=1;i<=$numberofmounts;i+=1))
do
  files+=($(ls -RA1 /mnt/movies$i/Movies | grep -i '\.mkv\|\.mp4\|\.avi'))
  eval $(eval echo "mount[{$prevmount..${#files[@]}}]=$i;")
  prevmount=$((${#files[@]} + 1))
  #echo "Mount $i:${#files[@]}"
done

#echo "Total files: ${#files[@]}"
#for i in i0 1000 1566 1567 2000 2478 2479 2480 2481 2482 2483 2484 3000
#do
#  echo "mount $i: ${mount[$i]}"
#done


if [[ $debug -gt 0 ]];
then 
  for file in "${files[@]}"
  do
    echo "$file" >> debug.txt
  done
  #for i in {1..10}
  #do
  #  echo $(($RANDOM % 10))
  #done
fi

#echo "${#files[@]}"
#echo "Movie selected:"
#echo  $(($RANDOM % ${#files[@]}))
#echo "Movie: ${files[$movie]}"
#echo "  100: ${files[100]}"

clear
show_movies

while :
do
  echo -e "\nPress [SPACE] for another movie. Or press 1-9 for multiple movies. q to quit."
  read -s -n1 response
  case "$response" in
  
    " ")
      echo ""
      show_movies
      ;;
  
    [qQ])
      break
      ;;
  
    [1-9])
        echo ""
        for((i=1;i<=$response;i+=1))
        do
          show_movies
        done
        ;;

    *)
        break
        ;; 

  esac
  echo ""
done

IFS=$SAVEIFS

exit
