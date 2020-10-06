library(tidyverse)

pokemon <- read_csv("source_data/pokemon.csv")

library(stringr)
names(d) <- names(d) %>%
  tolower() %>%d
  str_replace_all(" - ", " ") %>%
  str_replace_all(" ","_");
names(d)


write_csv(pokemon, "derived_data/pokemon_tidy.csv")

