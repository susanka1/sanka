'use client';

import { useState } from 'react';
import { supabase } from '@/lib/supabaseClient';

export default function PostComposer() {
  const [content, setContent] = useState('');
  const [hashtags, setHashtags] = useState('');
  const [image, setImage] = useState<File | null>(null);

  const handleSubmit = async () => {
    const user = (await supabase.auth.getSession()).data.session?.user;

    if (!user) {
      alert('You must be logged in to post.');
      return;
    }

    let imageUrl = null;
    if (image) {
      const { data, error } = await supabase.storage
        .from('post-images')
        .upload(`public/${Date.now()}_${image.name}`, image);

      if (error) {
        console.error(error);
        return;
      }

      imageUrl = data.path;
    }

    const { error } = await supabase.from('posts').insert({
      user_id: user.id,
      content,
      image_url: imageUrl,
      hashtags: hashtags.split(',').map((tag) => tag.trim()),
    });

    if (error) {
      console.error(error);
    } else {
      setContent('');
      setHashtags('');
      setImage(null);
      alert('Post created successfully!');
    }
  };

  return (
    <div className="p-4">
      <textarea
        className="w-full p-2 border border-gray-300 rounded"
        placeholder="What's on your mind?"
        value={content}
        onChange={(e) => setContent(e.target.value)}
      />
      <input
        type="text"
        className="w-full p-2 mt-2 border border-gray-300 rounded"
        placeholder="Hashtags (comma-separated)"
        value={hashtags}
        onChange={(e) => setHashtags(e.target.value)}
      />
      <input
        type="file"
        className="w-full p-2 mt-2 border border-gray-300 rounded"
        onChange={(e) => setImage(e.target.files?.[0] || null)}
      />
      <button
        className="px-4 py-2 mt-2 text-white bg-blue-500 rounded"
        onClick={handleSubmit}
      >
        Post
      </button>
    </div>
  );
}