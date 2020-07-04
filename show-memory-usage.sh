#!/bin/sh
#echo "======================================"
echo "# Below are Top 10 Memory consumption processes % #"
echo "==================================================="
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -10
echo "==============================================="
echo "# ...and Below are Top 15 Memory consumption with commands"
echo "=========================================================="
ps -eo rss,pid,user,command | sort -rn | head -15 | awk '{ hr[1024**2]="GB"; hr[1024]="MB";
 for (x=1024**3; x>=1024; x/=1024) {
 if ($1>=x) { printf ("%-6.2f %s ", $1/x, hr[x]); break }
 } } { printf ("%-6s %-10s ", $2, $3) }
 { for ( x=4 ; x<=NF ; x++ ) { printf ("%s ",$x) } print ("\n") }
 '
echo "# Commands Below are useful too #"
echo "# ps -e --format=pid,rss,args | sort --numeric-sort --key=2 > debug1.txt #"
echo "# ps aux  | awk '{print $6/1024  " MB\t\t" $2 "\t" $11}'  | sort -n > debug2.txt #"
echo "# ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -10 > debug3.txt #"