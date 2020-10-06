library(tidyverse); d <- read_csv("derived_data/pokemon_tidy.csv");


p <- ggplot(d, aes(weight_kg, height_m)) + geom_point(aes(color=type1), alpha=0.4);
ggsave("images/pokemon-height-weight type1.png",plot=p)

avg_weight <- d %>% group_by(type1) %>% filter(weight_kg > 0) %>% summarise(mean(weight_kg))

avg_height <- d %>% group_by(type1) %>% filter(height_m > 0) %>% summarise(mean(height_m))

avg_height_weight <- inner_join(avg_height,avg_weight)
rename(avg_height_weight, mean.height_m. = )

colnames(avg_height_weight)
names(avg_height_weight)[names(avg_height_weight) == "mean(height_m)"] <- "height.m.avg"
names(avg_height_weight)[names(avg_height_weight) == "mean(weight_kg)"] <- "weight.kg.avg"


q <- ggplot(avg_height_weight, aes(weight.kg.avg, height.m.avg)) + 
  geom_point(aes(color=type1), alpha=0.4) + 
  geom_text(aes(label=type1), position=position_dodge(width=0.5), size=2.5 ,hjust=0, vjust=0) + 
  xlim(0, 190) + ylim(0, 2)
ggsave("images/height-weight-type1.png",plot=q)