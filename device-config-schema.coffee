# #Shell device configuration options
module.exports = {
  title: "wemo-plugin device config schemas"
  WemoSwitch: {
    title: "WemoSwitch config options"
    type: "object"
    extensions: ["xConfirm", "xLink", "xOnLabel", "xOffLabel"]
    properties:
      serialnumber:
        description: "Device serial number"
        type: "string"
        options:
          hidden: yes
      modelname:
        description: "Model"
        type: "string"
        options:
          hidden: yes
      host:
        description: "Host"
        type: "string"
        options:
          hidden: yes
      port:
        description: "Port"
        type: "number"
        default: 5000
        options:
          hidden: yes
    }
}
