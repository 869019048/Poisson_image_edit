for x_pix = 434:900
    y_pix = -0.000338 * x_pix^2 + 1.254 * x_pix - 479.4;
    y_pix = round(y_pix)
    sprintf('%.0f ',y_pix)
end