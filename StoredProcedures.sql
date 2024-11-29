
CREATE OR ALTER PROCEDURE initium.activate_user(
    @email NVARCHAR(255)
)
AS
BEGIN
        UPDATE initium.users
        SET 
            active = 1,
            updated_at = GETDATE()
        WHERE email = @email;

        DELETE FROM initium.activation_codes
        WHERE email = @email;

        SELECT 200 status, 'User activated successfully' message;
END;


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
        SELECT 200 status, 'card deleted' message;
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

            SELECT 200 status, 'Card updated successfully' message
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


CREATE OR ALTER PROCEDURE initium.get_cards
AS
BEGIN
    SET NOCOUNT ON
    SELECT * FROM initium.cards ORDER BY id DESC
END


CREATE OR ALTER PROCEDURE initium.get_card_by_id (
    @id INT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @n INT = (
        SELECT COUNT(*)
        FROM initium.cards
        WHERE id = @id
    );

    IF @n = 0
    BEGIN
        SELECT 404 AS status, 'Card not found' AS message;
    END
    ELSE
    BEGIN
        SELECT id, title, description
        FROM initium.cards
        WHERE id = @id;
    END
END;




CREATE OR ALTER PROCEDURE GetUserByEmail
    @email NVARCHAR(255)
AS
BEGIN
    SELECT
        id,
        email,
        firstname,
        lastname,
        CONVERT(VARCHAR(19), updated_at, 120) AS updated_at
    FROM initium.users
    WHERE email = @Email;
END

