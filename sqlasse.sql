
CREATE DATABASE library;
USE library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
(1, 101, '123 Main St', '123-456-7890'),
(2, 102, '456 Oak Ave', '234-567-8901'),
(3, 103, '789 Pine Rd', '345-678-9012');
select * from Branch;

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
(101, 'deepu', 'Manager', 75000, 1),
(102, 'abin', 'Manager', 72000, 2),
(103, 'asok', 'Manager', 71000, 3),
(104, 'nancy', 'Staff', 50000, 1),
(105, 'aswethy', 'Staff', 48000, 2),
(106, 'zainaba', 'Staff', 45000, 3);
select  * from Employee;

CREATE TABLE Books (
    ISBN VARCHAR(50)primary key,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3) CHECK (Status IN ('yes', 'no')),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
('978-3-16-148410-0', 'Introduction to Algorithms', 'Computer Science', 35.00, 'yes', 'Thomas H. Cormen', 'MIT Press'),
('978-0-12-374856-0', 'Artificial Intelligence', 'Computer Science', 45.00, 'yes', 'Stuart Russell', 'Pearson'),
('978-0-321-57351-3', 'Design Patterns', 'Software Engineering', 30.00, 'no', 'Erich Gamma', 'Addison-Wesley'),
('978-1-56619-909-4', 'The Art of Computer Programming', 'Computer Science', 55.00, 'yes', 'Donald Knuth', 'Addison-Wesley'),
('978-0-7432-7356-5', 'A Brief History of Time', 'History', 20.00, 'no', 'Stephen Hawking', 'Bantam'),
('978-0-452-28423-4', 'The History of the Ancient World', 'History', 25.00, 'yes', 'Susan Wise Bauer', 'W.W. Norton & Company');
select * from Books;
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(1, 'John Doe', '789 Elm St', '2021-05-15'),
(2, 'Jane Smith', '456 Maple Ave', '2021-12-20'),
(3, 'Sam Brown', '123 Pine Rd', '2022-01-10'),
(4, 'Emily Davis', '321 Cedar Blvd', '2023-03-25');
select * from Customer;

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(130),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(1, 1, 'Introduction to Algorithms', '2023-06-05', '978-3-16-148410-0'),
(2, 2, 'Artificial Intelligence', '2023-06-15', '978-0-12-374856-0'),
(3, 4, 'The History of the Ancient World', '2023-06-20', '978-0-452-28423-4');

select * from IssueStatus;

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(130),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(1, 1, 'Introduction to Algorithms', '2023-06-25', '978-3-16-148410-0'),
(2, 2, 'Artificial Intelligence', '2023-06-30', '978-0-12-374856-0');
select * from ReturnStatus;

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

SELECT Customer_name
FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

SELECT Employee.Emp_name, Branch.Branch_address
FROM Employee
JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;

SELECT DISTINCT Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Books.Rental_Price > 25;
