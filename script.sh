#!/bin/bash

for vel in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3
do
	mkdir RUN$vel
	cp in.micelle RUN$vel
	cd RUN$vel
	sed "s/VELOCITYVAR/$vel/g" in.micelle
	srun -N 1 -p RT --ntasks-per-node=4 ~/bin/lmp_mpi -in in.micelle
	echo "Velocity $vel finished"
	curl -s -X POST https://api.telegram.org/bot5290830951:AAEZaRP20r2MyHW0kxcxGuG8Ru0O5qlBOhQ/sendMessage -d chat_id=264630131 -d text="Temp: ($temp) finished"
done

	
