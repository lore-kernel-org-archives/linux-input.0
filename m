From: Hans Holmberg <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] GPIO joystick driver
Date: Fri,  6 Feb 2015 10:32:00 +0100
Message-ID: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans Holmberg <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This series adds a driver for digital joysticks connected
via GPIOs.

Tested on Rasperry Pi and Minnowboard MAX using evtest.

The DSDT AML-code snippet below illustrates how to configure a joystick
on the Minnowboard MAX, using the new _DSD support in the kernel.


Scope (_SB)
{
        Device (JOY)
        {
            Name (_HID, "PRP0001")
            Name (_CRS, ResourceTemplate () {
               GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
                  "\\_SB.GPO2", 0, ResourceConsumer) {1}
               GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
                  "\\_SB.GPO2", 0, ResourceConsumer) {0}
               GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
                  "\\_SB.GPO0", 0, ResourceConsumer) {95}
               GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
                  "\\_SB.GPO0", 0, ResourceConsumer) {94}
               GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
                  "\\_SB.GPO2", 0, ResourceConsumer) {2}
            })

            Name (_DSD, Package () {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                    Package () {"compatible", "gpio-joy"},
                    Package () {"debounce-interval-ms", 15},
                    Package () {"left-gpio",    Package () {^JOY, 0, 0, 1}},
                    Package () {"right-gpio",   Package () {^JOY, 1, 0, 1}},
                    Package () {"up-gpio",      Package () {^JOY, 2, 0, 1}},
                    Package () {"down-gpio",    Package () {^JOY, 3, 0, 1}},
                    Package () {"button-gpio",  Package () {^JOY, 4, 0, 1}},
               }
            })
        }
}

Best regards,
Hans

Hans Holmberg (2):
  Documentation: Device Tree binding information for gpio-joy driver
  input: gpio-joy - GPIO joystick driver

 .../devicetree/bindings/input/gpio-joy.txt         |  29 +++
 drivers/input/joystick/Kconfig                     |  10 +
 drivers/input/joystick/Makefile                    |   1 +
 drivers/input/joystick/gpio_joy.c                  | 208 +++++++++++++++++++++
 4 files changed, 248 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-joy.txt
 create mode 100644 drivers/input/joystick/gpio_joy.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
