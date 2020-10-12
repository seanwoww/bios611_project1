.PHONY: clean

clean:
	rm derived_data/*

PokemonReport.pdf:\
 PokemonReport.Rmd\
 figures/avg_power_fig.rds\
 figures/legend_gen_tbl.rds\
 figures/avg_power_type.rds\
 figures/legend_type_tbl.rds\
 figures/size_fig.rds\
 derived_data/pokemon_tidy.csv
	R -e "rmarkdown::render('PokemonReport.Rmd')"
 
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