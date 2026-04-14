# loading in the data set
swings <- read.csv("mlb_swings_2026.csv")

# Column filtering using the select function
swings <- swings |>
  mutate(hard_hit = if_else(launch_speed >= 95, 1, 0)) |>
  # remove deprecated / NA columns
  select(where(~!all(is.na(.)))) |>
  # remove irrelevant columns
  select(-c(game_date,
            player_name,
            batter,
            pitcher,
            des,
            game_type,
            home_team,
            away_team,
            hit_location,
            bb_type,
            game_year,
            on_3b,
            on_2b,
            on_1b,
            outs_when_up,
            inning,
            inning_topbot,
            hc_x,
            hc_y,
            hit_distance_sc,
            launch_angle,
            game_pk,
            fielder_2:fielder_9,
            estimated_ba_using_speedangle:launch_speed_angle,
            home_score:post_fld_score,
            delta_home_win_exp,
            delta_run_exp,
            estimated_slg_using_speedangle:age_bat_legacy,
            pitcher_days_since_prev_game,
            batter_days_since_prev_game,
            pitcher_days_until_next_game))


# Remove NAs and 0s from hard_hit (or in other words only have actual hard hits in the data)
swings <- swings |>
  filter(!is.na(hard_hit)) |>
  filter(hard_hit != 0)

# Creating a new variable for "Batter_get_out" which is 1 if the batter got out and 0 if they did not get out based on the events column.
swings <- swings |>
  mutate(batter_get_out = case_when(
    events %in% c("field_out", "force_out", "grounded_into_double_play", "double_play") ~ 1,
    events %in% c("single", "double", "home_run", "triple") ~ 0,
    TRUE ~ NA_real_  # This will set all other cases to NA
  )) |>
  filter(!is.na(batter_get_out)) # Remove rows where batter_get_out is NA

write_csv(swings, "mlb_swings_2026_reduced_with_Batter_get_out.csv")
