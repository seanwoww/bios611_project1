.PHONY clean

clean:
  rm derived_data/*


 

derived_data/pokemon_tidy.csv:\
 source_data/pokemon.csv\ 
 tidy_data.R
	Rscript tidy_data.R


figures/size.tex:\
 derived_data/pokemon_tidy.csv\
	Rscript sizebytype.R