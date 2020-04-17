library(tidyverse)
library(tidymodels)
library(AmesHousing)

(ames <- make_ames() %>% select(-matches("Qu")))

# Your turn 1 ----
# 1. Create a simple linear regression model on the ames data to predict _sale 
# price_ (`Sale_Price`) based on _above ground living area_ (`Gr_Liv_Area`). 
# 1. Apply the model to the original data.
# 1. Use `mutate()` to add a column with the observed sale prices; name it `truth`. 

lm_spec <- ______() %>% 
  set_engine(engine = ______) %>%
  set_mode(mode = ______)

lm_fit <- ______(object = lm_spec,
              formula = ______ ~ ______, 
              data = ______)

price_pred <- lm_fit %>% 
  ______(new_data = ames) %>% 
  mutate(______ = ames$Sale_Price)

price_pred


# Your turn 2 ----
# Use `initial_split()`, `training()`, `testing()`, `lm()` and `rmse()` to:
#   
# 1. Split ames into training (70%) and test (30%) sets. Save the `rsplit`.
# 1. Extract the training data. Fit a linear model to it. Save the model as `lm_fit`.
# 1. Measure the RMSE of your linear model with your test set.  
# 
# Keep `set.seed(100)` at the start of your code.

______(100)

ames_split <- ______(ames, ______ = 0.7)
ames_train <- ______(ames_split)
ames_test <- ______(ames_split)

lm_fit <- fit(lm_spec, ______ ~ ______, 
              data = ______)

price_pred  <- lm_fit %>% 
  ______(new_data = ames_test) %>% 
  mutate(______ = ames_test$Sale_Price)

______(price_pred, truth = ______, estimate = ______)


# Your turn 3 ----
# Modify the code below to return the **Mean Absolute Error** and **R²**. 
# Visit 
# <https://tidymodels.github.io/yardstick/reference/index.html#section-regression-metrics> 
# to find the right function to use.

______(100)

folds <- vfold_cv(ames, v = 5)

fit_res <- fit_resamples(Sale_Price ~ Gr_Liv_Area,
                         model = lm_spec,
                         resamples = folds,
                         ______)

collect_metrics(fit_res, summarize = TRUE)


# Your turn 4 ----
# Compare the performance of a regression tree model with a k-nearest neighbor 
# model on 10 bootstrap samples using RMSE as evaluation measure. 
# 
# Set `rpart` as engine for the decision tree model and `kknn` as engine for the 
# k-nearest neighbor model. Leave all model-specific parameters (e.g. `tree_depth` 
# and `neighbors`) at default.
# 
# Which of the two methods perform better and why? 

______(100)
bs <- ______(ames, times = 10)

rt_spec <- ______() %>%          
  set_engine(engine = ______) %>% 
  set_mode(______)

fbs <- ______(rt_spec, Sale_Price ~ Gr_Liv_Area, resamples = bs)
fbs %>% collect_metrics()

knn_spec <- ______() %>%          
  set_engine(engine = ______) %>% 
  set_mode(______)

fknn <- ______(knn_spec, Sale_Price ~ Gr_Liv_Area, resamples = bs)
fknn %>% collect_metrics()


# Your turn 5 ----
# Create a new classification tree model specification; name it `big_tree_spec`. 
# Set the cost complexity to 0, and the minimum number of data points in a node to split 
# to 1.
# 
# Compare the metrics of the big tree to the vanilla tree. 
# Which one predicts the test set better?
# 
# Vanilla tree performance: 
# 
# - accuracy = 0.64
# - ROC AUC = 0.66

stackoverflow <- read_rds(here::here("datasets/stackoverflow.rds"))
______(100)
so_cv <- vfold_cv(stackoverflow, v = 5)

big_tree_spec <- decision_tree(______ = 1, ______ = 0) %>% 
  ______("rpart") %>% 
  ______("classification")

______(big_tree_spec,
              remote ~ .,
              resamples = so_cv) %>%
  collect_metrics()


# Your Turn 6 ----
# Create a KNN workflow on the ames houce prices problem that tunes over the 
# number of neighbors in a 5-fold stratified CV scheme. 
# The candidate values of `neighbors` are `1, 11, 21, 31, ..., 101`.

k_grid <- expand_grid(neighbors = seq(______))

knn_tuner <- nearest_neighbor(neighbors = ______) %>% 
  set_engine("kknn") %>% 
  set_mode("regression")

knn_twf <- workflow() %>% 
  ______(knn_tuner) %>%
  ______(Sale_Price ~ Gr_Liv_Area)

______(100)
cv_folds <- vfold_cv(ames, v = 5, strata = Sale_Price, breaks = 4)
knn_results <- knn_twf %>% ______(resamples = cv_folds, grid = k_grid) 

knn_rmse <- knn_results %>% 
  collect_metrics() %>% 
  filter(.metric == "rmse")
knn_rmse


# Your Turn 7 ----

# Create a recipe that performs z-score normalization on each numeric 
# variable of the ames data. 
# 
# A z-score is calculated by subtracting the variable mean from an individual 
# raw value and then dividing the difference by the variable standard deviation.
# 
# Tip: Look up the appropriate `step_*()` functions at 
# <https://tidymodels.github.io/recipes/reference/index.html>.



