#!/bin/bash
echo ''>ffmpeg.log
files=`ls -I*.log -I*.sh -Ith -Ibg.png -I*.svg`
total=`ls -I*.log -I*.sh -Ith -Ibg.png -I*.svg | wc -l`
n=0
for f in $files;
do
  let "n+=1"
  ffmpeg -i "$f" -y -vf "scale=w='min(400,iw)':h='min(200,ih)':force_original_aspect_ratio=decrease:force_divisible_by=2" "th/$f" &>>ffmpeg.log
  echo -ne "\r\033[K$n/$total $f"
done
echo -ne "\r\033[K"
cp *.svg th/
grep Error ffmpeg.log
