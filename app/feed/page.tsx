useEffect(() => {
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