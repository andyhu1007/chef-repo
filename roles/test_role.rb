name "test_role"
description "test role"
run_list [
    "recipe[nodejs]",
    "recipe[mongodb]"
    ]
