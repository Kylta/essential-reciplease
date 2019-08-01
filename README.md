# Essential Reciplease - Ingredients Feature

## BDD Specs

### Story: Customer add ingredients for his recipe

### Narrative #1

```
As a customer
I want to add ingredients to create my recipe
So I can see the list of my ingredients
```

#### Scenario (Acceptance criteria)
```
Given the customer 
When the customer add ingredients for his recipe
Then the app should display his list of ingredients
```

### Narrative #2

```
As a customer
I want to search recipe with my ingredients list
So I can search recipe 
```

#### Scenario (Acceptance criteria)
```
Given the customer with an ingredients list
When the customer want search recipes
Then the app should change screen (to be define)
```

```
Given the customer with an empty ingredients list
When the customer want search recipes
Then the app display an error (or disable button => To be define)
```

### Narrative #3
```
As a customer
I want to delete ingredients in my list
So I start a new empty list
```

#### Scenario (Acceptance criteria)
```
Given the customer with an ingredients list
When the customer want to delete it
Then the app should display an empty list
```

```
Given the customer with an empty ingredients list
When the customer want to delete it
Then the app should diplsay an error (or disable button => To be define)
```
