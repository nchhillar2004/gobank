CREATE TYPE "Currency" AS ENUM (
  'USD',
  'EUR',
  'INR'
);

CREATE TYPE "AccountType" AS ENUM (
  'CHILD',
  'SAVINGS',
  'BUSINESS'
);

CREATE TYPE "AccountStatus" AS ENUM (
  'ACTIVE',
  'REVIEW',
  'FROZEN'
);

CREATE TABLE "users" (
  "id" bigserial PRIMARY KEY,
  "age" int NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "phone" bigint UNIQUE NOT NULL,
  "address" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "accounts" (
  "id" bigserial PRIMARY KEY,
  "owner" varchar NOT NULL,
  "owner_id" bigint NOT NULL,
  "balance" bigint NOT NULL,
  "status" "AccountStatus" NOT NULL,
  "type" "AccountType" NOT NULL,
  "currency" "Currency" NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "entries" (
  "id" bigserial PRIMARY KEY,
  "account_id" bigint NOT NULL,
  "amount" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "transfers" (
  "id" bigserial PRIMARY KEY,
  "from_account_id" bigint NOT NULL,
  "to_account_id" bigint NOT NULL,
  "amount" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE INDEX ON "users" ("email");

CREATE INDEX ON "accounts" ("owner");

CREATE INDEX ON "entries" ("account_id");

CREATE INDEX ON "transfers" ("from_account_id");

CREATE INDEX ON "transfers" ("to_account_id");

CREATE INDEX ON "transfers" ("from_account_id", "to_account_id");

COMMENT ON COLUMN "accounts"."status" IS 'active/ review/ frozen';

COMMENT ON COLUMN "accounts"."type" IS 'child/ savings/ business';

COMMENT ON COLUMN "entries"."amount" IS 'can be negative or positive';

COMMENT ON COLUMN "transfers"."amount" IS 'must be positive';

ALTER TABLE "accounts" ADD FOREIGN KEY ("owner_id") REFERENCES "users" ("id");

ALTER TABLE "entries" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id");

ALTER TABLE "transfers" ADD FOREIGN KEY ("from_account_id") REFERENCES "accounts" ("id");

ALTER TABLE "transfers" ADD FOREIGN KEY ("to_account_id") REFERENCES "accounts" ("id");
