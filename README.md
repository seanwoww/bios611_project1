# bios611_project1

Pokemon Dataset - All pokemon gen 1-7
--------------------------------------
This will contain analysis for Pokemon datasets.

Usage
------

You will only need the ability to run docker on your current user.

				#Build docker environment
				>docker build . -t project1-env
				
				#For running Rstudio Server
				>docker run --rm -p 8787:8787 -e PASSWORD=bulbasaur -v \
				'C:\Users\seanw\OneDrive - University of North Carolina at Chapel Hill\UNC\GRAD\BIOS 611\:/home/studio' -t project1-env
				
				#For running Jupyter Lab
				> docker run --rm -p 8888:8888 -p 4040:4040 -e JUPYTER_ENABLE_LAB=yes -v "C:\Users\seanw\OneDrive - University of North Carolina at Chapel Hill\UNC\GRAD\BIOS 611\BIOS611_Project1:/home/jovyan/Project1"  jupyter/all-spark-notebook
	

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
	
For visualizations, recordiing trends by generation and by Type separately and perhaps how Type averages change as generations progress.

For completion, the best criteria would be determining the individual Pokemon, best Type and best generation on average in each category.
 