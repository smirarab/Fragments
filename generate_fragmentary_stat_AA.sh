#!/bin/bash
=$1
g=$(dirname $z);
base=$(basename $z | sed -e "s/.fasta//"); 
for x in `cat $z`; do 
	y=$(echo $x | grep ">" ); 
	if [ "$y" == "" ]; then 
		echo -n $x | awk -vFS="" '{for(i=1;i<=NF;i++)w[$i]++ sum++}END{printf "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s","SEQUENCE","N","-","A","C","G","T","a","c","t","g","ACGT-","SUM"}END{print ""}END{printf "%s,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f","##",w["N"]/sum,w["-"]/sum,w["A"]/sum,w["C"]/sum,w["G"]/sum,w["T"]/sum,w["a"]/sum,w["c"]/sum,w["t"]/sum,w["g"]/sum,(w["A"]+w["T"]+w["C"]+w["-"]+w["G"])/sum,sum}' | sed -e "s/,$//"; echo; 
	else 
		echo $x; 
	fi; 
done  > $g/$base.fragmentary.stat;
echo "working on $base has been finishe"; 

x=$g/$base.fragmentary.stat;
b=$(basename $x | sed -e 's/.fragmentary.stat//')
d=$(dirname $x); 
cat $x | sed -e 's/>\(.*\)/>\1\#/' | sed -e 's/\(.*\)SUM/\&\1SUM\&/' | tr "\n" "@"  | sed -e 's/>/\n/g' | sed -e 's/@//g' | sed -e 's/#\&.*\&##//g' > $d/$b.fragmentary_final.stat; 
echo "working on $x has been finished"; 

