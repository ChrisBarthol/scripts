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
curl "${url:2}" -o "Pictures/photo-of-the-day"
