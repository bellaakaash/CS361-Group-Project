var fs = require("fs")

class Ingredient {
    constructor(name, amount, perishable){
        this.name = name
        this.amount = amount
        //this.perishable = perishable
    }

    printInfo(){
        console.log("Food name: " + this.name)
        console.log("You have a total of " + this.amount)
    }

    printPerishable(){
        console.log("Be careful " + this.name + " is persishable")
    }
}

let uniqueIngredientTotal = 0
const ingredientArray = []

fs.writeFile( 
    "ingredients.txt", 
    uniqueIngredientTotal.toString(), 
    function (err) { 
      if (err) { 
        return console.error(err); 
      }
    })

//Create on user input from app
//let newIngredientName = prompt("Please enter the name of the ingredient")
//let newIngredientAmount = prompt("Please enter an integer for the amount of the ingredient")
//let newIngredientPerishable = prompt("Please enter 'true' or 'false' if the ingredient is persiable")

// while(typeof newIngredientName !== "string"){
//     newIngredientName = prompt("Please enter the name of the ingredient, make sure the input is a string!")
// }
// while(typeof newIngredientAmount !== "number"){
//     newIngredientAmount = prompt("Please enter an integer for the amount of the ingredient, make sure the input is an integer")
// }

//use date input from html form to add expiration date

// while(typeof newIngredientPerishable !== "boolean"){
//     newIngredientPerishable = prompt("Please enter 'true' or 'false' if the ingredient is persiable")
// } 

//const newIngredient = new Ingredient(newIngredientName, newIngredientAmount, newIngredientPerishable)
//ingredientArray[uniqueIngredientTotal] = newIngredient
//uniqueIngredientTotal++

//Read
//let found = false

//grab user input

//let matchingIngredient = null
//let ingredientFound = false

// for(i = 0; i < uniqueIngredientTotal; i++){
//     if(matchingIngredient.name === ingredientArray[i].name){
//         ingredientArray[i].printInfo()
//         ingredientFound = true
//     }
// }

// if(ingredientFound === false){
//     console.log("No ingredient found with name: " + matchingIngredient.name)
// }

//Update
//Delete