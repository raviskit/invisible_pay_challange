# InvisiblePay Challenge : Backend Engineer

This is a demo Ruby Micro-Service Application, utilizing Rails API.
Following API endpoints are implemented:
  ###  Output the current time (as valid JSON)
    
    endpoint: GET /api/current_time
    
  ### Convert currency inputs
  
    endpoint: /api/currency/convert
    inputs: amount (in source-currency), source-currency, target-currency
    output: amount in target-currency (as valid JSON)
  Conversion API used: The Free Currency Converter API (https://free.currencyconverterapi.com/)
  
  Also added and extra endpoint to return lists of currencies supported
    
    endpoint: /api/currency/lists
    
  
  ### Validate a VAT input
    
    input: potential VAT number
    output: country (code) for VAT number (as valid JSON)
  VAT Validation API used: CloudMersive Validate API (https://api.cloudmersive.com/swagger/index.html?urls.primaryName=Validate%20API)
  
  4. Rspec is used to cover the Test cases.
  5. Application is dockerize, running on 8081
  6. No DataBase of any kind is used.
  7. Please follow the below instructions to run the application.
  

## Prerequisite
* Ruby 2.6.3
* Rails 5.2
* docker

## Usage
Application is containerized. Just spin the docker container using
    
    docker-compose up --build

It will install all the neccessary gems and library and spins the application on localhost:8081

API endpoint: `localhost:8081/api`

## Specs

Rspec is used for writing test cases and cover all the code.
To run the specs(make sure docker container is running):
    
    docker-compose exec web rspec spec
    



