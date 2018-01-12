(read_char)
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
                            (read_char)
                            NOT NEWLINE / SPACE / QUOTE / SLASH / HASH =========
                            >
                        ]
                        >
                        [
                            -
                            <
                            HASH ===============================================
                            (read_char)
                            (subtract/newline)
                            [
                                (read_char)
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
                        (read_char)
                        (subtract/newline)
                        [
                            (add/newline)
                            >
                        ]
                        (read_char)
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
                    (read_char)
                    (subtract/double_quote)
                    [
                        (add/double_quote)
                        >
                        (read_char)
                        (subtract/double_quote)
                    ]
                    (read_char)
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
                (read_char)
                (subtract/single_quote)
                [
                    (add/single_quote)
                    >
                    (read_char)
                    (subtract/single_quote)
                ]
                (read_char)
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
            (read_char)
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
