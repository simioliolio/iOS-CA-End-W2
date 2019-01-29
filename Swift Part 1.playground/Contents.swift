import UIKit

var str = "Hello, playground"
str = "Something else"

let integerFull: Int = Int(1)
let integerBrief = 1
let doubleFull: Double = Double(1.5)
let doubleBrief = 1.5

let date = Date() // Today (see documentation)

// Simple struct called User, which encapsulates three properties
struct User {
    let name: String
    let age: Int
    let car: Car?   // The user may not have a car, so we define the
}                   // type of this property as an 'optional Car'

struct Car: CustomStringConvertible { // Struct conforms to CustomStringConvertible, so it can be printed nicely.
    let model: String
    var description: String {   // 'description' is defined in 'CustomStringConvertible' protocol
        return model            // Powerclaw-click the protocol name to learn more!
    }
}

// For simple structs, we get an initialiser for free, which we can use to make a car...
let simonsCar = Car(model: "Golf")

// ...and a user, passing the car
let simon = User(name: "Simon", age: 33, car: simonsCar)
print(simon)

// If statement
if simon.age < 38 {
    print("You've still got it!")
} else {
    print("You're getting on a bit!")
}

// Traditional for loop
for character in simon.name {
    print("printing character...")
    print(character)
}

// Shortform functional for loop (don't worry about this for now!)
simon.name.forEach {
    print($0)
}

// Longform functional for loop (don't worry about this for now!)
simon.name.forEach({(character: Character)->() in
    print(character)
})

// Add users into an array
let rob = User(name: "Rob", age: 42, car: nil)      // We pass nil for car,
let josh = User(name: "Josh", age: 22, car: nil)    // if these users do not have one

let userArray: [User] = [simon, rob, josh]
let simonFromArray = userArray[0] // Get object from array using subscript
print(simonFromArray)

// Add users into a dictionary
let userDictionary: [Int: User] = [1: simon, 2: rob, 3: josh]

// When we ask the dictionary for the value for key '1', it returns an optional value,
// because the may not be a value for that key
let optionalSimon = userDictionary[1] // Type is 'User?'

// We can define a function to return a greeting for a user
// The function takes a User as an input argument, and returns a String
func greetingFor(user: User) -> String {
    return "Hi \(user.name)"
}

// If we try and pass our optional user to this function, it does not compile
// This is because optionalSimon is an optional user. To print this, we need
// to be sure that optionalSimon is not nil
//greet(user: possiblySimon)

// An antiquated way of doing this is to check that something is not nil, then
// have the confidence to pass the optional regardless. We can 'force-unwrap'
// the optional by using '!', but this is bad practice, as force-unwrapping
// may cause a crash at run time!
if (optionalSimon != nil) {
    print(greetingFor(user: optionalSimon!)) // DO NOT USE '!'
}

// Instead, we can use optional binding to create a condition that produces
// an 'unwrapped' User as a new constant. Once unwrapped, we pass this user
// to our function
if let uwUser = optionalSimon {
    print(greetingFor(user: uwUser))
}

// Say we have another function to return a question about the user's car
func questionAbout(car: Car) -> String {
    return "How is your \(car)?"
}

// To print the user's Car, we could nest optional binding statements...
if let uwUser = optionalSimon {
    if let uwCar = uwUser.car {
        print(questionAbout(car: uwCar))
    } // else do nothing, car is nil, so we can't make a question about it!
}

// ...or we can link them by comma-separating the conditions.
if let uwUser = optionalSimon, let uwCar = uwUser.car {
    print(questionAbout(car: uwCar))
}

// If we don't care about the user, but just the car, we can use
// optional chaining and use ? to honour the optionality.
if let uwCar = optionalSimon?.car {
    print(questionAbout(car: uwCar))
}
