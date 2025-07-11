postgres:
	docker run --name postgres14.18 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=nchhillar -d postgres:14.18-bookworm

createdb:
	docker exec -it postgres14.18 createdb --username=root --owner=root go_bank

dropdb:
	docker exec -it postgres14.18 dropdb go_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:nchhillar@localhost:5432/go_bank?sslmode=disable" -verbose up
	
migratedown:
	migrate -path db/migration -database "postgresql://root:nchhillar@localhost:5432/go_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc
