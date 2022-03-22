add_generic_test(
    name lut
    board_list arty35t arty_s7_25 zcu104
    sources lut.v
)

add_generic_test(
    name lut
    board_list testboard
    sources lut_testarch.v
)

add_xc7_validation_test(
    name lut
    board_list arty35t
)
