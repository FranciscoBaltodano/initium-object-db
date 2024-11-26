-- otd.activate_user
CREATE OR ALTER PROCEDURE initium.generate_activation_code( 
    @email NVARCHAR(255),
    @code INT    
)
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @n INT = ( SELECT COUNT(*) FROM initium.users WHERE email = @email );

    IF @n = 0 BEGIN
        SELECT 404 status, 'not found' message;
    END ELSE BEGIN
        INSERT INTO initium.activation_codes (email, code)
        VALUES( @email, @code )
    END;
END;

CREATE OR ALTER PROCEDURE initium.create_user(
    @firstname NVARCHAR(255),
    @lastname NVARCHAR(255),
    @email NVARCHAR(255)
)
AS
BEGIN
    DECLARE @n INT = (
        SELECT COUNT(*) 
        FROM initium.users
        WHERE email = @email
    )

    if @n > 0 
        BEGIN
            SELECT 400 status, 'email already exist' message;
        END 
    ELSE 
        BEGIN
            INSERT INTO initium.users (firstname, lastname, email)
            VALUES( @firstname, @lastname, @email )
        END

END


CREATE OR ALTER PROCEDURE initium.delete_card( @card_id INT )
AS 
BEGIN

    DECLARE @n INT = (
        select count(*)
        from initium.cards
        where id = @card_id
    );

    if @n = 0 BEGIN
        SELECT 404 status, 'not found' message;
    END ELSE BEGIN
        DELETE from initium.cards 
        where id = @card_id;
        SELECT 200 status, 'ok' message;
    END;
END;


CREATE OR ALTER PROCEDURE initium.update_card(
    @id INT,
    @title NVARCHAR(255),
    @description NVARCHAR(max)
)
AS
BEGIN

    DECLARE @n INT = (
        SELECT COUNT(*) 
        FROM initium.cards
        WHERE id = @id
    )

    if @n = 0 
        BEGIN
            SELECT 404 status, 'not found' message;
        END 
    ELSE 
        BEGIN
            UPDATE initium.cards
            SET
                title =  @title,
                description = @description
            WHERE id = @id
        END
END


CREATE OR ALTER PROCEDURE initium.create_card(
    @title NVARCHAR(255),
    @description NVARCHAR(max)
)
AS
BEGIN
    INSERT INTO initium.cards (title, description)
    VALUES( @title, @description )
END



