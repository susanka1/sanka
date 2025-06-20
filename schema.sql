
-- Create users table
CREATE TABLE users (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    email text UNIQUE NOT NULL,
    password text NOT NULL,
    created_at timestamp with time zone DEFAULT current_timestamp
);

-- Create communities table
CREATE TABLE communities (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    name text UNIQUE NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT current_timestamp
);

-- Create posts table
CREATE TABLE posts (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    community_id uuid REFERENCES communities(id),
    user_id uuid REFERENCES users(id),
    title text NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT current_timestamp
);

-- Create comments table
CREATE TABLE comments (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    post_id uuid REFERENCES posts(id),
    user_id uuid REFERENCES users(id),
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT current_timestamp
);

-- Create likes table
CREATE TABLE likes (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    post_id uuid REFERENCES posts(id),
    user_id uuid REFERENCES users(id),
    created_at timestamp with time zone DEFAULT current_timestamp
);

-- Create indexes for performance
CREATE INDEX idx_posts_community_id ON posts(community_id);
CREATE INDEX idx_comments_post_id ON comments(post_id);
CREATE INDEX idx_likes_post_id ON likes(post_id);

-- Enable row level security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE communities ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE likes ENABLE ROW LEVEL SECURITY;

-- Create policies for users
CREATE POLICY "Allow logged-in read access" ON users
    FOR SELECT
    USING (auth.uid() IS NOT NULL);

-- Create policies for communities
CREATE POLICY "Allow logged-in read access" ON communities
    FOR SELECT
    USING (auth.uid() IS NOT NULL);

-- Create policies for posts
CREATE POLICY "Allow logged-in read access" ON posts
    FOR SELECT
    USING (auth.uid() IS NOT NULL);

CREATE POLICY "Allow logged-in insert access" ON posts
    FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Create policies for comments
CREATE POLICY "Allow logged-in read access" ON comments
    FOR SELECT
    USING (auth.uid() IS NOT NULL);

CREATE POLICY "Allow logged-in insert access" ON comments
    FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Create policies for likes
CREATE POLICY "Allow logged-in read access" ON likes
    FOR SELECT
    USING (auth.uid() IS NOT NULL);

CREATE POLICY "Allow logged-in insert access" ON likes
    FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Create storage bucket for images
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE storage (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id uuid REFERENCES users(id),
    file_name text NOT NULL,
    file_path text NOT NULL,
    created_at timestamp with time zone DEFAULT current_timestamp
);
