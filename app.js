import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm"

const supabaseUrl = "https://xfsctjluyctwoygzgzew.supabase.co"
const supabaseKey = "sb_publishable_1UwCJUStuhslAXgIgNw3rA_nB7XTP7t"

const supabase = createClient(supabaseUrl, supabaseKey)