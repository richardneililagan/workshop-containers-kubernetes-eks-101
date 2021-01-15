const chalk = require('chalk')

// :: ---

const __format = chalk.bold.underline.cyanBright

const [,, ...args] = process.argv
const factors = args.map(Number)

const product = factors.reduce((a, v) => a * v, 1)
console.log(__format(product))
