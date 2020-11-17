.PHONY: clean
.PHONY: Shiny_Pokemon


clean:
	rm ./*.rds
	rm ./figures/*
	rm ./assets/*
	rm ./derived_data/*
	rm ./PokemonReport.pdf

Shiny_Pokemon:\
 derived_data/pokemon_tidy.csv
	Rscript Shiny_Pokemon.R ${PORT}

PokemonReport.pdf:\
 PokemonReport.Rmd\
 figures/gender_happinessbytype.png\
 figures/gender_hist.png\
 figures/avg_power_fig.rds\
 figures/legend_gen_tbl.rds\
 figures/avg_power_type.rds\
 figures/legend_type_tbl.rds\
 figures/size_fig.rds\
 assets/type_tsne.rds\
 assets/gen_tsne.rds\
 assets/powerplot.png\
 figures/gen_tsne.png\
 figures/type_tsne.png\
 derived_data/pokemon_tidy.csv
	R -e "rmarkdown::render('PokemonReport.Rmd')"

figures/gender_happinessbytype.png:\
 derived_data/pokemon_tidy.csv
	python3 Pokemon_Gender.py

figures/gender_hist.png:\
 derived_data/pokemon_tidy.csv
	python3 Pokemon_Gender.py


figures/gen_tsne.png:\
 derived_data/pokemon_tidy.csv
	Rscript All_Powers.R

figures/type_tsne.png:\
 derived_data/pokemon_tidy.csv
	Rscript All_Powers.R


assets/type_tsne.rds:\
 derived_data/pokemon_tidy.csv
	Rscript All_Powers.R

assets/gen_tsne.rds:\
 derived_data/pokemon_tidy.csv
	Rscript All_Powers.R


assets/powerplot.png:\
 derived_data/pokemon_tidy.csv
	Rscript All_Powers.R


assets/power.rds:\
 derived_data/pokemon_tidy.csv
	Rscript All_Powers.R




figures/avg_power_fig.rds:\
 derived_data/pokemon_tidy.csv
	Rscript Power_Gen.R

figures/legend_gen_tbl.rds:\
 derived_data/pokemon_tidy.csv
	Rscript Power_Gen.R


figures/avg_power_type.rds:\
 derived_data/pokemon_tidy.csv
	Rscript Power_Type.R

figures/legend_type_tbl.rds:\
 derived_data/pokemon_tidy.csv
	Rscript Power_Type.R



figures/size_fig.rds:\
 derived_data/pokemon_tidy.csv
	Rscript size.R


derived_data/pokemon_tidy.csv:\
 source_data/pokemon.csv tidy_data.R
	Rscript tidy_data.R