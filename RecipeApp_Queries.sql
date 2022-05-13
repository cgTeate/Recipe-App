use master;
use RecipeApp;

 /* 6.	Show the first name, last name, and email of all users who have a D in their name.
*/
select lname, fname, EmailAddress
from Users
where fname like '%D%';
GO
--select the ingredients that have 'a' in the name
select * 
from Ingredient 
where IngredientName like '%a%';
GO
--update user to have no Lname
update Users
set LName = ''
where UserID = 1;

--updates ingredients
update Ingredient
set IngredientName = 'Spinach'
where IngredientId = 32;
GO
--change users first and last name
Update Users
Set Fname=  'La', Lname = 'Cucuracha'
where UserID =1;
GO
--delete ingredient 5
delete 
from Ingredient
where IngredientName = 'Spinach';
GO
--delete review id 5
delete 
from Review
where Reviewid = 5;
GO

 /* 5.	Write a DELETE statement that deletes the Review that corresponds to your own email. This statement should use the UserId column to identify the row.
*/

DELETE FROM Review 
WHERE
    UserId = (select UserId from Users where EmailAddress='BigChungus@AOL.com');

	/* 1.	SELECT statement that returns one row for each Ingredient that has the highest quantitities needed in order:
*/
SELECT I.IngredientName, MAX(RI.Quantity) AS
    Quantity
    FROM Ingredient I, RecipeIngredient RI
    WHERE I.IngredientId=RI.IngredientId
    GROUP BY I.IngredientName ORDER BY Quantity desc;
GO
/* 2.	two SQL statements coded as a transaction to delete the row 
with a User ID of 8 from the Users table. To do this, you must first delete all reviews
for that User from the Review table.
If these statements execute successfully, commit the changes. Otherwise, roll back the changes.
*/

BEGIN TRAN;
BEGIN TRY
    DELETE FROM Review
WHERE UserId = 8;

DELETE FROM Users
WHERE UserId = 8;

    COMMIT TRAN;
END TRY
BEGIN CATCH
     ROLLBACK TRAN;
END CATCH
GO

/* 4.	Write an ALTER TABLE statement that modifies the Users table so the FirstName column cannot store null values and can store a maximum of 20 characters.
*/

alter table Users
alter column FName varchar(60);
GO


--select the recipes that have a review rating above 4
Select R.RecipeId, RecipeName
from Recipe as R
	JOIN Review as Rvw ON R.RecipeId = Rvw.RecipeId
where Rvw.Rating >4
order by Rvw.Rating desc;
GO

--select the recipes that have the ingredient 'Shrimp' 

	Select R.RecipeId, R.RecipeName
from Recipe as R
where R.RecipeId IN 
		(select RI.RecipeId
		from RecipeIngredient as RI
		where RI.IngredientId IN
			(select I.IngredientId
			from Ingredient as I
			where I.IngredientName ='Shrimp'))
order by R.RecipeName;
GO


--select the users that have posted a recipe and a review (19 records)
select U.UserId, U.EmailAddress, U.Fname, U.Lname 
	from Users as U 
		 JOIN Recipe as R ON U.UserId = R.UserId
		 JOIN Review as Rvw ON U.UserId = Rvw.UserId
		group by U.UserId, U.EmailAddress, U.Fname, U.Lname
		having count(Rvw.UserId) > 0 and count(R.UserID) > 0
	Order by Fname, LName;
GO

--select the users that have posted a review (24 records)
select U.UserId, U.EmailAddress, U.Fname, U.Lname 
	from Users as U 
	 JOIN Review as Rvw ON U.UserId = Rvw.UserId
		group by U.UserId, U.EmailAddress, U.Fname, U.Lname
		having count(Rvw.UserId) > 0
	Order by Fname, LName;
GO

--VIEWS
--create view showing all recipes that have review info
IF OBJECT_ID('RecipeReview_View') IS NOT NULL
	DROP VIEW RecipeReview_View;
GO

CREATE VIEW RecipeReview_View
as
	select R.RecipeId,R.RecipeName, R.UserId, R.Instructions, R.RecipeDescription, Rvw.ReviewDescription, Rvw.Rating
	from Recipe as R
		JOIN Review as Rvw ON R.RecipeId = Rvw.RecipeId;
GO

select * from RecipeReview_View;
GO

--view that gives back the top 10 users in descending order by Lname
IF OBJECT_ID('TopUsers') IS NOT NULL
	DROP VIEW TopUsers;
GO

CREATE VIEW TopUsers
AS
SELECT TOP 10 UserId, FName + ' ' + LName As FullName 
FROM Users
ORDER BY Lname DESC;

GO

select * from TopUsers;
Go

--This can only be accessed by an Employee, so that passwords stay safe. We can access this to see everyone's data just in case.
IF OBJECT_ID('AllCustomers') IS NOT NULL
	DROP VIEW AllCustomers;
GO

CREATE VIEW AllCustomers
AS
SELECT FName + ' ' + LName as FullName, EmailAddress, password
FROM Users
GO

select *
from AllCustomers;


--TRIGGERS
/* TRIGGER named ReviewDesc_UPDATE that checks the new value for the ReviewDescription column of the 
Review table. This trigger should raise an appropriate error if the Length of ReviewDescription is greater than
250 characters.  If the new ReviewDescription length is less than 251 characters or null, this trigger should modify the new
ReviewDescription by inserting it.
*/
--TRIGGER
GO
CREATE or ALTER TRIGGER ReviewDesc_UPDATE
	ON Review
	AFTER UPDATE
AS
	DECLARE @ReviewDescription varchar(250)
	DECLARE @ReviewId int
BEGIN
	SELECT @ReviewId = ReviewId, @ReviewDescription = ReviewDescription FROM inserted
	IF LEN(@ReviewDescription) < 251 or LEN(@ReviewDescription) IS NULL
		UPDATE Review
			SET ReviewDescription = @ReviewDescription WHERE Reviewid = @ReviewId
		BEGIN
			PRINT 'Review Description must be less than 251 characters';
		ROLLBACK TRAN
		END;
END;

GO

--For testing the trigger
UPDATE Review SET ReviewDescription = 'Far far away, behind the word mountains, 
								far from the countries Vokalia and Consonantia, 
								there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, 
								a large language ocean. A '
where ReviewId = 4;
GO

UPDATE Review SET ReviewDescription = 'Not Good'
where ReviewId = 4;
GO

select * from Review;
GO

--test the length of a description
select LEN('Far far away, behind the word mountains, 
far from the countries Vokalia and Consonantia, 
there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, 
a large language ocean. A ');

GO
--FUNCTIONS
--get full name of the users

CREATE or ALTER FUNCTION fn_GetFullName
(  
 @fname varchar(50),    
 @lname varchar(50)  
)  
returns varchar(100)  
as  
begin  
 declare @fullName varchar(100)  
 begin  
  set @fullName=@fname+' '+@lname  
 end  
 return @fullName  
end  
GO

select dbo.fn_GetFullName(fname,lname) as FullName
from Users;


-----------------------------------------------------------------------------------------------------------#

GO
--get the fullRecipe info
CREATE or ALTER FUNCTION fn_GetFullRecipe
(  
 @recipeName varchar(250),    
 @instructions varchar(800),  
 @description varchar(250)
)  
returns nvarchar(1200)  
as  
begin  
 declare @recipePage nvarchar(1500)  
 begin  
  set @recipePage='Recipe: '+ @recipeName+' Description: '+@description+ ' Instructions: '+ @instructions  
 end  
 return @recipePage  
end  
GO

select dbo.fn_GetFullRecipe(RecipeName,Instructions,RecipeDescription) as FullRecipe
from Recipe;

GO
--STORED PROCEDURE

--stored procedure to add new user, checks to see if the Fname or Lname is null
--The sign function is If number > 0, it returns 1.
--If number = 0, it returns 0.
--If number < 0, it returns -1.
create or alter procedure sp_InsertUser


@EmailAddress varchar(250),

@Password varchar(60),

@Fname varchar(50),

@Lname varchar(50)

AS

BEGIN

       if (SIGN(@Fname) = null )
       begin
       print 'User has no first name!.'
       end
       else if ( SIGN(@Lname) = null)
       begin
       print 'User has no last name!'
       end
       Else
       begin
    Insert into Users(EmailAddress, Password,Fname,Lname)
   Values(@EmailAddress,@Password,@Fname, @Lname)
   end
End;
GO


exec sp_InsertUser 'DerekMilton@yahoo.com', 'Spaghetti123', 'Derek', 'Milton'
Go
select * from Users;
Go
-----------------------------------------------------------------------------------------------------------#


--stored procedure to add a new measurement, checks to see if the measurement is null
create or alter procedure sp_InsertMeasure

@Measurement varchar(250)



AS
BEGIN
       if ( SIGN(@Measurement) = null )
			begin
				print 'No Measurement provided!'
			end
       Else
       begin
    Insert into Measure(Measurement)
   Values(@Measurement)
   end
End;
GO


exec sp_InsertMeasure '1/2 lb';
GO

select * from Measure;
Go

