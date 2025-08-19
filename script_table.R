library(junco)
library(dplyr)
library(pharmaverseadamjnj)

ADEG <- pharmaverseadamjnj::adeg |>
  select(STUDYID, USUBJID, TRT01A, PARAM, AVISIT, AVAL, CHG) |>
  filter(PARAM == "ECG Mean Heart Rate (beats/min)") |>

  mutate(colspan_trt = factor(
    if_else(TRT01A == "Placebo", " ", "Active Study Agent"),
    levels = c("Active Study Agent", " ")
  )) |>

  mutate(rrisk_header = "Risk Difference (%) (95% CI)") |>
  mutate(rrisk_label = paste(TRT01A, paste("vs", "Placebo")))

colspan_trt_map <- create_colspan_map(ADEG,
  non_active_grp = "Placebo",
  non_active_grp_span_lbl = " ",
  active_grp_span_lbl = "Active Study Agent",
  colspan_var = "colspan_trt",
  trt_var = "TRT01A"
)
ref_path <- c("colspan_trt", " ", "TRT01A", "Placebo")

lyt <- basic_table() |>
  split_cols_by(
    "colspan_trt",
    split_fun = trim_levels_to_map(map = colspan_trt_map)
  ) |>
  split_cols_by("TRT01A") |>
  split_rows_by(
    "PARAM",
    label_pos = "topleft",
    split_label = "Blood Pressure",
    section_div = " ",
    split_fun = drop_split_levels
  ) |>
  split_rows_by(
    "AVISIT",
    label_pos = "topleft",
    split_label = "Study Visit",
    split_fun = drop_split_levels,
    child_labels = "hidden"
  ) |>
  split_cols_by_multivar(
    c("AVAL", "AVAL", "CHG"),
    varlabels = c("n/N (%)", "Mean (CI)", "CFB (CI)")
  ) |>
  split_cols_by("rrisk_header", nested = FALSE) |>
  split_cols_by(
    "TRT01A",
    split_fun = remove_split_levels("Placebo"),
    labels_var = "rrisk_label"
  ) |>
  split_cols_by_multivar(c("CHG"), varlabels = c(" ")) |>
  analyze("STUDYID",
    afun = a_summarize_aval_chg_diff_j,
    extra_args = list(
      format_na_str = "-", d = 0,
      ref_path = ref_path, variables = list(arm = "TRT01A", covariates = NULL)
    )
  )

result <- build_table(lyt, ADEG)

rtables.officer::tt_to_flextable(result)
