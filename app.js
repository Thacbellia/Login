import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm"

const supabaseUrl = "https://xfsctjluyctwoygzgzew.supabase.co"
const supabaseKey = "YOUR_ANON_KEY"

const supabase = createClient(supabaseUrl, supabaseKey)