import pandas as pd;
import numpy as np;
import matplotlib.pyplot as plt
import plotnine as p9
from plotnine import ggplot, geom_point, aes, stat_smooth, facet_wrap, geom_text, geom_histogram;
pt = pd.read_csv('derived_data/pokemon_tidy.csv')
df = pd.DataFrame(pt)
df['percentage_male'].astype(str).str.replace("NA", "99")

conditions = [
    (df['percentage_male'] > .5) & (df['percentage_male'] < 98) , 
    (df['percentage_male'] < .5),
    (df['percentage_male'] == .5)
]
values = ['male', 'female', 'neither']
avg = df.groupby(by="type1")['type1','percentage_male','base_happiness'].mean()
avg["type"] = avg.index;
print(avg)


happy = (ggplot(aes(x='percentage_male'), data=df)+geom_histogram(aes(color = 'type1'), binwidth=6, alpha=0.6, data=df))
print(happy)
happy.save(filename = 'figures/gender_hist.png', height=5, width=5, units = 'in', dpi=1000)


happyt = (ggplot(aes(x='percentage_male', y='base_happiness'), data=avg)+geom_point(aes(color = 'type'), alpha=0.4, data=avg)) + geom_text(aes(label='type'), nudge_x = 2 ,size=10)
print(happyt)
happyt.save(filename = 'figures/gender_happinessbytype.png', height=5, width=5, units = 'in', dpi=1000)
