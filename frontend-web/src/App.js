import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

function App() {
  const [counter, setCounter] = useState(0);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const API_BASE_URL = 'http://localhost:8081/api';

  useEffect(() => {
    fetchCounter();
  }, []);

  const fetchCounter = async () => {
    try {
      setLoading(true);
      const response = await axios.get(`${API_BASE_URL}/counter`);
      setCounter(response.data.value || 0);
      setError(null);
    } catch (err) {
      setError('Erro ao carregar contador');
      console.error('Erro ao buscar contador:', err);
    } finally {
      setLoading(false);
    }
  };

  const incrementCounter = async () => {
    try {
      setLoading(true);
      const response = await axios.post(`${API_BASE_URL}/counter/increment`);
      setCounter(response.data.value || 0);
      setError(null);
    } catch (err) {
      setError('Erro ao incrementar contador');
      console.error('Erro ao incrementar contador:', err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Solar Terrain Analytics</h1>
        <div className="counter-container">
          <div className="counter-display">
            {loading ? (
              <div className="loading">Carregando...</div>
            ) : (
              <span className="counter-value">{counter}</span>
            )}
          </div>
          <button 
            className="increment-button" 
            onClick={incrementCounter}
            disabled={loading}
          >
            {loading ? 'Incrementando...' : 'Incrementar'}
          </button>
          {error && <div className="error">{error}</div>}
        </div>
        <p className="subtitle">
          Plataforma Web - Contador Sincronizado
        </p>
      </header>
    </div>
  );
}

export default App;
