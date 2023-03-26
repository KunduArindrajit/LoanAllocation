# LoanAllocation
Solution to the Loan Allocation Coding Challenge (https://gist.github.com/FrankKair/40631f210e17ef6819709ed916e2aafe)

This solution encompasses both the default and extended scenarios.
It consisits of three classes
Loan class to contain records of each loan
It should contain the id of the loan, the category of the loan(eg: property, retail or medical) and the risk grade of the loan(ed: A+ - E)
Investor class to contain details about each investor
It should contain name of investor, available funds to invest, criteria of loans which the they want to invest in and available_category which specifies the amount available for each specific category to invest.
The criteria property is a hash which containing the keys category and grade specifing the categories the investor wan't to invest in. If any of the keys is blank, it means the investor has no specific prefernce and is willing to invest in any category or grade.
The grade should have an array of loan grades which the investor is willing to invest .
The category should be an array of hashes of loan categories which the investor is willing to invest in. It contains name property of the category and an optional percentage if there is any limit on percent of total funds the investor can invest in a particular property. It's assumbed to be 100% if not specified.
LoanAllocator class to take as input an array of loans and investors and calucalte which investor should be assigned to which loan.
It has a method allocate_loans for that purpose which returns a hash of all investors along with ids of the loans they invested in.

Areas to improve:
This is a rudimentary solution and can be improved in the following ways.
1. The input format can be more user friendly as currently creating the objects, specifically the investor object with specified criteria including the category interested in and percentage of fund willing to invest in is a bit complicated.
2. Should contain more validations to check for the proper input type and raise appropriate errors.
3. Follow proper OOP principles and refactor some code as some functionaly is done in the Investor class which should ideally be done in the LoanAllocator class.



