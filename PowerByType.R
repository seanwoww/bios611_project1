library(tidyverse)
library(ggpubr); d <- read_csv("derived_data/pokemon_tidy.csv");

legend_type_tbl <- d %>% filter(is_legendary > 0) %>% group_by(type1) %>% summarize(Legendary=sum(is_legendary)) %>% arrange(., desc(Legendary))
nl <- d %>% filter(is_legendary == 1)

avg_attack <- nl %>% group_by(type1) %>% filter(attack > 0) %>% summarise(mean(attack))

avg_defense <- nl %>% group_by(type1) %>% filter(defense > 0) %>% summarise(mean(defense))

avg_spdefense <- nl %>% group_by(type1) %>% filter(sp_defense > 0) %>% summarise(mean(sp_defense))

avg_spattack <- nl %>% group_by(type1) %>% filter(sp_attack > 0) %>% summarise(mean(sp_attack))

avg_speed <- nl %>% group_by(type1) %>% filter(speed > 0) %>% summarise(mean(speed))

avg_hp <- nl %>% group_by(type1) %>% filter(hp > 0) %>% summarise(mean(hp))

power <- inner_join(avg_hp, avg_attack) %>% 
  inner_join(.,avg_defense) %>% 
  inner_join(.,avg_spattack) %>% 
  inner_join(.,avg_spdefense) %>% 
  inner_join(.,avg_speed)

colnames(power) ;
names(power)[names(power) == "mean(hp)"] <- "hp.avg" ;
names(power)[names(power) == "mean(attack)"] <- "attack.avg" ;
names(power)[names(power) == "mean(defense)"] <- "defense.avg" ;
names(power)[names(power) == "mean(sp_attack)"] <- "spattack.avg" ;
names(power)[names(power) == "mean(sp_defense)"] <- "spdefense.avg" ;
names(power)[names(power) == "mean(speed)"] <- "speed.avg"

a <- ggplot(power, aes(attack.avg, defense.avg)) + 
  geom_point(aes(color=type1), alpha=0.4) + 
  geom_text(aes(label=type1), position=position_dodge(width=0.5), size=2.5 ,hjust=0, vjust=0) + 
  xlim(55, 175) + ylim(75, 125)

sp <- ggplot(power, aes(spattack.avg, spdefense.avg)) + 
  geom_point(aes(color=type1), alpha=0.4) + 
  geom_text(aes(label=type1), position=position_dodge(width=0.5), size=2.5 ,hjust=0, vjust=0) + 
  xlim(85, 150) + ylim(55, 175)


hps <- ggplot(power, aes(speed.avg, hp.avg)) + 
  geom_point(aes(color=type1), alpha=0.4) + 
  geom_text(aes(label=type1), position=position_dodge(width=0.5), size=2.5 ,hjust=0, vjust=0) + 
  xlim(60, 125) + ylim(75, 160)

avg_power_type <- ggarrange(hps,sp,a, labels = c("A","B","C"), ncol = 2, nrow = 2)

ggsave("figures/avg_power_type.png",avg_power_type)
saveRDS(avg_power_type, "assets/avg_power_type.rds")

write_csv(legend_type_tbl,"figures/legend_gen_tbl.csv")
saveRDS(legend_type_tbl, "assets/legend_type_tbl.rds")