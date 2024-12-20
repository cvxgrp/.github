from cvx.dog.demo import Dog


def test_dog():
    dog = Dog(name="peter")
    assert dog.name == "peter"
