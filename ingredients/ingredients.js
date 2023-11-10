class Ingredient {
    constructor(name, amount, perishable){
        this.name = name
        this.amount = amount
        this.perishable = perishable
    }

    printPerishable(){
        console.log("Be careful " + this.name + " is persishable")
    }
}

let uniqueIngredientTotal = 0
const ingredientArray = []

//Testing purposes
//const Chicken = new Ingredient('Chicken', 2, true)
//console.log(Chicken.name, Chicken.amount)
//if(Chicken.perishable === true){
    //Chicken.printPerishable()
//}

//Create on user input from app
let newIngredientName = prompt("Please enter the name of the ingredient")
let newIngredientAmount = prompt("Please enter an integer for the amount of the ingredient")
let newIngredientPerishable = prompt("Please enter 'true' or 'false' if the ingredient is persiable")

while(typeof newIngredientName !== "string"){
    newIngredientName = prompt("Please enter the name of the ingredient, make sure the input is a string!")
}
while(typeof newIngredientAmount !== "number"){
    newIngredientAmount = prompt("Please enter an integer for the amount of the ingredient, make sure the input is an integer")
}
while(typeof newIngredientPerishable !== "boolean"){
    newIngredientPerishable = prompt("Please enter 'true' or 'false' if the ingredient is persiable")
}

const newIngredient = new Ingredient(newIngredientName, newIngredientAmount, newIngredientPerishable)
ingredientArray[uniqueIngredientTotal] = newIngredient
uniqueIngredientTotal++

//Read
//Update
//Delete