size = 9
region_size = int(size**0.5)
board = [[[x for x in range(1, size+1)] for y in range(size)] for z in range(size)]
is_vergleisch = True


if size == 9:
    if not is_vergleisch:
        board[0][0] = [5]
        board[0][1] = [3]
        board[0][4] = [7]
        board[1][0] = [6]
        board[1][3] = [1]
        board[1][4] = [9]
        board[1][5] = [5]
        board[2][1] = [9]
        board[2][2] = [8]
        board[2][7] = [6]
        board[3][0] = [8]
        board[3][4] = [6]
        board[3][8] = [3]
        board[4][0] = [4]
        board[4][3] = [8]
        board[4][8] = [1]
        board[5][0] = [7]
        board[5][4] = [2]
        board[5][8] = [6]
        board[6][1] = [6]
        board[6][6] = [2]
        board[6][7] = [8]
        board[7][3] = [4]
        board[7][4] = [1]
        board[7][5] = [9]
        board[7][8] = [5]
        board[8][4] = [8]
        board[8][7] = [7]
        board[8][8] = [9]
    else:
        board[0][0] = [8]
        board[0][3] = [2]
        board[0][5] = [6]
        board[0][8] = [4]
        board[1][1] = [3]
        board[1][7] = [2]
        board[2][4] = [8]
        board[3][0] = [2]
        board[3][8] = [6]
        board[4][2] = [5]
        board[4][6] = [2]
        board[5][0] = [4]
        board[5][8] = [9]
        board[6][4] = [2]
        board[7][1] = [2]
        board[7][7] = [5]
        board[8][0] = [5]
        board[8][3] = [8]
        board[8][5] = [1]
        board[8][8] = [2]
    sign_board = [ 
        ['.>v.', '.<v>', '..v<',      '.<^.', '.<v<', '..v<',      '.>^.', '.<^>', '..^<'], #ok
        ['v>^.', 'v<v>', 'v.v<',      '^>^.', 'v<^>', 'v.v<',      '^>v.', '^<^>', '^.v<'],
        ['^>..', 'v<.>', 'v..<',      '^>..', '^>.>', 'v..>',      'v>..', '^<.>', 'v..<'],

        ['.<v.', '.>v<', '..v>',      '.<^.', '.<^<', '..^<',      '.<^.', '.<^<', '..v<'],
        ['v<^.', 'v>^<', 'v.v>',      '^<v.', '^<v<', '^.v<',      '^<^.', '^>v<', 'v.^>'],
        ['^<..', '^>.<', 'v..>',      'v<..', 'v>.<', 'v..>',      '^<..', 'v<.<', '^..<'],

        ['.>v.', '.>v>', '..^>',      '.>^.', '.<^>', '..^<',      '.>v.', '.<v>', '..v<'],
        ['v>^.', 'v<^>', '^.v<',      '^<^.', '^>v<', '^.v>',      '.>v.', 'v>^<', 'v.^>'],
        ['^<..', '^>.<', 'v..>',      '^>..', 'v>.>', 'v..>',      'v<..', '^>.<', '^..>'],

    ]

elif size == 4:
    # sign_board = [#top, right, bottom, left
    #     ['.<^.', '..^<', '.<v.', '..v<'],
    #     ['^<..', '^..<', 'v<..', 'v..<'],
    #     ['.>^.', '..^>', '.>v.', '..v>'],
    #     ['^>..', '^..>', 'v>..', 'v..>'],
    # ]
    if not is_vergleisch:
        board[0][0] = [1]
        board[1][1] = [2]
        board[2][2] = [3]
        board[3][3] = [4]

    
    sign_board = [ #top, right, bottom, left
        ['.<^.', '..v<', '.>v.', '..^>'],
        ['^>..', 'v..>', 'v<..', '^..<'],
        ['.<^.', '..v<', '.>v.', '..^>'],
        ['^>..', 'v..>', 'v<..', '^..<'],
    ]