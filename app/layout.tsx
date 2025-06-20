import React from 'react';
import Sidebar from './sidebar';
import OnlineUsers from './online-users';
import RecentActivity from './recent-activity';

export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex">
      <Sidebar />
      <main className="flex-1">{children}</main>
      <div className="w-1/4">
        <OnlineUsers />
        <RecentActivity />
      </div>
    </div>
  );
}