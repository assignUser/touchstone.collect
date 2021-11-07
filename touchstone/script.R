# installs branches to benchmark
touchstone::refs_install()

n <- 1000
# benchmark a function call from your package (two calls per branch)
touchstone::benchmark_run_ref(
  expr_before_benchmark = library(touchstone.collect),
  head_faster = head_faster(!!n),
  n = 5
)

touchstone::benchmark_run_ref(
  expr_before_benchmark = library(touchstone.collect),
  base_faster = base_faster(!!n),
  n = 5
)

# create artifacts used downstream in the GitHub Action
touchstone::benchmarks_analyze()
