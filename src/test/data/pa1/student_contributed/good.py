counter: int = 0

def identity(x: object) -> object:
    return x

def factorial(n: int) -> int:
    if n <= 1:
        return 1
    else:
        return n * factorial(n - 1)

class Point(object):
    x: int = 0
    y: int = 0

    def __init__(self: "Point", x: int, y: int):
        self.x = x
        self.y = y

    def move(self: "Point", dx: int, dy: int):
        self.x = self.x + dx
        self.y = self.y + dy

    def is_origin(self: "Point") -> bool:
        return self.x == 0 and self.y == 0

def main() -> int:
    global counter
    nums: [int] = None
    letters: [str] = None
    result: int = None
    point: Point = None
    index: int = 0
    count: int = 0

    def local_adder(x: int) -> int:
        nonlocal count
        count = count + x
        return count

    point  = Point(0, 0)
    result = factorial(len(nums))
    point.move(1, 2)
    nums = [1, 2, 3, 4]
    letters = ["a", "b", "c"]
    
    if point.is_origin():
        print("At origin")
    elif point.x > 0:
        print("Moved")
    else:
        print("Unknown")

    while index < len(letters):
        print(letters[index])
        index = index + 1

    for n in nums:
        if n % 2 == 0:
            print(n)


    print(local_adder(5))
    counter = counter + 1
    return result + counter
