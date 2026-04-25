# Loading Package
swings <- read.csv("mlb_swings_2026.csv")

# Data Cleaning
library(tidyverse)

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

# Filtering to just have pitching related variables and the target variable (hard_hit)
swings_pitch = swings |>
  select(pitch_type, release_speed, effective_speed,
         release_pos_x, release_pos_y, release_pos_z,
         release_extension, arm_angle,
         release_spin_rate, spin_axis,
         pfx_x, pfx_z,
         vx0, vy0, vz0, ax, ay, az,
         plate_x, plate_z, zone,
         balls, strikes, p_throws,
         sz_top, sz_bot,
         n_thruorder_pitcher, pitch_number, hard_hit)

# filtering out NA's and converting character variables to factors
swings_pitch <- swings_pitch |>
  mutate(
    pitch_type = as.factor(pitch_type),
    p_throws = as.factor(p_throws),
    hard_hit = factor(hard_hit, levels = c(0, 1))
  ) |>
  filter(!is.na(hard_hit))|>
  na.omit()
