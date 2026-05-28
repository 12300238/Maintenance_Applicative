-- Enable UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

BEGIN;

-- Users table: stores account info
CREATE TABLE IF NOT EXISTS users (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    username varchar(150) NOT NULL UNIQUE,
    email varchar(255) UNIQUE,
    password_hash varchar(255) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_users_username ON users (username);

-- to_do_lists : linked to a user
CREATE TABLE IF NOT EXISTS to_do_lists (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title text,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_to_do_lists_users ON to_do_lists(user_id);

-- tasks: linked to a to_do_list
CREATE TABLE IF NOT EXISTS tasks (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    to_do_list_id uuid NOT NULL REFERENCES to_do_lists(id) ON DELETE CASCADE,
    user_id uuid REFERENCES users(id) ON DELETE SET NULL,
    title text NOT NULL,
    task_state bool NOT NULL,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_task ON messages (to_do_list_id, created_at DESC);

COMMIT;
