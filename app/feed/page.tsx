'use client';

import { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabaseClient';

export default function Feed() {
  const [posts, setPosts] = useState([]);

  const fetchPosts = async () => {
    const { data } = await supabase
      .from('posts')
      .select('*, users(username, avatar_url)')
      .order('created_at', { ascending: false });

    setPosts(data || []);
  };

  useEffect(() => {
    fetchPosts();

    const subscription = supabase
      .from('posts')
      .on('INSERT', (payload) => {
        setPosts((prev) => [payload.new, ...prev]);
      })
      .subscribe();

    return () => {
      supabase.removeSubscription(subscription);
    };
  }, []);

  return (
    <div>
      {posts.map((post) => (
        <div key={post.id} className="p-4 border-b">
          <div className="flex items-center">
            <img
              src={post.users.avatar_url}
              alt={post.users.username}
              className="w-10 h-10 rounded-full"
            />
            <p className="ml-2 font-bold">{post.users.username}</p>
          </div>
          <p>{post.content}</p>
          {post.image_url && (
            <img src={post.image_url} alt="Post image" className="mt-2" />
          )}
          <p className="text-sm text-gray-500">
            {post.hashtags.map((tag) => `#${tag}`).join(' ')}
          </p>
        </div>
      ))}
    </div>
  );
}