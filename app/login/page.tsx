'use client';

import { supabase } from '@/lib/supabase';

export default function LoginPage() {
  const handleLogin = async (provider: string) => {
    await supabase.auth.signInWithOAuth({ provider });
  };

  const handleEmailLogin = async (email: string, password: string) => {
    await supabase.auth.signInWithPassword({ email, password });
  };

  return (
    <div className="flex flex-col items-center justify-center h-screen">
      <button
        className="btn btn-primary"
        onClick={() => handleLogin('google')}
      >
        Login with Google
      </button>
      {/* Add email login form */}
    </div>
  );
}