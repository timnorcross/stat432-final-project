library(tidyverse)
statcast = read_csv("mlb_statcast_2026.csv")

# remove deprecated / NA columns
statcast  = statcast |>
  select(where(~!all(is.na(.))))

#write_csv(statcast, "mlb_statcast_2026_reduced.csv")

