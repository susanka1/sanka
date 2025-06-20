# Community Forum

A simple community forum built with Next.js, Supabase, and Tailwind CSS.

## Features
- Post Composer: Create posts with text, hashtags, and optional images.
- Supabase Realtime: Real-time updates for new posts.
- Feed: Display posts with user information and hashtags.

## Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/susanka1/community-forum.git
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Configure environment variables:
   - `NEXT_PUBLIC_SUPABASE_URL`: Your Supabase URL.
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`: Your Supabase key.

4. Run the development server:
   ```bash
   npm run dev
   ```

## Deployment
To deploy to Vercel:
1. Push the code to GitHub.
2. Connect the repository on Vercel.
3. Configure environment variables.
4. Deploy the project.

To link a custom domain, follow the instructions in the Vercel dashboard.