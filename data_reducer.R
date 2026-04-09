library(tidyverse)
swings = read_csv("mlb_swings_2026.csv")


swings = swings |>
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

write_csv(swings, "mlb_swings_2026_reduced.csv")

