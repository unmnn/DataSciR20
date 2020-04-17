library(tidyverse) # includes ggplot2
library(gapminder)
library(ggrepel)

# Your turn 1 ----

# filter observations where the year is 2007 
df <- filter(______, ______ == ______)

ggplot(df, aes(x = ______, y = ______)) +
  geom_______()



# Your turn 2 ----

# filter observations were the country is either Germany, France or Italy
df <- filter(gapminder, ______ ______ c("Germany", "France", "Italy"))

ggplot(df, aes(x = ______, y = ______, color = ______)) +
  geom_______() +
  scale_y_continuous(labels = scales::comma)



# Your turn 3 ----

gp <- gapminder %>%
  # filter observations where the year is 2007 and the continent is not Oceania
  filter(______ == ______, ______ ______ "Oceania") %>%
  # create new categorical variable 'pop_category' by binning the continuous 
  # 'pop' variable
  ______(pop_category = case_when(
    pop <= 1000000 ~ "very small (<= 1,000,000)",
    between(pop, 1000001, 10000000) ~ "small (1,000,000 < x <= 10,000,000)",
    between(pop, 1000001, 50000000) ~ "medium (10,000,000 < x <= 50,000,000)",
    between(pop, 5000001, 100000000) ~ "large (50,000,000 < x <= 100,000,000)",
    pop > 100000000 ~ "very large (> 100,000,000)"
  )) %>%
  # make this new variable a factor; sort levels by 'pop'
  mutate(pop_category = fct_reorder(pop_category, pop))

ggplot(gp, aes(x = ______, fill = ______)) +
  geom_bar(position = position_______(______))



# Your turn 4 ----

# filter observations where the year is 2007 
gm <- filter(gapminder, ______ == ______)
# filter observations were the country is either Americas or Europe
gm_ae <- filter(gm, ______ ______ c("Americas", "Europe"))

# Define manual colors: 1->"Americas", 2->"Europe"
my_colors <- c("brown2", "royalblue") 

ggplot(mapping = aes(______, ______)) +
  # add scatterplot layer that shows all countries as semi-transparent points
  geom_______(data = ______, alpha = 0.1) +
  # add scatterplot layer that only shows American and European countries;
  # map continent to point color
  geom_______(data = ______, aes(color = ______)) +
  # add manual color scale using 'my_colors' as color values
  scale_______(values = my_colors)



# Your turn 5 ----
my_gapminder <- gapminder %>%
  # filter observations were the country is either Africa, Asia or Europe
  filter(______ ______ c("Africa", "Asia", "Europe")) %>%
  # compute mean country population per continent and year
  ______(continent, year) %>%
  ______(mean_pop = mean(pop)) %>%
  ungroup() %>%
  # compute population growth as relative difference to continent population 
  # in 1958
  ______(continent) %>%
  ______(rel_pop_growth = (mean_pop - mean_pop[1]) / mean_pop[1]) %>%
  ungroup()

ggplot(my_gapminder, aes(x = ______, y = ______, fill = ______)) +
  # add barchart geom
  geom_______() + 
  # divide data into subplots by continent 
  ______(~ continent, nrow = 1) +
  # label y-axis text in percentage format
  scale_y_continuous(labels = scales::percent) +
  # add continuous fill color scale from gray to purple
  scale_______(low = "gray80", high = "purple4") +
  # remove fill colorbar
  guides(fill = FALSE) +
  # add y-axis and plot titles
  labs(x = NULL, y = "Avg. Population Growth", 
       title = "Avg. Population Growth per Continent, 1958-2007")



# Your turn 6 ----

ctr <- c("Afghanistan", "Argentina", "Bangladesh", 
         "Botswana", "Brazil", "Canada", "China",  
         "Cameroon", "Germany", "Greece", "India", 
         "Iraq", "Italy", "Japan", "Malaysia", 
         "New Zealand",  "Norway", "Rwanda", "Singapore", 
         "South Africa", "Sudan", "United States", "Venezuela")
