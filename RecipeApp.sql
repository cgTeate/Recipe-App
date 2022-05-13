--used for dropping and creating purposes
--to rerun for application, disable the connection on VS, run the script and reconnect VS to the database
use master;
GO

IF DB_ID('RecipeApp') IS NOT NULL
	DROP DATABASE RecipeApp;
GO

CREATE DATABASE RecipeApp;
GO

use RecipeApp;
GO
DROP TABLE IF EXISTS Ingredient;
GO
CREATE TABLE Ingredient
(
 IngredientId int NOT NULL IDENTITY,
 IngredientName  varchar(250) NOT NULL,
 PRIMARY KEY (IngredientId),
);
GO

DROP TABLE IF EXISTS Measure;
GO
CREATE TABLE Measure
(
 MeasureId int NOT NULL IDENTITY,
 Measurement varchar(250) NOT NULL,
 PRIMARY KEY (MeasureId),
);
GO

DROP TABLE IF EXISTS RecipeImage;
GO
CREATE TABLE RecipeImage
(
 RecipeImageId int NOT NULL IDENTITY,
 Image         image NULL DEFAULT 'https://j4y2v5w8.stackpathcdn.com/wp-content/uploads/2017/03/Generic-vs.-Brand-Name.jpg',
 PRIMARY KEY (RecipeImageId)
);
GO

DROP TABLE IF EXISTS ReviewImage;
GO
CREATE TABLE ReviewImage
(
 ReviewImageId int NOT NULL IDENTITY,
 Image			image NULL DEFAULT 'https://cdn.landesa.org/wp-content/uploads/default-user-image.png',
 PRIMARY KEY (ReviewImageId)
);
GO

DROP TABLE IF EXISTS Users;
GO
CREATE TABLE Users
(
 UserId int NOT NULL IDENTITY,
 EmailAddress VARCHAR(250)   NOT NULL  UNIQUE,
 Password varchar(60) NOT NULL,
 Fname   varchar(50) NOT NULL,
 Lname   varchar(50) NOT NULL,
 PRIMARY KEY (UserId)
);
GO

DROP TABLE IF EXISTS Recipe;
GO
CREATE TABLE Recipe
(
 RecipeId      int NOT NULL IDENTITY,
 RecipeName    varchar(250) NOT NULL,
 UserId        int NOT NULL,
 RecipeImageId int NULL,
 Instructions varchar(800) NOT NULL,
 RecipeDescription   varchar(250) NULL,
 PRIMARY KEY (RecipeId),
 FOREIGN KEY (UserID) REFERENCES Users(UserID),
 FOREIGN KEY (RecipeImageId) REFERENCES RecipeImage (RecipeImageId),
);
GO

DROP TABLE IF EXISTS RecipeIngredient;
GO
CREATE TABLE RecipeIngredient
(
 RecipeId     int NOT NULL,
 IngredientId int NOT NULL,
 MeasureId    int NOT NULL,
 Quantity     decimal(3,1) NOT NULL,
 PRIMARY KEY (RecipeId, IngredientId),
 FOREIGN KEY (RecipeId) REFERENCES Recipe(RecipeID),
 FOREIGN KEY (IngredientID) REFERENCES Ingredient(IngredientID),
 FOREIGN KEY (MeasureID) REFERENCES Measure(MeasureID),
);
GO

DROP TABLE IF EXISTS Review;
GO
CREATE TABLE Review
(
 ReviewId     int NOT NULL IDENTITY,
 UserId       int NOT NULL,
 RecipeId       int NOT NULL,
 ReviewImageId int NULL,
 Rating        int NOT NULL,
 ReviewDescription   varchar(250) NULL DEFAULT 'Description not provided',
 PRIMARY KEY (ReviewId),
 FOREIGN KEY (UserID) REFERENCES Users(UserID),
 FOREIGN KEY (RecipeId) REFERENCES Recipe(RecipeId),
 FOREIGN KEY (ReviewImageId) REFERENCES ReviewImage(ReviewImageID)
);
GO

DELETE FROM RecipeIngredient;
DELETE FROM Measure;
DBCC CHECKIDENT ('Measure', RESEED, 1);
DELETE FROM Ingredient;
DBCC CHECKIDENT ('Ingredient', RESEED, 1);
DELETE FROM Review;
DBCC CHECKIDENT ('Review', RESEED, 1);
DELETE FROM ReviewImage;
DBCC CHECKIDENT ('ReviewImage', RESEED, 1);
DELETE FROM Recipe;
DBCC CHECKIDENT ('Recipe', RESEED, 1);
DELETE FROM RecipeImage;
DBCC CHECKIDENT ('RecipeImage', RESEED, 1);
DELETE FROM Users; 
DBCC CHECKIDENT ('Users', RESEED, 1);
GO


Insert Into Users (EmailAddress, Password, Fname, Lname) VALUES
('johnpaul@gmail.com','c44321e51ec184a2f739318639cec426de774451', 'John', 'Paul'),
('peterd@yahoo.com','d9e03c0b34c57d034edda004ec8bae5d53667e36','Peter', 'Doe'),
('nigelu@gmail.com','13ef4f968693bda97a898ece497da087b182808e','Nigel','Uno'),
('samanthar@outlook.com','2a367cbb171d78d293f40fd7d1defb31e3fb1728','Samantha','Reed'),
('conninef@army.gov','2e203dd22e39e3a8930e7641fe074fec2b18b102','Connie','Fry'),
('tiltoneric123@yahoo.com', 'abc123', 'Eric', 'Tilton'),
('miltonderek123@yahoo.com', 'cba123', 'Derek', 'Milton'),
('HenryHe123@yahoo.com', 'aba123', 'Henry', 'He'),
('LisaLampanelli233@yahoo.com', 'abb123', 'Lisa', 'Lampenelli'),
('JimothyDandelions@yahoo.com', 'abracadabra1430', 'Jimothy', 'Dandelions'),
('JerryMathers@AOL.com', 'hotdogs1430', 'Jerry', 'Mathers'),
('JebediahJohnson@gmail.com', 'spaghettios1490', 'Jebediah', 'Johnson'),
('BillBrunson@MSN.com', 'I<3Cheerios2022', 'Bill', 'Brunson'),
('TonyHawk@washburn.edu', 'Tacobell426', 'Tony', 'Hawk'),
('RichardSimmons@yahoo.com', 'PizzahutTastesBad', 'Richard', 'Simmons'),
('TonyLittle@hotmail.com', 'wawewewa', 'Tony', 'Little'),
('BobSanders@AOL.com', 'ImImportant', 'Bob', 'Sanders'),
('ScoobaSteve@hotmail.com', 'ScoobieDoo', 'Scooba', 'Steve'),
('JimmyFallon@yahoo.com', 'Quadingle1212', 'Jimmy', 'Fallon'),
('MeganFox@gmail.com', 'imapassword3456', 'Megan', 'Fox'),
('SylvesterStallone@AOL.com', 'imapassword1212', 'Syllvestar', 'Stalone'),
('JimmyDean@gmail.com', 'spaghetti125', 'Jimmy', 'Dean'),
('PringlesMan@yahoo.com', 'pringlescan125', 'Pringles', 'Man'),
('WaffleGuy@gmail.com', 'spaghettiandMeatballs', 'Waffle', 'Guy'),
('BigChungus@AOL.com', 'chonk123', 'Big', 'Chungus');
GO

Insert Into RecipeImage(Image) VALUES
('https://www.realgoodeats.ca/wp-content/uploads/2021/01/IMG_1940-2-1536x1536.jpg%27'),
('https://www.realgoodeats.ca/wp-content/uploads/2021/01/IMG_3482.jpg%27'),
('https://www.realgoodeats.ca/wp-content/uploads/2021/01/IMG_3484-1536x1536.jpg%27'),
('https://www.realgoodeats.ca/wp-content/uploads/2021/01/IMG_3486-2048x2048.jpg%27'),
('https://www.realgoodeats.ca/wp-content/uploads/2021/01/IMG_3525-1536x1536.jpg%27'),
('https://www.simplyrecipes.com/thmb/OWUkFeVVamklb8vgws8dsZNpqSE=/648x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2006__09__italian-sausage-spaghetti-vertical-a-600-99e37d17b2414899a3e47209b0bc302c.jpg'),
('https://www.simplyrecipes.com/thmb/4HCiPh-Cu6kOhNAqhakAPosR5N4=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2019__01__Greek-Meat-Loaf-LEAD-2-a41c7ba64e194ca5b7604f4f3789ba49.jpg'),
('https://www.simplyrecipes.com/thmb/lrjdGdFlnJf0JZI7Gxo6c99mB30=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2020__04__Jamaican-Banana-Bread-LEAD-12-6e203c2816c04e20a5dc150b606f6076.jpg'),
('https://food.fnr.sndimg.com/content/dam/images/food/fullset/2016/5/13/0/RX-Kings-Hawaiian_Hot-Dog_s4x3.jpg.rend.hgtvcom.476.357.suffix/1463412296820.jpeg'),
('https://www.simplyrecipes.com/thmb/yFCPrYxm2wjFVP2PssBE6gRgFxg=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/Simply-Recipes-Easy-Shepherds-Pie-Lead-2_SERP-fdf8883477354e85bd05f9243f71657f.jpg'),
('https://www.simplyrecipes.com/thmb/9m92ffSIp2vTGm3qO3LRhvrsOA4=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2019__04__breakfast_tacos_HERO0004-828cb9a900964d8a94d1f6523f7a8e28.jpg'),
('https://www.simplyrecipes.com/thmb/ytUB4Lvgh95i8tbyG3_omlSUzdo=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2018__04__Buttermilk-Pancakes-LEAD-HORIZONTAL-3d2fb19ce0474da0b4c7aaccf8e74c40.jpg'),
('https://www.simplyrecipes.com/thmb/RcDM1uXNKGrlTQUIKm8kSdUT1JQ=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/Simply-Recipes-Piri-Piri-Fried-Chicken-LEAD-02-641ceae81d724eeab1e29453a42c76a7.jpg'),
('https://food.fnr.sndimg.com/content/dam/images/food/fullset/2007/11/12/0/NL0205_Cocktail_Sausages.jpg.rend.hgtvcom.476.357.suffix/1371585719382.jpeg'),
('https://www.simplyrecipes.com/thmb/y30K18xEo0k1DbeLLwLfF6n7Y4M=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2014__10__applesauce-horiz-a2-2000-a8aa904f5f3f4cffad9900be2bd5fbc0.jpg'),
('https://www.simplyrecipes.com/thmb/HtCMYuufZjs1O0bu0vxXXYQ1taw=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2019__03__Skillet-Chicken-Parmesan-LEAD-4-1d0ce28fb7aa4ce89aef5bebbfe36127.jpg'),
('https://www.simplyrecipes.com/thmb/qfBB_eDhxc6kdtUGw4oQo8fSjg4=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2011__09__mushroom-sugo-horiz-a-1800-1b7c42c68700437b9d744fab2252adda.jpg'),
('https://food.fnr.sndimg.com/content/dam/images/food/fullset/2015/12/4/0/FN_new-york-city-bagels-absolute-bagels_s4x3.jpg.rend.hgtvcom.476.357.suffix/1449264195076.jpeg'),
('https://www.simplyrecipes.com/thmb/9PNp8HLrWTUZA5gAYfM5lOJ8PAs=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2015__02__roast-beef-tenderloin-horiz-a-1600-111d1f3cfc2a4a919e0c86288e1d7834.jpg'), 
('https://www.simplyrecipes.com/thmb/pzVeAOcV1e11lvK6_teWASigT74=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2020__04__Vegetable-Lo-Mein-LEAD-2-7b9046b220284ccabc4f85e637966256.jpg'),
('https://food.fnr.sndimg.com/content/dam/images/food/fullset/2019/9/3/0/FNK_the-best-chicken-tikka-masala_H_s4x3.jpg.rend.hgtvcom.826.620.suffix/1567523604572.jpeg'), 
('https://www.simplyrecipes.com/thmb/9suNGL_fQ1YofA1sIlP0h_fLsNw=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2019__06__Vegetarian_Pad_Thai_Tofu00009-53e2bcce8cd04e72a903da880dfbbd93.jpg'), 
('https://www.simplyrecipes.com/thmb/xobdmb250a11FMIA8AZhWOtjvp0=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/Simply-Recipes-Glazed-Baked-Ham-METHOD-8-79a7a49770974631a0ce7820059a70d8.jpg'),
('https://www.simplyrecipes.com/thmb/L3Yb8lVRQUzwBQ1HKkduAaj8-5I=/390x260/filters:max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2016__09__Buttermilk-Waffles-horiz-a-2000-44a7abeb997c4b549d92576c3043bac7.jpg'), 
('https://food.fnr.sndimg.com/content/dam/images/food/fullset/2016/2/5/1/CCTIF0209_Corn-Dogs_s4x3.jpg.rend.hgtvcom.476.357.suffix/1458681679446.jpeg');
GO

Insert Into Recipe(RecipeName, UserId, RecipeImageId, Instructions, RecipeDescription) VALUES
('SHEET PAN GARLIC SHRIMP AND KALE', 3, 1, 'Throw a pan, garlic, and kale at some shrimp', 'Makes Kale actually edible.'),
('ONE PAN BAKED CHICKEN, SWEET POTATO, AND CAULIFLOWER', 4, 2, 'Feed your chicken some sweet potatos and cauliflower, bake it.', 'Tastes like chicken.'),
('ROASTED SWEET POTATO KALE SALAD WITH GRILLED CHICKEN', 5, 3, 'Find a sweet potato, make fun of it until fully roasted. Repeat for chicken and cauliflower', 'Nothing like a good roast'),
('SHEET PAN SWEET POTATO, CHICKEN AND CAULIFLOWER BAKE', 2, 4, 'Give your chicken a good ol slap, throw cauliflower in trash, cover in sweet potato', 'No one likes cauliflower'),
('GARLIC FRIED RICE WITH SHRIMP', 3, 5, 'Go to Panda Express. Order it.', 'Cooking is alot of work.'),
('Spaghetti&Meatballs', 1,1,'A delicious pasta', 'slap your spaghetti'),
('MeatLoaf', 2,2,'A loaf of meat', 'beat the meat into a loaf. Let set on back porch for 2 days.'),
('Banana Bread',3,3,'A banana that gets bread', 'Throw the banana as hard as you can at some bread. yell at it.'),
('Hotdog Juice',4,4,'Stay Hydrated', 'Mash up hotdog. collect juice. Give to your kid at a Soccer game'),
('Sheppards Pie', 5,5,'Made of 100% real sheppard', 'Find a Shepard, ask him to be in your pie'),
('Tacos',6,6, 'yum', 'Go to tacobell and ask for the party pack ask if they like to party'),
('Pancakes',7,7, 'A delicious recipe', 'Go to walmart, buy a cake, hit it with a pan. Enjoy'),
('Fried Chicken',8,8, 'Can be substituted with pidgeon', 'Steal your neighbors dog, hold him for ransome until neighbor comes back with KFC'),
('Lil Smokies',9,9, 'Smoke thats lil', 'Set your house on fire, collect smoke, turn the smoke into a mumble rapper, Hope you have homeowners insurance'),
('AppleSauce',10,10, 'Youve heard of the applejuice,now here comes the sauce', 'Throw away your apples, buy some highly concentrated sour apple candy, chew it, spit it into a bowl. Enjoy.'),
('Chicken Parmesan',11,11, 'A parmesaned Chicken', 'Bring your live chicken to olive garden. Ask the waiter for more cheese. Have them grate cheese on the chicken until its covered'),
('Ravioli',12,12, 'Ravioli Ravioli whats in the pocketoli?', 'Open a can of chef boyardee. Place raviolis in pocket for consumption at a later time'),
('BagelwithCreamcheese',13,13, 'A bagel with Creamcheese', 'Take a bagel and submerse it in a pool of creamcheese'),
('Roast Beef',14,14, 'A roasted cow', 'Find a cow, make fun of it until fully roasted'),
('Lo Mein',15,15, 'Noodles and stuff', 'Take a Wok, put it on your head, get a pan, throw unpackaged ramen noodles at it'),
('Chicken Tika Masala',16,16, 'Indian Chicken that tastes good', 'Listen to Bollywood music while, gently petting an uncooked chicken'),
('Phad tai',17,17, 'A tasty thai dish', 'Meet a guy named phad, ask him if hes thai'),
('Honey Ham',18,18, 'A ham thats honeyed', 'Throw one whole ham at a beehive, Fight bees with a stick'),
('Waffles',19,19, 'A pancake with squares', 'I dont know buy some Eggo Waffles or something'),
('Corndog',20,20, 'Corn of dog', 'Find a dog, tell it its corny');
GO

Insert Into ReviewImage VALUES
(DEFAULT),
('https://st.depositphotos.com/1771835/2035/i/600/depositphotos_20355973-stock-photo-portrait-real-high-definition-grey.jpg%27'),
('https://images.squarespace-cdn.com/content/v1/5a5f81d812abd9f0929541c8/1517777313099-EA1WR174E4GWVO7O5IFL/DSC_8257-reduced.jpg'),
('https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500%27'),
('https://images.squarespace-cdn.com/content/v1/54c6eb0ce4b0f6cdd67c1196/1642223720668-I2XL35T6SMPTDZPOTRFJ/DCP_0085.jpg'),
('https://static.showit.co/800/nJ8gn_r6QyG3O5dOdoT3HQ/68020/professional_headshots_photographer_charleston_sc-king-and-fields-studios.jpg'),
('https://kpstudios.com/wp-content/uploads/2022/02/professional-headshots_kpstudios03-1024x1024.jpg'),
('https://www.minneapolisheadshots.com/gallery/main/professional-woman1.jpg'),
('https://tracywrightcorvo.com/wp-content/uploads/2018/01/cindy_ramirez-115r.jpg'),
('https://fritzphoto.com/wp-content/uploads/2013/02/07-5648-pp_gallery/Headshots-Portland-12.jpg'),
('https://www.thecharlestonphotographer.com/wp-content/uploads/2015/02/professional-business-portrait-photography-by-charleston-headshot-photographers-king-street-studios-21.jpg'),
('https://image5.photobiz.com/8905/25_20210715205810_9575726_large.jpg'),
('https://garybarragan.com/wp-content/uploads/2018/10/Tyler-Weakley-0105-Actors-Headshots-Louisville-Photographer-Gary-Barragan.jpg'),
('https://uploads-ssl.webflow.com/60880df421cb956ecba65aa6/60e3285c31d7a883c1e69b1c_AmyRader-WEB-1.jpg'),
('https://headshots-inc.com/wp-content/uploads/2020/11/Professional-Headshot-Poses-Blog-Post-7.jpg'),
('https://josephanzalone.com/images/p35.jpg'),
('https://static.wixstatic.com/media/7fa9fc_f6c1050d7c44440fa0c20eb7c65c5749~mv2.jpg/v1/fit/w_483,h_362,q_90/7fa9fc_f6c1050d7c44440fa0c20eb7c65c5749~mv2.jpg'),
('https://images.squarespace-cdn.com/content/v1/5cfb0f8783523500013c5639/2f93ecab-2aaa-4b12-af29-d0cb0eb2e368/vancouver-headshot-photographer-3912.jpg'), 
('https://www.bethesdaheadshots.com/wp-content/uploads/2018/12/Temeka_800x1000.jpg'),
('https://www.unh.edu/unhtoday/sites/default/files/styles/article_huge/public/article/2019/professional_woman_headshot.jpg?itok=3itzxHXh'), 
('https://images.squarespace-cdn.com/content/v1/6001a095571ff86fe2af7eb1/1610719437242-66NSQUIBXZ92FAO4THKV/corporate-headshots-miami-pricing.jpg'), 
('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPZ-k2zSnFZ2rdALY16tLkwbmIani143FKC2z47Tvn8aBwdSa3LBJYVccTSqRMEfWxY&usqp=CAU'),
('https://esquirephotos.com/wp-content/uploads/2020/03/5047.jpg'), 
('https://geeks.eku.edu/sites/geeks.eku.edu/files/images/lingjie_cai.jpg');
GO

Insert Into Review Values
(2, 4, 5, 5, 'Wow! This dish was great and easy to make!'),
(3, 2, 1, 5, 'My family loved this meal! I will be serving this again!'),
(4, 3, 3, 4, 'A pretty good dish overall! I would probably use something else for the garnish though.'),
(1, 1, 4, 2, 'I ended up with a metal screw mixed in with my shrimp! A genuinely awful recipe!'),
(1, 5, 4, 1, 'Nigel hit my dog when I was 12 years old.'),
(6, 6, 6, 3,'I slapped my Spaghetti and it didnt do anything'),
(7, 7, 7, 1,'My dog ate it'),
(8,8,8,2,'My neighbor called the cops over a noise complaint'),
(9,9,9,5,'My kid loved it.'),
(10,10,10,4,'I found a sheppard, He agreed to be in my pie.'),
(11,11,11,4,'The people at TacoBell do in fact not like to party.'),
(12,12,12,3,'Tasted great but left a huge mess in my car'),
(13,13,13,1,'I was arrested'),
(14,14,14,5,'Checkout my lil smokies soundcloud @LilSausage'),
(15,15,15,2,'I got a bad cavity'),
(16,16,16,3, 'My waiter got carpal tunnel syndrome'),
(17,17,17,5, 'I usually eat my ravioli out in public. it fits well in my breast pocket.'),
(18,18,18,4, 'It was good'),
(19,19,19,2, 'My cow got depressed'),
(20,20,20,1, 'Left a big mess in my house'),
(21,21,21,3, 'Not a fan of bollywood music'),
(22,22,22,1, 'I cant find anyone named phad'),
(23,23,23,1, 'The bees messed me up pretty bad, had to go to the ER'),
(24,24,24,5, 'Leggo my Eggo'),
(25,25,1,5, 'Told a dog its corny but Im still hungry');
GO


Insert Into Ingredient (IngredientName) VALUES
('Boneless Skinless Chicken Breast'),
('Shrimp'),
('Cauliflower'),
('Kale'),
('Bell Pepper'),
('Rice'),
('Sweet Potatoes'),
('Garlic'),
('Italian Seasoning'),
('Dried Cranberries'),
('Lemon Juice'),
('Olive Oil'),
('Tomato Sauce'),
('Onion'),
('Carrot'),
('Potato'),
('Celery'),
('Beef stock'),
('Chicken Stock'),
('Apple'),
('Italian Sausage'),
('Salt'),
('Pepper'),
('Noodles'),
('Bagel'),
('Ground Beef'), 
('Steak'), 
('Ham'),
('Bread Crumbs'), 
('Oregano'),
('Spinch');
GO
--(15,'Bell Pepper'),(16,'Rice'), 

Insert Into Measure (Measurement) VALUES
(''),
('Cloves'),
('Clove'),
('Medium'),
('Bunch'),
('Cups'),
('Cup'),
('1/2 Cup'),
('1/3 Cup'),
('1/4 Cup'),
('LB'),
('TBSP'),
('1/2 TBSP'),
('1/3 TBSP'),
('1/4 TBSP'),
('TSP'),
('1/2 TSP'),
('1/3 TSP'),
('1/4 TSP'),
('OZ'),
('1/2OZ'),
('FL OZ'),
('Leaves'),
('Sprigs'),
('KG'),
('G');
GO

Insert Into RecipeIngredient(RecipeId, IngredientId, MeasureId, Quantity) VALUES
(1, 2, 1, 1),
(1, 4, 2, 8),
(1, 12, 3, 0.33),
(1, 9, 5, 2),
(1, 11, 4, 1),
(1, 8, 6, 4),
(1, 6, 2, 2),
(2, 1, 1, 1),
(2, 7, 8, 2),
(2, 3, 2, 4),
(2, 12, 4, 1),
(2, 8, 6, 3),
(2, 9, 4, 1),
(3, 7, 8, 2),
(3, 5, 10, 1),
(3, 3, 2, 2),
(3, 4, 9, 1), 
(3, 10, 3, 0.25),
(3, 1, 1, 1),
(3, 9, 4, 2),
(3, 12, 3, 0.5),
(3, 11, 3, 0.5),
(3, 8, 7, 1),
(4, 1, 1, 1),
(4, 7, 8, 1),
(4, 3, 2, 4),
(4, 5, 10, 1),
(4, 8, 6, 2),
(4, 9, 5, 2),
(4, 10, 3, 0.25),
(4, 12, 4, 3),
(5, 12, 4, 3),
(5, 2, 1, 1),
(5, 8, 6, 6),
(5, 4, 2, 8),
(5, 6, 2, 2),
(5, 11, 4, 1),

(6,13,6,14),
(7,14,8,26.5),
(8,15,9,18.9),
(9,16,10,48),
(10,17,11,16),
(11,18,12,19),
(12,19,13,28),
(13,20,14,39),
(14,21,15,28.28),
(15,22,16,16.9),
(16,23,17,14.7),
(17,24,18,78),
(18,25,19,60),
(19,26,20,48),
(20,27,22,27),
(21,28,23,32),
(22,29,24,43),
(23,30,25,62.5),
(24,20,26,15.9),
(25,15,21,16.7);


GO

select * from RecipeIngredient;
select * from Ingredient;
select * from Measure;
select * from RecipeImage
select * from ReviewImage;
select * from Users;
select * from Recipe;
select * from Review;
--table structures
exec sp_help;
GO
exec sp_help Ingredient;
GO
exec sp_help Measure;
GO
exec sp_help RecipeImage;
GO
exec sp_help ReviewImage;
GO
exec sp_help Users;
GO
exec sp_help Recipe;
GO
exec sp_help RecipeIngredient;
GO
exec sp_help Review;
GO

