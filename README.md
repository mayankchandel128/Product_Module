# Product_Module

For consuming apis need to consume db structure which I have created to import into system
and then need to change configuration setting of the application. so in Web.config file there is connectionstring using that we can change connection.

Need to unzip WebApplication3 and packages after checkout.

There is four Api as per requirement

1. GetPageWiseList it will take parameter as pageSize, pageNo and we will get list of product using pagination.

2. AddInventory It will take parameter as Name, Description, Price, CreatedDate, UpdatedDate  and it will store information into d.

3. UpdateInventory It will take same parameter which you want to update, change the value of that particular param. be ansure need to pass pkProduct id of that product you want to change.

4. DeleteInventory It will take pkProduct as param and then it will delete the entry.
***Note - for performing any operation firstly need to execute script first which is attached with code****
