#!/bin/bash
# clear cache

rm -f Pictures/wall.jpg
rm -f Pictures/photo-of-the-day

# download photo-of-the-day page
curl "http://photography.nationalgeographic.com/photography/photo-of-the-day/" -o "Pictures/photo-of-the-day"

# get the photo url
let line=`cat Pictures/photo-of-the-day | grep -n '<div class="primary_photo">' | cut -d':' -f1`+5
url=`sed -n "$line p" Pictures/photo-of-the-day | cut -d' ' -f2 | cut -d '"' -f2`

# download the photo
curl "${url:2}" -o "Pictures/wall.jpg"

#Mac makes setting your background from bash a pain
sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = 'Users/chrisbarthol/Pictures/wall.jpg'";
killall Dock;

#For Ubuntu
#gsettings set org.gnome.desktop.background picture-uri 'file:///home/chrisbarthol/Pictures/wall.jpg'

#For XFCE
#need to set each screen find them from: xfconf-query --channel xfce4-desktop --list
# xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/image-path --set /usr/Pictures/wall.jpg
# xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor1/image-path --set /usr/Pictures/wall.jpg
