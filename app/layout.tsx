// app/layout.tsx
import React from 'react';
import Sidebar from './sidebar';
import OnlineUsers from './online-users';
import RecentActivity from './recent-activity';
import '../styles/globals.css'; // Adjust if your global styles are elsewhere

export const metadata = {
  title: 'Sanka Community Forum',
  description: 'A community-powered forum built with Next.js and Supabase',
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        <div className="flex">
          <Sidebar />
          <main className="flex-1">{children}</main>
          <div className="w-1/4">
            <OnlineUsers />
            <RecentActivity />
          </div>
        </div>
      </body>
    </html>
  );
}
