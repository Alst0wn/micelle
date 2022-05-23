#!/bin/bash

for vel in 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3
do
    mkdir RUN$vel
	cp ./in.micelle ./RUN$vel/
	cp ./gnuplot.sh ./RUN$vel/
	cp ./script.sbatch ./RUN$vel/
	cp ./data.micelle ./RUN$vel/
	cd RUN$vel
	sed "s/BONDVAR/$vel/g" in.micelle>in.micelle_for_run
    srun -N 1 -p RT --ntasks-per-node=4 ~/bin/lmp_mpi -in in.micelle_for_run -log micelle.log > slurm_$vel.log
    
	# sbatch script.sbatch
	echo "Coefficient $vel finished"
    awk 'BEGIN{read_flag=0} {if ( $1=="Step" && $2=="Temp" ) {read_flag++}; if (read_flag==2){print}; if (read_flag==2 && $1=="Loop") {read_flag=0}}'  micelle.log>temp.txt
    # awk '/Step/,/Loop/{if (!/Step/ && !/Loop/)print}' micelle.log>temp.txt
	curl -s -X POST https://api.telegram.org/bot5290830951:AAEZaRP20r2MyHW0kxcxGuG8Ru0O5qlBOhQ/sendMessage -d chat_id=264630131 -d text="Coefficient $vel finished"
	gnuplot gnuplot.sh
	curl -s -X POST https://api.telegram.org/bot5290830951:AAEZaRP20r2MyHW0kxcxGuG8Ru0O5qlBOhQ/sendPhoto \
		-F chat_id=264630131 -F photo="@Plot.png" \
		-F caption="Plot for coef $vel"
	cd ..
done

	
