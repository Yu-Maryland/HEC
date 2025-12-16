
from typing import get_type_hints, get_origin, get_args, List, Set, Dict, Tuple, Optional
import inspect

def _is_instance_of_annotation(value, anno) -> bool:
    # Basic types and Enum direct check
    if isinstance(anno, type):
        return isinstance(value, anno)
    origin = get_origin(anno)
    args = get_args(anno)
    # Optional[X] -> Union[X, NoneType]
    if origin is type(None):
        return value is None
    if origin is None:
        # typing.Any or unresolved; allow
        return True
    if origin is list or origin is List:
        # List[T]
        if not isinstance(value, list):
            return False
        if not args:
            return True
        return all(_is_instance_of_annotation(v, args[0]) for v in value)
    if origin is set or origin is Set:
        # Set[T]
        if not isinstance(value, set):
            return False
        if not args:
            return True
        return all(_is_instance_of_annotation(v, args[0]) for v in value)
    if origin is dict or origin is Dict:
        # Dict[K, V]
        if not isinstance(value, dict):
            return False
        if len(args) != 2:
            return True
        key_t, val_t = args
        return all(_is_instance_of_annotation(k, key_t) and _is_instance_of_annotation(v, val_t) for k, v in value.items())
    if origin is tuple or origin is Tuple:
        if not isinstance(value, tuple):
            return False
        return True
    if origin is Optional:
        inner = args[0]
        return value is None or _is_instance_of_annotation(value, inner)
    from typing import Union as _TypingUnion
    if origin is _TypingUnion:
        return any(_is_instance_of_annotation(value, a) for a in args)
    return False


def check_types(func):
    def wrapper(*args, **kwargs):
        hints = get_type_hints(func)
        hints.pop('return', None)
        sig = inspect.signature(func)
        params = list(sig.parameters.values())
        # Skip implicit 'self' parameter
        bound = sig.bind_partial(*args, **kwargs)
        for name, anno in hints.items():
            if name not in bound.arguments:
                continue
            val = bound.arguments[name]
            if not _is_instance_of_annotation(val, anno):
                raise TypeError(f"Parameter {name} expects {anno}, got {type(val)}")
        return func(*args, **kwargs)
    return wrapper

# Types to mirror the C++ helper signatures
Position = Tuple[int, int]          # (line_index, char_index), 0-based
BracePair = Tuple[Position, Position]

def replace_whole_word(s, old_word, new_word):
    result = s
    start = 0
    indices = []

    # Find all candidate positions
    while True:
        start = result.find(old_word, start)
        if start == -1:  # -1 means not found
            break
        indices.append(start)
        start += 1

    # Replace from the end to keep indices valid
    for i in reversed(indices):
        end_pos = i + len(old_word)
        # Match C++ logic: only check the trailing boundary of the word
        if (end_pos >= len(result) or 
            (not result[end_pos].isalnum() and result[end_pos] != '_')):
            result = result[:i] + new_word + result[end_pos:]

    return result


def find_brace_pairs(code: str, left = '{', right = '}') -> List[BracePair]:
    """
    Identify matching pairs of braces in the given code string.
    
    Parameters:
        code: input source code
        
    Returns: 
        List of ((open_line, open_col), (close_line, close_col)) brace pairs
        
    Notes:
        A simple stack-based scanner. Unmatched braces are reported to stdout.
    """
    lines = code.splitlines()
    stack: List[Position] = []
    pairs: List[BracePair] = []
    
    for line_num, line in enumerate(lines):
        for char_num, ch in enumerate(line):
            # Opening brace
            if ch == left:
                stack.append((line_num, char_num))
            
            # Closing brace
            elif ch == right:
                if stack:
                    opening_brace = stack.pop()
                    pairs.append((opening_brace, (line_num, char_num)))
                else:
                    print(f"Unmatched closing brace at line {line_num + 1}")
    
    # Report unmatched opening braces
    while stack:
        opening_brace = stack.pop()
        print(f"Unmatched opening brace at line {opening_brace[0] + 1}")
    
    return pairs


def split(s: str, delimiters: str) -> List[str]:
    """
    1:1 match of the C++ helper:
      - delimiters is a set of characters (not substrings)
      - advance by 1 on each delimiter
      - push token only when pos > prev (no empty tokens for consecutive delimiters)
      - finalize by appending the tail if prev < len(s)
    """
    tokens = []
    n = len(s)
    prev = 0

    while True:
        pos = prev
        # Equivalent to C++ find_first_of(delimiters, prev)
        while pos < n and (s[pos] not in delimiters):
            pos += 1

        if pos < n:
            if pos > prev:
                tokens.append(s[prev:pos])
            prev = pos + 1  # advance by 1
            continue

        if prev < n:
            tokens.append(s[prev:])
        break

    return tokens


def find_match(brace_pairs, line_num, size):
    """
    Find the smallest scope (brace pair) that contains the given position.
    
    Args:
        brace_pairs: list of ((line, col), (line, col))
        line_num: (line, col) target position
        size: total length used for ordering
    
    Returns:
        Matching brace pair ((open_line, open_col), (close_line, close_col))
    """
    best_match = (0.0, float(size) + 1.0)
    best_match_index = -1
    digit_pair = []
    
    # Convert pairs to floats for ordering
    for pair in brace_pairs:
        digit_pair.append((
            float(pair[0][0]) + float(pair[0][1]) / size,
            float(pair[1][0]) + float(pair[1][1]) / size
        ))
    
    # Convert target to float position
    line_num_float = float(line_num[0]) + float(line_num[1]) / size
    
    # Identify best (smallest enclosing) match
    for pair_num in range(len(digit_pair)):
        i = digit_pair[pair_num]
        
        # Assertions matching C++ logic
        assert i[1] >= i[0] and best_match[1] >= best_match[0]
        assert ((i[0] >= best_match[1]) or 
                (i[1] <= best_match[0]) or 
                (i[0] <= best_match[0] and i[1] >= best_match[1]) or 
                (i[0] >= best_match[0] and i[1] <= best_match[1]))
        
        # Choose the smallest interval that contains the target
        if (line_num_float >= i[0] and 
            line_num_float <= i[1] and 
            i[0] > best_match[0] and 
            i[1] < best_match[1]):
            
            best_match = i
            best_match_index = pair_num
    
    # Must find a valid match
    assert best_match_index != -1
    return brace_pairs[best_match_index]


def count_substr_occurrences(s, substr):
    assert substr != ""  # substr must be non-empty
    return s.count(substr)

def have_no_intersection(ranges):
    """
    Check if any ranges intersect.
    
    Args:
        ranges: List[Tuple[T, T]] of (start, end)
    
    Returns:
        bool - True if no intersections; False otherwise
    """
    for i in range(len(ranges)):
        for j in range(i + 1, len(ranges)):
            # Unpack
            a = ranges[i][0]
            b = ranges[i][1]
            c = ranges[j][0]
            d = ranges[j][1]
            
            # Intersection check
            if a <= d and b >= c:
                return False  # found intersection
    
    return True  # no intersections


def canbeparsedas(s: str, t: type) -> bool:
    """Check if string can be parsed as the given type."""
    try:
        t(s)
        return True
    except (ValueError, TypeError):
        return False