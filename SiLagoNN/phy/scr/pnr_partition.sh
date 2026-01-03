TOP_NAME="drra_wrapper"
partition_list="$(ls ../phy/db/part/*enc | grep -v ${TOP_NAME})"
TIMESTAMP="$(date +"%Y-%m-%d_%H-%M-%S")"

for partition in ${partition_list}
do
	filename=$(basename -- "$partition")
	extension="${filename##*.}"
	filename="${filename%.*}"
	cd ${partition}.dat
	rm -rf pnr
	mkdir pnr 
	echo $filename	
	nohup innovus -stylus \
                      -no_gui \
                      -batch \
                      -files ../../../scr/pnr_partition.tcl \
                      -log "../../../../exe/log/pnr/pnr_${filename}_${TIMESTAMP}.log \
                            ../../../../exe/log/pnr/pnr_part_${filename}_${TIMESTAMP}.cmd \
                            ../../../../exe/log/pnr/pnr_part_${filename}_${TIMESTAMP}.logv" \
                      -overwrite &
	cd ../../../../exe
done
