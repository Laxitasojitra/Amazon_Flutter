
## Amazon Clone 


To deploy this project run

```bash
  npm run deploy
```


## Features
- Email & Password Authentication
- Persisting Auth State
- Searching Products
- Product Details
- Rating
- Getting Deal of the Day
- Cart
- Viewing My Orders
- Viewing Order Details & Status
- Admin Panel
- Viewing All Products
- Add/Delete Products
- Changing Order Status




## Deployment

->After cloning this repository, migrate to amazon_flutter folder. Then, follow the following steps:

- Create MongoDB Project & Cluster
- Click on Connect, follow the process where you will get the uri.- Replace the MongoDB uri with yours in server/index.js.
- Head to lib/constants/global_variables.dart file, replace with your IP Address.




## Installation

Then run the following commands to run your app:

- Server Side

```bash
  cd server
  npm install
  npm run dev (for continuous development)
   OR
  npm start (to run script 1 time)
```
- Client Side
```bash
  flutter pub get
  open -a simulator 
  flutter run
```

## Technology

- Server: Node.js, Express, Mongoose, MongoDB

- Client: Flutter, Provider
