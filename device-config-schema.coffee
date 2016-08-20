# #Shell device configuration options
module.exports = {
  title: "pimatic-ouimeaux device config schemas"
  WemoSwitch: {
    title: "WemoSwitch config options"
    type: "object"
    extensions: ["xConfirm", "xLink", "xOnLabel", "xOffLabel"]
    properties:
      serialnumber:
        description: ""
        type: "string"
        options:
          hidden: yes
    }
}