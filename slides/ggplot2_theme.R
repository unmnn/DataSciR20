# ---- set-theme ----
ggplot2::theme_set(
  ggplot2::theme_minimal(base_size = 18, base_family = "Fira Sans") +
    ggplot2::theme(panel.grid.minor = ggplot2::element_blank()) + 
    ggplot2::theme(axis.line = ggplot2::element_line()) + 
    ggplot2::theme(axis.ticks = ggplot2::element_line())
)