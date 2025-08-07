import React, { useState, useEffect } from 'react';
import { StyleSheet, Text, View, TouchableOpacity, ActivityIndicator, Alert } from 'react-native';
import { StatusBar } from 'expo-status-bar';
import axios from 'axios';

export default function App() {
  const [counter, setCounter] = useState(0);
  const [loading, setLoading] = useState(false);

  const API_BASE_URL = 'http://10.0.2.2:8081/api'; // Para Android Emulator
  // Para dispositivo físico, substitua por: 'http://SEU_IP_LOCAL:8081/api'

  useEffect(() => {
    fetchCounter();
  }, []);

  const fetchCounter = async () => {
    try {
      setLoading(true);
      const response = await axios.get(`${API_BASE_URL}/counter`);
      setCounter(response.data.value || 0);
    } catch (err) {
      Alert.alert('Erro', 'Não foi possível carregar o contador');
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
    } catch (err) {
      Alert.alert('Erro', 'Não foi possível incrementar o contador');
      console.error('Erro ao incrementar contador:', err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <View style={styles.container}>
      <StatusBar style="light" />
      
      <Text style={styles.title}>Solar Terrain Analytics</Text>
      
      <View style={styles.counterContainer}>
        <View style={styles.counterDisplay}>
          {loading ? (
            <ActivityIndicator size="large" color="#ffd700" />
          ) : (
            <Text style={styles.counterValue}>{counter}</Text>
          )}
        </View>
        
        <TouchableOpacity 
          style={[styles.incrementButton, loading && styles.buttonDisabled]} 
          onPress={incrementCounter}
          disabled={loading}
        >
          <Text style={styles.buttonText}>
            {loading ? 'Incrementando...' : 'Incrementar'}
          </Text>
        </TouchableOpacity>
      </View>
      
      <Text style={styles.subtitle}>
        Aplicação Mobile - Contador Sincronizado
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#667eea',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#ffd700',
    marginBottom: 40,
    textAlign: 'center',
    textShadowColor: 'rgba(0, 0, 0, 0.5)',
    textShadowOffset: { width: 2, height: 2 },
    textShadowRadius: 4,
  },
  counterContainer: {
    alignItems: 'center',
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
    padding: 40,
    borderRadius: 20,
    marginBottom: 30,
    minWidth: 280,
  },
  counterDisplay: {
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    borderRadius: 15,
    padding: 20,
    minWidth: 120,
    alignItems: 'center',
    marginBottom: 30,
    borderWidth: 2,
    borderColor: 'rgba(255, 255, 255, 0.3)',
  },
  counterValue: {
    fontSize: 48,
    fontWeight: 'bold',
    color: '#ffd700',
    textShadowColor: 'rgba(0, 0, 0, 0.5)',
    textShadowOffset: { width: 2, height: 2 },
    textShadowRadius: 4,
  },
  incrementButton: {
    backgroundColor: '#764ba2',
    paddingVertical: 15,
    paddingHorizontal: 30,
    borderRadius: 25,
    minWidth: 180,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 6,
    elevation: 8,
  },
  buttonDisabled: {
    opacity: 0.6,
  },
  buttonText: {
    color: 'white',
    fontSize: 18,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  subtitle: {
    fontSize: 16,
    color: 'rgba(255, 255, 255, 0.8)',
    fontStyle: 'italic',
    textAlign: 'center',
  },
});
