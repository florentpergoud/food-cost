import { createFileRoute } from '@tanstack/react-router'
import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'

export const Route = createFileRoute('/test-db')({
  component: TestDatabase,
})

function TestDatabase() {
  const [categories, setCategories] = useState<any[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    async function fetchCategories() {
      try {
        const { data, error } = await supabase
          .from('categories_alimentaires')
          .select('*')
          .order('nom')
        
        if (error) throw error
        
        setCategories(data || [])
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Une erreur est survenue')
      } finally {
        setLoading(false)
      }
    }

    fetchCategories()
  }, [])

  if (loading) return <div className="p-8">Chargement...</div>
  if (error) return <div className="p-8 text-red-500">Erreur: {error}</div>

  return (
    <div className="p-8">
      <h1 className="text-2xl font-bold mb-6">Test Base de Données</h1>
      
      <div className="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6">
        ✅ Connexion Supabase réussie!
      </div>

      <h2 className="text-xl font-semibold mb-4">Catégories Alimentaires ({categories.length})</h2>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {categories.map((category) => (
          <div key={category.id} className="border rounded-lg p-4 bg-white shadow-sm">
            <h3 className="font-semibold text-lg">{category.nom}</h3>
            <p className="text-gray-600 text-sm">{category.description}</p>
          </div>
        ))}
      </div>
    </div>
  )
}