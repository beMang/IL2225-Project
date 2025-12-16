#! /usr/bin/bash
LOGID="@[IL2225-Project]"
echo $LOGID "TASK4 - FLAT PHYSICAL DESIGN"

echo "Pass | Period (ps) | Half-Period (ps) | Clock Uncertainty (ps) | Frequency (MHz)"
echo "1    | 28000       | 14000            | 280                    | 35.714         "
echo "2    | 24000       | 12000            | 240                    | 41.667         "
echo "3    | 20000       | 10000            | 200                    | 50.000         "
echo "4    | 16000       | 8000             | 160                    | 62.500         "
echo "5    | 12000       | 6000             | 120                    | 83.333         "
echo "6    | 8000        | 4000             | 80                     | 125.000        "
echo "7    | 4000        | 2000             | 40                     | 250.000        "

conL=(28000 24000 20000 16000 12000 8000 4000)
conLL=${#conL[@]}
i=1

for CON in ${conL[@]}
do
	STARTTIME=$(date +%s)
	echo "$LOGID Constraint $i/$conLL : clk_period $CON [ps]"

	innovus -stylus -log "log/task4_sweep/log_$CON.log" -overwrite -no_gui -batch -execute "set con $CON;" -files ../phy/scr/flat_CON.tcl

	ENDTIME=$(date +%s)
	ELAPSED_MIN=$(awk -v s="$STARTTIME" -v e="$ENDTIME" 'BEGIN { printf "%.3f", (e - s) / (60*1000000000) }')
	echo "$LOGID Constraint $i/$conLL : Time taken $ELAPSED_MIN [min]"
	((i++))
done
