library(tidyverse); pt <- read_csv("derived_data/pokemon_tidy.csv")
library(ggpubr)


legend_gen_tbl <- pt %>% filter(is_legendary > 0) %>% 
 group_by(generation) %>% 
 summarize(Legendary=sum(is_legendary)) %>% 
 mutate(generation = factor(sprintf("generation %f", generation)))

avg_attack <- pt %>% group_by(generation) %>% filter(attack > 0) %>% summarise(mean(attack))

avg_defense <- pt %>% group_by(generation) %>% filter(defense > 0) %>% summarise(mean(defense))

avg_spdefense <- pt %>% group_by(generation) %>% filter(sp_defense > 0) %>% summarise(mean(sp_defense))

avg_spattack <- pt %>% group_by(generation) %>% filter(sp_attack > 0) %>% summarise(mean(sp_attack))

avg_speed <- pt %>% group_by(generation) %>% filter(speed > 0) %>% summarise(mean(speed))

avg_hp <- pt %>% group_by(generation) %>% filter(hp > 0) %>% summarise(mean(hp))

powerg <- inner_join(avg_hp, avg_attack) %>% 
  inner_join(.,avg_defense) %>% 
  inner_join(.,avg_spattack) %>% 
  inner_join(.,avg_spdefense) %>% 
  inner_join(.,avg_speed)

colnames(powerg) ;
names(powerg)[names(powerg) == "mean(hp)"] <- "hp.avg" ;
names(powerg)[names(powerg) == "mean(attack)"] <- "attack.avg" ;
names(powerg)[names(powerg) == "mean(defense)"] <- "defense.avg" ;
names(powerg)[names(powerg) == "mean(sp_attack)"] <- "spattack.avg" ;
names(powerg)[names(powerg) == "mean(sp_defense)"] <- "spdefense.avg" ;
names(powerg)[names(powerg) == "mean(speed)"] <- "speed.avg"

a <- ggplot(powerg, aes(attack.avg, defense.avg)) + 
   geom_point(aes(color=generation), alpha=0.4) + 
   geom_text(aes(label=generation), position=position_dodge(width=0.5), size=2.5 ,hjust=0, vjust=0) + 
   xlim(65, 85) + ylim(65, 80)

sp <- ggplot(powerg, aes(spattack.avg, spdefense.avg)) + 
  geom_point(aes(color=generation), alpha=0.4) + 
  geom_text(aes(label=generation), position=position_dodge(width=0.5), size=2.5 ,hjust=0, vjust=0) + 
  xlim(60, 80) + ylim(65, 80)

hps <- ggplot(powerg, aes(speed.avg, hp.avg)) + 
  geom_point(aes(color=generation), alpha=0.4) + 
  geom_text(aes(label=generation), position=position_dodge(width=0.5), size=2.5 ,hjust=0, vjust=0) + 
  xlim(60, 80) + ylim(60, 80)

avg_power_fig <- ggarrange(hps,sp,a, labels = c("A","B","C"), ncol = 2 , nrow =2)

ggsave("figures/speed_hp-gen.png",avg_power_fig)
saveRDS(avg_power_fig, "figures/avg_power_fig.rds")

ggsave("figures/legend_gen_tbl.png",legend_gen_tbl)
saveRDS(legend_gen_tbl, "figures/legend_gen_tbl.rds")