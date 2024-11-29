CREATE SCHEMA initium;

CREATE TABLE initium.users(
    id INT IDENTITY(1,1) PRIMARY KEY,
    firstname VARCHAR(255) NOT NULL, 
    lastname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    active BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE initium.activation_codes(
    id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    code INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    expired_at DATETIME DEFAULT DATEADD(DAY, 2, GETDATE()),
    CONSTRAINT FK_activation_codes_email FOREIGN KEY (email) REFERENCES initium.users(email)
);

create table initium.cards(
    id INT IDENTITY(1, 1) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(max) NOT NULL
);

CREATE TABLE initium.notes(
    id INT IDENTITY(1, 1) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
);

