#/bin/sh

#Folder structure based on Security Onion distro.
#I recommend making a folder in /nsm/bro called vt/
#Otherwise, you will need to edit this.

#This searches for files in the extracted directory.
#It then removes the filename from the result of md5sum.
#Finally, it adds results to md5_todaysdate.txt.

find /nsm/bro/extracted -type f -mtime 1 -exec md5sum '{}' \; | cut -d ' ' -f 1 | sudo tee --append /nsm/bro/vt/md5_$(date +%Y%m%d).txt

#We now sort and dedupe, then replace contents of file.

sort -u md5_$(date +%Y%m%d).txt | sudo tee --append /nsm/bro/vt/md5_$(date +%Y%m%d)_sorted.txt
rm md5_$(date +%Y%m%d).txt
mv md5_$(date +%Y%m%d)_sorted.txt md5_$(date +%Y%m%d).txt

#Finally, the results can be emailed.
#Disabled by default.

#echo 'TO DO: Eventually these will be queried in VT and results will go here.' | mail -s 'MD5s Seen Today' -A md5_$(date +%Y%m%d).txt <email goes here>
