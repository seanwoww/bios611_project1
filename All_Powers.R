library(tidyverse)
library(ggplot2)
pt <- read_csv("derived_data/pokemon_tidy.csv")
graphics.off()
par("mar")
par(mar=c(1,1,1,1))
select(pt, attack, defense, sp_attack, sp_defense, speed, hp) %>% plot(.)

pg <- pt %>% group_by(generation) %>% mutate(generation = factor(sprintf("generation %f", generation))) %>% 
select(.,attack, defense, sp_attack, sp_defense, speed, hp)

count(pg, generation) %>% arrange(.,desc(n)) %>% saveRDS(.,"assets/gen_count.rds")


py <- pt %>% group_by(type1) %>% select(.,attack, defense, sp_attack, sp_defense, speed, hp)
count(py, type1) %>% saveRDS(.,"assets/type_count.rds")


library(Rtsne)
fitg <- Rtsne(pg %>% select(.,attack, defense, sp_attack, sp_defense, speed, hp),dims =2, check_duplicates = FALSE);
gtsne <- ggplot(fitg$Y %>% as.data.frame() %>% as_tibble() %>% mutate(label=pg$generation), aes(V1,V2)) +
  geom_point(aes(color=pg$generation));
saveRDS(gtsne,"assets/gen_tsne.rds")
ggsave("figures/gen_tsne.png",gtsne)

fitt <- Rtsne(py %>% select(.,attack, defense, sp_attack, sp_defense, speed, hp),dims =2, check_duplicates = FALSE);
ttsne <-ggplot(fitt$Y %>% as.data.frame() %>% as_tibble() %>% mutate(label=py$type1), aes(V1,V2)) +
  geom_point(aes(color=py$type1))
saveRDS(ttsne,"assets/type_tsne.rds")
ggsave("figures/type_tsne.png", ttsne)
