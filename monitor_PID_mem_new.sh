#! /bin/bash
end=$((SECONDS+3))

while [ 1 ]; do
	for i in `top -n 1 -b -c -u qiushi.li | tail -n +8 | awk '{print $1}'`; do grep VmPeak /proc/$i/status|perl -ne 'my $mem=(split)[1]; ($sec,$min,$hour,$mday) = localtime(); print "${mem}Kb\t$mday-$hour:$min:$sec\t"'; echo -n "$i "; cat /proc/$i/cmdline|perl -nle 's/\0/ /g; print $_'; done|grep -P '^[0-9]+Kb'
	sleep 300
done
