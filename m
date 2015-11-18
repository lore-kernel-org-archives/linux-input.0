From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v10 2/8] Input: goodix - reset device at init
Date: Wed, 18 Nov 2015 18:31:35 +0200
Message-ID: <1447864301-1261-3-git-send-email-irina.tirdea@intel.com>
References: <1447864301-1261-1-git-send-email-irina.tirdea@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447864301-1261-1-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

After power on, it is recommended that the driver resets the device.
The reset procedure timing is described in the datasheet and is used
at device init (before writing device configuration) and
for power management. It is a sequence of setting the interrupt
and reset pins high/low at specific timing intervals. This procedure
also includes setting the slave address to the one specified in the
ACPI/device tree.

This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
driver gt9xx.c for Android (publicly available in Android kernel
trees for various devices).

For reset the driver needs to control the interrupt and
reset gpio pins (configured through ACPI/device tree). For devices
that do not have the gpio pins properly declared, the functionality
depending on these pins will not be available, but the device can still
be used with basic functionality.

For both device tree and ACPI, the interrupt gpio pin configuration is
read from the "irq-gpio" property and the reset pin configuration is
read from the "reset-gpio" property. For ACPI 5.1, named properties
can be specified using the _DSD section. This functionality will not be
available for devices that use indexed gpio pins declared in the _CRS
section (we need to provide backward compatibility with devices
that do not support using the interrupt gpio pin as output).

For ACPI, the pins can be specified using ACPI 5.1:
Device (STAC)
{
    Name (_HID, "GDIX1001")
    ...

    Method (_CRS, 0, Serialized)
    {
        Name (RBUF, ResourceTemplate ()
        {
            I2cSerialBus (0x0014, ControllerInitiated, 0x00061A80,
                AddressingMode7Bit, "\\I2C0",
                0x00, ResourceConsumer, ,
                )

            GpioInt (Edge, ActiveHigh, Exclusive, PullNone, 0x0000,
                "\\I2C0", 0x00, ResourceConsumer, ,
                 )
                 {   // Pin list
                     0
                 }

            GpioIo (Exclusive, PullDown, 0x0000, 0x0000,
                IoRestrictionOutputOnly, "\\I2C0", 0x00,
                ResourceConsumer, ,
                )
                {
                     1
                }
        })
        Return (RBUF)
    }

    Name (_DSD,  Package ()
    {
        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package ()
        {
            Package (2) {"irq-gpio", Package() {^STAC, 0, 0, 0 }},
            Package (2) {"reset-gpio", Package() {^STAC, 1, 0, 0 }},
            ...
        }
    }

Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 .../bindings/input/touchscreen/goodix.txt          |   5 +
 drivers/input/touchscreen/Kconfig                  |   1 +
 drivers/input/touchscreen/goodix.c                 | 101 +++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 8ba98ee..7137881 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -12,6 +12,8 @@ Required properties:
  - reg			: I2C address of the chip. Should be 0x5d or 0x14
  - interrupt-parent	: Interrupt controller to which the chip is connected
  - interrupts		: Interrupt to which the chip is connected
+ - irq-gpio		: GPIO pin used for IRQ
+ - reset-gpio		: GPIO pin used for reset
 
 Example:
 
@@ -23,6 +25,9 @@ Example:
 			reg = <0x5d>;
 			interrupt-parent = <&gpio>;
 			interrupts = <0 0>;
+
+			irq-gpio = <&gpio1 0 0>;
+			reset-gpio = <&gpio1 1 0>;
 		};
 
 		/* ... */
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 2ccc522..121a0ac 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -324,6 +324,7 @@ config TOUCHSCREEN_FUJITSU
 config TOUCHSCREEN_GOODIX
 	tristate "Goodix I2C touchscreen"
 	depends on I2C
+	depends on GPIOLIB
 	help
 	  Say Y here if you have the Goodix touchscreen (such as one
 	  installed in Onda v975w tablets) connected to your
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 56d0330..4744032 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -16,6 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/dmi.h>
+#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
@@ -37,8 +38,13 @@ struct goodix_ts_data {
 	unsigned int int_trigger_type;
 	bool rotated_screen;
 	int cfg_len;
+	struct gpio_desc *gpiod_int;
+	struct gpio_desc *gpiod_rst;
 };
 
+#define GOODIX_GPIO_INT_NAME		"irq"
+#define GOODIX_GPIO_RST_NAME		"reset"
+
 #define GOODIX_MAX_HEIGHT		4096
 #define GOODIX_MAX_WIDTH		4096
 #define GOODIX_INT_TRIGGER		1
@@ -237,6 +243,88 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int goodix_int_sync(struct goodix_ts_data *ts)
+{
+	int error;
+
+	error = gpiod_direction_output(ts->gpiod_int, 0);
+	if (error)
+		return error;
+	msleep(50);				/* T5: 50ms */
+
+	return gpiod_direction_input(ts->gpiod_int);
+}
+
+/**
+ * goodix_reset - Reset device during power on
+ *
+ * @ts: goodix_ts_data pointer
+ */
+static int goodix_reset(struct goodix_ts_data *ts)
+{
+	int error;
+
+	/* begin select I2C slave addr */
+	error = gpiod_direction_output(ts->gpiod_rst, 0);
+	if (error)
+		return error;
+	msleep(20);				/* T2: > 10ms */
+	/* HIGH: 0x28/0x29, LOW: 0xBA/0xBB */
+	error = gpiod_direction_output(ts->gpiod_int, ts->client->addr == 0x14);
+	if (error)
+		return error;
+	usleep_range(100, 2000);		/* T3: > 100us */
+	error = gpiod_direction_output(ts->gpiod_rst, 1);
+	if (error)
+		return error;
+	usleep_range(6000, 10000);		/* T4: > 5ms */
+	/* end select I2C slave addr */
+	error = gpiod_direction_input(ts->gpiod_rst);
+	if (error)
+		return error;
+	return goodix_int_sync(ts);
+}
+
+/**
+ * goodix_get_gpio_config - Get GPIO config from ACPI/DT
+ *
+ * @ts: goodix_ts_data pointer
+ */
+static int goodix_get_gpio_config(struct goodix_ts_data *ts)
+{
+	int error;
+	struct device *dev;
+	struct gpio_desc *gpiod;
+
+	if (!ts->client)
+		return -EINVAL;
+	dev = &ts->client->dev;
+
+	/* Get the interrupt GPIO pin number */
+	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		error = PTR_ERR(gpiod);
+		if (error != -EPROBE_DEFER)
+			dev_dbg(dev, "Failed to get %s GPIO: %d\n",
+				GOODIX_GPIO_INT_NAME, error);
+		return error;
+	}
+	ts->gpiod_int = gpiod;
+
+	/* Get the reset line GPIO pin number */
+	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_RST_NAME, GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		error = PTR_ERR(gpiod);
+		if (error != -EPROBE_DEFER)
+			dev_dbg(dev, "Failed to get %s GPIO: %d\n",
+				GOODIX_GPIO_RST_NAME, error);
+		return error;
+	}
+	ts->gpiod_rst = gpiod;
+
+	return 0;
+}
+
 /**
  * goodix_read_config - Read the embedded configuration of the panel
  *
@@ -405,6 +493,19 @@ static int goodix_ts_probe(struct i2c_client *client,
 	ts->client = client;
 	i2c_set_clientdata(client, ts);
 
+	error = goodix_get_gpio_config(ts);
+	if (error)
+		return error;
+
+	if (ts->gpiod_int && ts->gpiod_rst) {
+		/* reset the controller */
+		error = goodix_reset(ts);
+		if (error) {
+			dev_err(&client->dev, "Controller reset failed.\n");
+			return error;
+		}
+	}
+
 	error = goodix_i2c_test(client);
 	if (error) {
 		dev_err(&client->dev, "I2C communication failure: %d\n", error);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
