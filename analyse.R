library(dplyr)
library(purrr)
library(fs)
library(lubridate)
library(ggplot2)

files <- dir_ls(recurse = TRUE, glob = "*.R", invert = TRUE, type = "file")

dates <- files %>%
    path_split() %>%
    do.call(base::rbind, .) %>%
    as_tibble(.name_repair = "unique") %>%
    rename(time = "...1", name = "...2", branch = "...3") %>%
    mutate(time = as_datetime(as.numeric(time)))

info <- files %>%
    map(~ read.delim(.x, sep = " ")) %>%
    map(as_tibble) %>%
    map(~ rename(., branch = ref)) %>%
    map2(.y = dates$time, ~ mutate(.x, time = .y)) %>%
    bind_rows()


data <- full_join(dates, info, by = c("branch", "name", "time")) 

base_names <- strsplit(data$name, "_") %>% map_chr(~ paste0(.x[1], "_", .x[2])) 


sdf <- data %>%
    group_by(branch, name, time) %>%
    summarise(
        mean = bench::as_bench_time(mean(elapsed)),
        sd = sd(elapsed), .groups = "keep"
    ) %>%
     group_by(name) %>%
     group_split()

data_factors <- data %>% mutate(
    block = factor(block),
    branch = factor(branch, levels = unique(branch))
)

aovs <- data_factors %>%
    group_by(name, time) %>%
    summarise(mod = list(aov(elapsed ~ branch, data = cur_data())))

ggplot(sdf[[6]], aes(x = time, y = mean, color = branch)) + geom_point() + geom_line()
