library(tidyverse); d <- read_csv("derived_data/pokemon_tidy.csv");

gen_weight <- d %>% mutate(generation = factor(sprintf("generation %f", generation)))%>% 
group_by(generation) %>% filter(weight_kg > 0) %>% summarise(mean(weight_kg))
  

gen_height <- d %>% mutate(generation = factor(sprintf("generation %f", generation))) %>%
  group_by(generation) %>% filter(height_m > 0) %>% summarise(mean(height_m)) 


gen_height_weight <- inner_join(gen_height,gen_weight)

colnames(gen_height_weight)
names(gen_height_weight)[names(gen_height_weight) == "mean(height_m)"] <- "height.m.avg"
names(gen_height_weight)[names(gen_height_weight) == "mean(weight_kg)"] <- "weight.kg.avg"

ht_wt_gen <- ggplot(gen_height_weight, aes(weight.kg.avg, height.m.avg)) + 
  geom_point(aes(color=generation), alpha=0.4) + 
  geom_text(aes(label=generation), position=position_dodge(width=0.5), size=2.5 ,hjust=0, vjust=0) + 
  xlim(45, 115) + ylim(1, 1.35)

avg_weight <- d %>% group_by(type1) %>% filter(weight_kg > 0) %>% summarise(mean(weight_kg))

avg_height <- d %>% group_by(type1) %>% filter(height_m > 0) %>% summarise(mean(height_m))

avg_height_weight <- inner_join(avg_height,avg_weight)

colnames(avg_height_weight)
names(avg_height_weight)[names(avg_height_weight) == "mean(height_m)"] <- "height.m.avg"
names(avg_height_weight)[names(avg_height_weight) == "mean(weight_kg)"] <- "weight.kg.avg"



ht_wt_fig <- ggplot(avg_height_weight, aes(weight.kg.avg, height.m.avg)) + 
  geom_point(aes(color=type1), alpha=0.4) + 
  geom_text(aes(label=type1), position=position_dodge(width=0.5), size=2.5 ,hjust=0, vjust=0) + 
  xlim(25, 190) + ylim(.75, 2)
size_fig <- ggarrange(ht_wt_gen,ht_wt_fig, labels = c("A","B"), nrow = 2)

ggsave("figures/size_fig.png",size_fig)
saveRDS(size_fig, "figures/size_fig.rds")