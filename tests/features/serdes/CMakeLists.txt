add_generic_test(
    name serdes
    board_list basys3
    sources serdes.v serdes_test.v
)

add_generic_test(
    name oserdese3
    board_list zcu104
    sources oserdese3.v
    constr_prefix oserdese3
)

add_generic_test(
    name iserdese3
    board_list zcu104
    sources iserdese3.v
    constr_prefix iserdese3
)