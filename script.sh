#!/bin/bash

for vel in 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3
do
	mkdir RUN$vel
	cp ./in.indent ./RUN$vel/
	cp ./gnuplot.sh ./RUN$vel/
	cp ./script.sbatch ./RUN$vel/
	cd RUN$vel
	sed "s/VELOCITYVAR/$vel/g" in.indent>in.indent_for_run
	sbatch script.sbatch
	echo "Velocity $vel finished"
	awk '/Step/,/Loop/{if (!/Step/ && !/Loop/)print}' log.log>temp.txt
	curl -s -X POST https://api.telegram.org/bot5290830951:AAEZaRP20r2MyHW0kxcxGuG8Ru0O5qlBOhQ/sendMessage -d chat_id=264630131 -d text="Velocity $vel finished"
	gnuplot gnuplot.sh
	curl -s -X POST https://api.telegram.org/bot5290830951:AAEZaRP20r2MyHW0kxcxGuG8Ru0O5qlBOhQ/sendPhoto \
		-F chat_id=264630131 -F photo="@Plot.png" \
		-F caption="Plot for velocity $vel"
	cd ..
done

	
