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
            NOT NEWLINE / SPACE
            (subtract/single_quote)
            [
                (add/single_quote)
                NOT NEWLINE / SPACE / SINGLE QUOTE
                (subtract/double_quote)
                [
                    (add/double_quote)
                    NOT NEWLINE / SPACE / QUOTE
                    (subtract/slash)
                    [
                        (add/slash)
                        NOT NEWLINE / SPACE / QUOTE / HASH
                        (subtract/hash)
                        [
                            (add/hash)
                            NOT NEWLINE / SPACE / QUOTE / SLASH / HASH =========
                            >
                            ,
                            .
                            NOT NEWLINE / SPACE / QUOTE / SLASH / HASH =========
                            >
                        ]
                        >
                        [
                            -
                            <
                            HASH ===============================================
                            ,
                            .
                            (subtract/newline)
                            [
                                ,
                                .
                                (subtract/newline)
                            ]
                            HASH ===============================================
                            >>
                        ]
                        <
                    ]
                    >
                    [
                        -
                        <
                        SLASH ==================================================
                        ,
                        .
                        (subtract/newline)
                        [
                            (add/newline)
                            >
                        ]
                        ,
                        .
                        SLASH ==================================================
                        >>
                    ]
                    <
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
        NEWLINE ================================================================
        >>
    ]
    <<
]
<
