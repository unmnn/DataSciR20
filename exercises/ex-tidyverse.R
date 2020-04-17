library(tidyverse)

bookings <- read_csv("datasets/bookings.csv")
properties <- read_csv("datasets/properties.csv")

# Your turn 1 ----
# Create a new tibble `x` that 
# 
# - only contains the columns `room_nights` and `review_score`, and 
# - only contains the bookings with a price per night of less than 80.
# 
# 1. _...using base `R` functions only._
# 2. _...using the `dplyr` functions `select()` and `filter()`._

# base R


# tidyverse



# Your turn 2 ----
# Use `%>%` to write a pipeline which extracts all bookings with Friday as check-in 
# day while only returning the columns `property_id` and `status`. 




# Your turn 3 ----
# Write a pipeline which calculates the mean-centered `price_per_night` as new column 
# names `centered_ppn`. The returned data frame should only contain this new column.
# 
# _You need `mutate()` and `select()`._



# Your turn 4 ----
# Obtain a one-row summary tibble of the bookings data containing the following statistics:
#   
# - The number of rows (Hint: use the function `n()`)
# - The number of `"stayed"` bookings
# - The mean of the _total price_ (Hint: you have to compute the total price first)
# 
# The output tibble should contain three columns and just one row.



# Your turn 5 ----
# Write a pipeline that yields a tibble containing only the most expensive booking 
# of each property. Return only the property id and the price of the most expensive booking.
# 
# You should get as many rows as there are unique properties:
#   
# ```{r}
# n_distinct(bookings$property_id) # convenience function for `length(unique(bookings$property_id))`
# ```
# 1. Calculate `price_total` using `mutate()`.
# 2. Group by `property_id` using `group_by()`.
# 3. Filter rows where the total price is equal to the maximum of the total price 
# (for that property using `filter()`).
# 4. Select the columns `property_id` and `price_total` using `select()`.



# Your turn 6 ----
# Calculate the number of bookings per city. 
# 
# Hint: Join the tibbles `bookings` and `properties` and _count_ the number of rows per city.  



# Your turn 7 ----
# ### Do properties appeal to business travellers and tourists alike?
# 
# - Convert the column `for_business` to a factor with the levels `"business"` and `"tourist"`.
# - For each property, calculate the average review score given by business travelers and tourists.
# - Then, calculate the average review score difference between business travelers and tourists. 



# Your turn 8 ----
# Actually, we don't need to store the property facilities as tibble, since the column `facility_nr` is redundant.
# 
# We change the `facilities` column to a list column, such that each element is a character vector of property facilities.
# 
properties_l <- properties %>%
  mutate(facilities = strsplit(facilities, ","))
# head(properties_l, 3)
# 
# Example:
# properties_l$facilities[[1]]
# 
# Add a column `n_features` to `properties` that contains the number of facilities.
# 
# Hint: Use the `map_*()` function that returns an integer vector. 



# Your turn 9 ----
### _Which factors contribute to the average property review score?_
# 
# For **each city**, fit a **linear regression** model<sup>1</sup> to predict a property's **average review score** based on average price per night, number of bookings (stayed or cancelled), and property type. Compare the quality of the three models using $R^2$.
# 
# Strategy:
# 
# 1. Compute the summary statistics `avg_review` (average review score), 
# `n_bookings` (number of bookings) and `avg_price` (average price per night) 
# for each property and city.
# 2. For each city, fit a linear regression model (?`lm`) using the formula 
# `avg_review ~ property_type + n_bookings + avg_price`. Save these models as new 
# column `fit`.
# 3. Extract the $R^2$ value (`r.squared`) from `fit` using the appropriate `map_*` function.
