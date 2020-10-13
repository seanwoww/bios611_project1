library(tidyverse)

pokemon <- read_csv("source_data/pokemon.csv")

library(stringr)
names(pokemon) <- names(pokemon) %>%
 tolower() %>% 
  str_replace_all(" - ", " ") %>%
  str_replace_all(" ","_");
names(pokemon)


write_csv(pokemon, "derived_data/pokemon_tidy.csv")

