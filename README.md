# bios611_project1

Pokemon Dataset - All pokemon gen 1-7
--------------------------------------
This will contain analysis for Pokemon datasets.

Usage
------

You will only need the ability to run docker on your current user.

			#Build docker environment
			> docker build . -t project1-env

			#For running Rstudio Server
			> docker run --rm -p 8787:8787 -p 8788:8788 -e PASSWORD=bulbasaur -v  '<PATH>:/home/rstudio' -t project1-env
				
				#For running R Shiny application (TSNE) in an Rstudio Server terminal:
				PORT=8788 make Shiny_Pokemon

			#For running Jupyter Lab
			> docker run -p 8888:8888 -v "<PATH>:/home/rstudio" -it project1-env sudo -H -u rstudio /bin/bash -c "cd ~/; jupyter lab --ip 0.0.0.0 --port 8888"

Replace the <PATH> with the apropriate folder that the repository is in.
(Note: we also export port 8788 above so that we can run Rshiny applications on that port.)			

Proposal
---------
The dataset that I will be looking at will include all Pokemon from generations 1-7. 
Each line of the dataset is a single pokemon that include (example #s from Bulbasaur):
	percent chance of being male		88.1%
	height 								.7m
	weight								6.9 kg (ni.ce)
	experience growth					1059860
	abilities							Overgrown, Chlorophyl
	types (grass type, fire type etc.)	Grass, Poison
	multipliers against other types
	base happiness						70
	base egg steps						5120
	base total							318
	capture rate						45
	attack power						49
	Defense								49
	SP attack							65
	SP defense							65
	speed								45


A few of the questions that I hope to look into are:
	1. What are statistical trends amongst different types of pokemon (i.e. do grass types have more or less attack than fire types?)
	2. Compare trends based on the generation that they were introduced.
	3. Are there any trends for different pokemon statistics
	
For visualizations, recordiing trends by generation and by Type separately and perhaps how Type averages change as generations progress.

For completion, the best criteria would be determining the individual Pokemon, best Type and best generation on average in each category.
 