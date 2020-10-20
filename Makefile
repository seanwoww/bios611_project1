.PHONY: clean

clean:
	rm ./*.rds
	rm ./figures/*
	rm ./PokemonReport.pdf
	rm ./derived_data/*

PokemonReport.pdf:\
 PokemonReport.Rmd\
 figures/avg_power_fig.rds\
 figures/legend_gen_tbl.rds\
 figures/avg_power_type.rds\
 figures/legend_type_tbl.rds\
 figures/size_fig.rds\
 assets/type_tsne.rds\
 assets/gen_tsne.rds\
 figures/gen_tsne.png\
 figures/type_tsne.png\
 derived_data/pokemon_tidy.csv
	R -e "rmarkdown::render('PokemonReport.Rmd')"

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
	Rscript Power_by_gen.R

figures/legend_gen_tbl.rds:\
 derived_data/pokemon_tidy.csv
	Rscript Power_by_gen.R
	
figures/avg_power_type.rds:\
 derived_data/pokemon_tidy.csv
	Rscript PowerByType.R

figures/legend_type_tbl.rds:\
 derived_data/pokemon_tidy.csv
	Rscript PowerByType.R
	
figures/size_fig.rds:\
 derived_data/pokemon_tidy.csv
	Rscript size.R

derived_data/pokemon_tidy.csv:\
 source_data/pokemon.csv tidy_data.R
	Rscript tidy_data.R