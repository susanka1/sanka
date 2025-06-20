
-- Insert sample users
INSERT INTO users (email, password) VALUES
('user1@example.com', 'password1'),
('user2@example.com', 'password2');

-- Insert sample communities
INSERT INTO communities (name, description) VALUES
('General', 'General discussion'),
('Tech', 'Technology and gadgets');

-- Insert sample posts
INSERT INTO posts (community_id, user_id, title, content) VALUES
((SELECT id FROM communities WHERE name = 'General'), (SELECT id FROM users WHERE email = 'user1@example.com'), 'First Post', 'This is the content of the first post.'),
((SELECT id FROM communities WHERE name = 'Tech'), (SELECT id FROM users WHERE email = 'user2@example.com'), 'Second Post', 'This is the content of the second post.');

-- Insert sample comments
INSERT INTO comments (post_id, user_id, content) VALUES
((SELECT id FROM posts WHERE title = 'First Post'), (SELECT id FROM users WHERE email = 'user2@example.com'), 'Great post!'),
((SELECT id FROM posts WHERE title = 'Second Post'), (SELECT id FROM users WHERE email = 'user1@example.com'), 'Thanks for sharing.');

-- Insert sample likes
INSERT INTO likes (post_id, user_id) VALUES
((SELECT id FROM posts WHERE title = 'First Post'), (SELECT id FROM users WHERE email = 'user2@example.com')),
((SELECT id FROM posts WHERE title = 'Second Post'), (SELECT id FROM users WHERE email = 'user1@example.com'));
