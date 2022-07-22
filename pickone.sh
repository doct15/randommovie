#!/bin/bash
#

SAVEIFS=$IFS
IFS=$'\n'
files=()
numberofmounts=2
declare -a mounts=("g" "f")
#declare -a mounts=("movies1" "movies2")

show_movies () {
  movie=$(($RANDOM % ${#files[@]}+1))
  echo "${files[$movie]}"
}

#for((i=1;i<=$numberofmounts;i+=1))
for i in "${mounts[@]}"
do
  #echo "$(ls /mnt/$i/Movies/)"
  echo "ls /mnt/$i/Movies/"
  #files+=($(find /mnt/movies$i/Movies/ -type f -name "*.mkv" -o -name "*.mp4" -o -name "*.avi" -o -name "*.m4v"))
  files+=($(find /mnt/$i/Movies/ -type f -name "*.mkv" -o -name "*.mp4" -o -name "*.avi" -o -name "*.m4v"))
done

#clear
echo "Total Movies ${#files[@]}"
echo "---"
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
