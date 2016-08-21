# #my-plugin configuration options
# Declare your config option for your plugin here. 
module.exports = {
  title: "Wemo plugin config options"
  type: "object"
  properties:
    option1:
      description: "Some option"
      type: "string"
      default: "foo"
}