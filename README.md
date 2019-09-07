# weShop app :iphone:
Project overview,functuonalities and dependencies from my August built *weShop* app, with main focus on State Management.

Designed by Maximilian Schwarzmüller, implemented by me.
 ## Project Overview
*weShop* is online mobile cross-platform application, which allows users to shop variety of items on the market, as well as to add their own items and sell them to the public.

- ### Overall Approach
  - Used the [Provider Package & Pattern](https://pub.dev/packages/provider) to distribute the data upon the entire app. 
  - Used the [Google's Firabase Web Server](https://firebase.google.com), which is internally communicating with the users db.
  - Used Token Authentication - Stateless *RESTful API* to provide endpoints, to which the users are sending requests to get authenticated. 

### Project Functions

All products are fetched via the *Firebase Server*

1. **Authentication Screen**
   - The user can enter his credentials to login into the system.
   - The user can enter his credentials to register into the system.
   - The credentials are validated toward the information saved in the database.
   - The user is automatically logged in if his token, stored on the device storage is not expired in the db.

      <div align="center">
      
      ![weShop-auth](https://user-images.githubusercontent.com/45242072/64466198-81416180-d108-11e9-8148-bb1263378a9e.gif)
       
      </div>
      
2. **Products Screen - Favorite**
   - The user can filter or save items via the favorite feautre
      
      <div align="center">
      
      ![weshop-favorite](https://user-images.githubusercontent.com/45242072/64466310-31af6580-d109-11e9-9948-ecce167ed96a.gif)
       
      </div>
      
3. **Products Screen - Basket**
   - The user can add items to his basket
   - The user can remove items from his basket
   - The user can check out the items in his basket
   
      <div align="center">
      
      ![weshop-favorite](https://user-images.githubusercontent.com/45242072/64466310-31af6580-d109-11e9-9948-ecce167ed96a.gif)
       
      </div>

4. **Edit Products Screen**
   - The user can add his own item to the all products
   - The user can remove his own items from all products
   - The user can edit his own items 
      
      <div align="center">
      
      ![weshop-add-product](https://user-images.githubusercontent.com/45242072/64466740-7fc56880-d10b-11e9-9afc-5336947a5767.gif)
       
      </div>
      


4. **Product Detail Screen**
   - The user can see detailed screen of specific item
      
      <div align="center">
      
      ![weshop-add-fancy-apps](https://user-images.githubusercontent.com/45242072/64466717-602e4000-d10b-11e9-837e-ac5a777aa813.gif)
       
      </div>   
   
### Dependencies 
```
  flutter:
    sdk: flutter
  provider: 3.0.0
  intl: ^0.15.8
  http: ^0.12.0+2
  shared_preferences: ^0.5.3+4
```

### How to run locally
1. Open project 
2. Run *flutter pub get* in the terminal to retrieve the required dependencies
3. Start your mobile emulator
4. Run the application from your IDE *(e.g. Visual Studio Code)*

   

   
