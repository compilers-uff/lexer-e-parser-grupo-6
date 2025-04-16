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

    def move(self: "Point", dx: int, dy: int) -> None:
        self.x = self.x + dx
        self.y = self.y + dy

    def is_origin(self: "Point") -> bool:
        return self.x == 0 and self.y == 0

def main() -> int:
    global counter
    nums: [int] = [1, 2, 3, 4]
    letters: [str] = ["a", "b", "c"]
    result: int = factorial(len(nums))

    point: Point = Point(0, 0)
    point.move(1, 2)

    if point.is_origin():
        print("At origin")
    elif point.x > 0:
        print("Moved")
    else:
        print("Unknown")

    index: int = 0
    while index < len(letters):
        print(letters[index])
        index = index + 1

    for n in nums:
        if n % 2 == 0:
            print(n)

    count: int = 0

    def local_adder(x: int) -> int:
        nonlocal count
        count = count + x
        return count

    print(local_adder(5))
    counter = counter + 1
    return result + counter
