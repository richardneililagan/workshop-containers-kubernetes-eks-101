const express = require('express')
const app = express()

// :: ---

const ITERATIONS = 1e7 // :: 10,000,000

// :: ---

app.get('/', (_, response) => {
  let current = 0
  for (let i = 0; i < ITERATIONS; i++) current = Math.random()

  response.send(`${current} -> `)
})

app.listen(8080, '0.0.0.0', () => {
  console.log('App server ready.')
})
