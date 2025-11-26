const request = require('supertest');
const express = require('express');

// Crear una instancia de la app para testing
const app = express();

app.get('/', (req, res) => {
  res.json({ 
    message: 'App running – v1',
    timestamp: new Date().toISOString(),
    version: '1.0.0',
    environment: process.env.NODE_ENV || 'development'
  });
});

app.get('/health', (req, res) => {
  res.json({ 
    status: 'healthy',
    uptime: process.uptime(),
    timestamp: new Date().toISOString()
  });
});

describe('Microservice API Tests', () => {
  
  test('GET / should return app running message', async () => {
    const response = await request(app).get('/');
    expect(response.status).toBe(200);
    expect(response.body.message).toBe('App running – v1');
    expect(response.body.version).toBe('1.0.0');
  });

  test('GET /health should return healthy status', async () => {
    const response = await request(app).get('/health');
    expect(response.status).toBe(200);
    expect(response.body.status).toBe('healthy');
  });

  test('Response should be JSON', async () => {
    const response = await request(app).get('/');
    expect(response.type).toBe('application/json');
  });
});