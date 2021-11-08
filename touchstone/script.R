# installs branches to benchmark
touchstone::refs_install()

run_bm <- function(n, reps, id = glue::glue("_{n}x{reps}")) {
  touchstone::benchmark_run_ref(
    expr_before_benchmark = library(touchstone.collect),
    "head_faster{id}" := head_faster(!!n),
    n = reps
  )

  touchstone::benchmark_run_ref(
    expr_before_benchmark = library(touchstone.collect),
    "base_faster{id}" := base_faster(!!n),
    n = reps
  )

  touchstone::benchmark_run_ref(
    expr_before_benchmark = library(touchstone.collect),
    "same_speed{id}" := same_speed(!!n),
    n = reps
  )
}

# fast function, low reps
  # bench::mark(same_speed(100))$median[[1]] %>%
  #   as.numeric() %>%
  #   `*`(0.2) = 0.0001738771
Sys.setenv(TC_DELAY = "0.0002")
run_bm(100, 5)

# fast function, medium reps
  # bench::mark(same_speed(100))$median[[1]] %>%
  #   as.numeric() %>%
  #   `*`(0.2) = 0.0001738771
Sys.setenv(TC_DELAY = "0.0002")
#un_bm(100, 30)

# fast function, high reps
  # bench::mark(same_speed(100))$median[[1]] %>%
  #   as.numeric() %>%
  #   `*`(0.2) = 0.0001738771
# Sys.setenv(TC_DELAY = "0.0002")
# run_bm(100, 100)

# Slow function, low reps
  # bench::mark(same_speed(5000))$median[[1]] %>%
  #   as.numeric() %>%
  #   `*`(0.2) = 0.4349948
Sys.setenv(TC_DELAY = "0.45")
#run_bm(5000, 5)

# Slow function, medium reps
  # bench::mark(same_speed(5000))$median[[1]] %>%
  #   as.numeric() %>%
  #   `*`(0.2) = 0.4349948
Sys.setenv(TC_DELAY = "0.45")
#run_bm(5000, 30)

# Slow function, high reps
  # bench::mark(same_speed(5000))$median[[1]] %>%
  #   as.numeric() %>%
  #   `*`(0.2) = 0.4349948
# Sys.setenv(TC_DELAY = "0.45")
# run_bm(5000, 100)

# create artifacts used downstream in the GitHub Action
touchstone::benchmarks_analyze()
