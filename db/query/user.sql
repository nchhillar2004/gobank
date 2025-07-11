-- name: CreateUser :one
INSERT INTO users (
    age,
    email,
    phone,
    address
) VALUES (
   $1, $2, $3, $4 
) RETURNING *;

-- name: GetUser :one
SELECT * FROM users
WHERE id = $1 LIMIT 1;

-- name: ListUsers :many
SELECT * FROM users
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateUsers :exec
UPDATE users
SET address = $2
WHERE id = $1;

-- name: DeleteUser :exec
DELETE FROM users
WHERE id = $1;
