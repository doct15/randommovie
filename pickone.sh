#!/bin/bash
#

SAVEIFS=$IFS
IFS=$'\n'
files=()
mount=()
numberofmounts=2
prevmount=0

show_movies () {
  movie=$(($RANDOM % ${#files[@]}+1))
  echo "Mnt: ${mount[$movie]} - Movie: ${files[$movie]}"
}

for((i=1;i<=$numberofmounts;i+=1))
do
  files+=($(ls -RA1 /mnt/movies$i/Movies | grep -i '\.mkv\|\.mp4\|\.avi'))
  eval $(eval echo "mount[{$prevmount..${#files[@]}}]=$i;")
  prevmount=$((${#files[@]} + 1))
done

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