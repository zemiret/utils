import sys

BAD_ARGS = 120


def main():
    """
    This program expects that you have a dictionary formatted like this
    word1 : translation1
    word2 : translation2
    ...
    
    It expects path to this file as a first argument,
    and optional path to output file as a second one (if not given,
    defaults to 'out.csv')
    """

    if len(sys.argv) < 2:
        print("You need to supply dictionary file!", file=sys.stderr)
        sys.exit(BAD_ARGS)

    in_filename = sys.argv[1]

    with open(in_filename, 'r') as in_file:
        content = in_file.read()

    out_filename = sys.argv[2] if len(sys.argv) == 3 else 'out.csv'

    content = content.strip()
    content = list(map(lambda s: s.split(':'), content.split('\n')))

    print(content)

    with open(out_filename, 'w+') as out_file:
        for i, definitions in enumerate(content):
            [front, back] = list(map(lambda s: s.strip(), definitions))
            front = front.strip()
            back = back.strip()

            print(front, back)
 
            out_file.write('{},{}\n'.format(front, back))
            out_file.write('{},{}\n'.format(back, front))


if __name__ == '__main__':
    main()

