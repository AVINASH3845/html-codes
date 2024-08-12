CREATE TABLE DimAuthor (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR2(255)
);

CREATE TABLE DimPublisher (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR2(255)
);

CREATE TABLE DimLanguage (
    LanguageID INT PRIMARY KEY,
    LanguageCode VARCHAR2(10),
    LanguageName VARCHAR2(50)
);

CREATE TABLE DimTime(
    DateID INT PRIMARY KEY,
    FullDate DATE,
    Day INT,
    Month INT,
    Year INT
);

CREATE TABLE DimBook (
    BookID INT PRIMARY KEY,
    Title VARCHAR2(255),
    AuthorID INT,
    PublisherID INT,
    ISBN VARCHAR2(20),
    ISBN13 VARCHAR2(20),
    LanguageID INT,
    NumPages INT,
    PublicationDateID INT,
    FOREIGN KEY (AuthorID) REFERENCES DimAuthor(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES DimPublisher(PublisherID),
    FOREIGN KEY (LanguageID) REFERENCES DimLanguage(LanguageID),
    FOREIGN KEY (PublicationDateID) REFERENCES DimTime(DateID)
);


CREATE TABLE DimRatings (
    RatingID INT PRIMARY KEY,
    BookID INT,
    AverageRating NUMBER(3,2),
    RatingsCount INT,
    TextReviewsCount INT,
    FOREIGN KEY (BookID) REFERENCES DimBook(BookID)
);

CREATE TABLE FactBookTransactions (
    TransactionID INT PRIMARY KEY,
    BookID INT,
    DateID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES DimBook(BookID),
    FOREIGN KEY (DateID) REFERENCES DimTime(DateID)
);


