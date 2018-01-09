,
.
[
    >
    [-]
    +
    >
    [-]
    <<
    (subtract/newline)
    [
        (add/newline)
        NOT NEWLINE
        (subtract/space)
        [
            (add/space)
            NOT NEWLINE OR SPACE
            (subtract/single_quote)
            [
                (add/single_quote)
                NOT NEWLINE OR SPACE OR SINGLE QUOTE
                (subtract/double_quote)
                [
                    (add/double_quote)
                    NOT NEWLINE OR SPACE OR SINGLE QUOTE OR DOUBLE QUOTE
                    >
                    ,
                    .
                    NOT NEWLINE OR SPACE OR SINGLE QUOTE OR DOUBLE QUOTE
                    >
                ]
                >
                [
                    -
                    <
                    DOUBLE QUOTE ===============================================
                    ,
                    .
                    (subtract/double_quote)
                    [
                        (add/double_quote)
                        >
                        ,
                        .
                        (subtract/double_quote)
                    ]
                    ,
                    .
                    DOUBLE QUOTE ===============================================
                    >>
                ]
                <
            ]
            >
            [
                -
                <
                SINGLE QUOTE ===================================================
                ,
                .
                (subtract/single_quote)
                [
                    (add/single_quote)
                    >
                    ,
                    .
                    (subtract/single_quote)
                ]
                ,
                .
                SINGLE QUOTE ===================================================
                >>
            ]
            <
        ]
        >
        [
            -
            <
            SPACE ==============================================================
            <
            [>]
            >
            ,
            .
            SPACE ==============================================================
            >>
        ]
        <
    ]
    >
    [
        -
        <
        NEWLINE ================================================================
        >
        NEWLINE ================================================================
        >
    ]
    <<
]
<
