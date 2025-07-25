-- name: CreateAccount :one
INSERT INTO accounts (
    owner,
    owner_id,
    balance,
    status,
    type,
    currency
) VALUES (
    $1, $2, $3, $4, $5, $6
) RETURNING *;

-- name: GetAccount :one
SELECT * FROM accounts
WHERE id = $1 LIMIT 1;

-- name: ListAccounts :many
SELECT * FROM accounts
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateAccount :exec
UPDATE accounts
SET balance = $2
WHERE id = $1;

-- name: DeleteAccount :exec
DELETE FROM accounts
WHERE id = $1;
