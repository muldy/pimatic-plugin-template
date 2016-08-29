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

      config = {
        class: 'WemoSwitch',
        name: deviceInfo.friendlyName,
        serialnumber: deviceInfo.serialNumber,
        modelname: deviceInfo.modelName,
        host: deviceInfo.host,
        port: deviceInfo.port
      }
      
      @framework.deviceManager.discoveredDevice(
                  'wemo', "Presence of '#{deviceInfo.friendlyName}'", config
                )
      return

     

    init: (app, @framework, config) =>
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
    constructor: (@config) ->
      @name = @config.name
      @id = @config.id
      env.logger.info("WEMO: Device created!: "+@config.host+":"+@config.port)
      super()

    getState: () ->
      env.logger.info("WEMO: getState!")
      wemoclient = new wemoClient()
      wemoclient.load 'http://'+@config.host+':'+@config.port+'/setup.xml', (deviceInfo) ->
        env.logger.info("WEMO: Load")
        client = wemoclient.client(deviceInfo)
        _state = client.getBinaryState
        env.logger.info("WEMO: Done!")
        @_state = _state
        return



    # ...@framework.deviceManager.on('discover', (eventData) =>

  # ###Finally
  # Create a instance of my plugin
  weMo = new Wemo
  # and return it to the framework.
  return weMo
