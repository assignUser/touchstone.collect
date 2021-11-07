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
run_bm(100, 5)
# create artifacts used downstream in the GitHub Action
touchstone::benchmarks_analyze()
