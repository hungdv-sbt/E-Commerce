const { environment } = require('@rails/webpacker')

const customConfig = require('./custom');
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default'],
    feather: 'feather-icons', 
    moment: 'moment'
  })
)
environment.config.merge(customConfig);

const erb = require('./loaders/erb')
environment.loaders.prepend('erb', erb)

module.exports = environment
