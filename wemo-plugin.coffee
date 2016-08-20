# #Plugin template

module.exports = (env) ->

  # Require the  bluebird promise library
  Promise = env.require 'bluebird'
  # Require the [cassert library](https://github.com/rhoot/cassert).
  assert = env.require 'cassert'

  wemoClient = require("wemo-client")

  # Create a class that extends the Plugin class and implements the following functions:
  class Wemo extends env.plugins.Plugin
    wemoclient = new wemoClient()

    callMe: (deviceInfo) =>
      env.logger.info('Wemo: Device Found: %j', deviceInfo.friendlyName)
      str = '{ "name": "John Doe", "age": 42 }'
      json = JSON.parse(str)

      config = {
        class: 'WemoSwitch',
        name: json.name,
        host: deviceInfo.friendlyName
      }
      
      @framework.deviceManager.discoveredDevice(
                  'wemo', "Presence of '#{deviceInfo.friendlyName}'"
                )
      return

    init: (app, @framework, @config) =>
      env.logger.info("WEMO: Init")


      

      deviceConfigDef = require("./device-config-schema")

      @framework.deviceManager.registerDeviceClass("WemoSwitch", {
        configDef: deviceConfigDef.WemoSwitch, 
        createCallback: (config) => new WemoSwitch(config)
      })



      @framework.deviceManager.on('discover', (eventData) =>
        @framework.deviceManager.discoverMessage(
            'wemo', "Scanning for wemo devices..."
          )

        wemoclient.discover (@callMe)
        )

  class WemoSwitch extends env.devices.PowerSwitch

    # ...@framework.deviceManager.on('discover', (eventData) =>

  # ###Finally
  # Create a instance of my plugin
  weMo = new Wemo
  # and return it to the framework.
  return weMo