From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 03/10] Input: synaptics-rmi4: Add device tree support for RMI4 I2C devices
Date: Wed, 25 Nov 2015 16:07:21 -0800
Message-ID: <1448496448-25123-4-git-send-email-aduggan@synaptics.com>
References: <1448496448-25123-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448496448-25123-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add devicetree binding for I2C devices and add bindings for optional
parameters in the function drivers. Parameters for function drivers are
defined in child nodes for each of the functions.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 .../devicetree/bindings/input/rmi4/rmi_f01.txt     | 39 ++++++++++++
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     | 53 ++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/input/rmi4/rmi_bus.c                       | 71 ++++++++++++++++++++++
 drivers/input/rmi4/rmi_driver.c                    | 28 +++++++++
 drivers/input/rmi4/rmi_i2c.c                       | 12 +++-
 6 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
new file mode 100644
index 0000000..df34dd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
@@ -0,0 +1,39 @@
+Synaptics RMI4 F01 Device Binding
+
+The Synaptics RMI4 core is able to support RMI4 devices using differnet
+transports and differnet functions. This file describes the device tree
+bindings for devices which contain Function 1. Complete documentation
+for transports and other functions can be found in:
+Documentation/devicetree/bindings/input/rmi4.
+
+Additional documentation for F01 can be found at:
+http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
+
+Optional Properties:
+- syna,nosleep-mode: If set the device will run at full power without sleeping.
+			nosleep has 3 modes, 0 will not change the default
+			setting, 1 will disable nosleep (allow sleeping),
+			and 2 will enable nosleep (disabling sleep).
+- syna,wakeup-threshold: Defines the amplitude of the disturbance to the
+				background capacitance that will cause the
+				device to wake from dozing.
+- syna,doze-holdoff: The delay to wait after the last finger lift and the
+				first doze cycle (in 0.1 second units).
+- syna,doze-interval: The time period that the device sleeps between finger
+				activity (in 10 ms units).
+
+
+Example of a RMI4 I2C device with F01:
+	Example:
+	&i2c1 {
+		rmi-i2c-dev@2c {
+			compatible = "syna,rmi-i2c";
+
+			...
+
+			rmi-f01@1 {
+				reg = <0x1>;
+				syna,nosleep-mode = <1>;
+			};
+		};
+	};
diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
new file mode 100644
index 0000000..0f4a8e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
@@ -0,0 +1,53 @@
+Synaptics RMI4 I2C Device Binding
+
+The Synaptics RMI4 core is able to support RMI4 devices using differnet
+transports and differnet functions. This file describes the device tree
+bindings for devices using the I2C tranport driver. Complete documentation
+for other transports and functions cen be found ini
+Documentation/devicetree/bindings/input/rmi4.
+
+Required Properties:
+- compatible: syna,rmi-i2c
+- reg: I2C address
+- #address-cells: Set to 1 to indicate that the function child nodes
+		    consist of only on uint32 value.
+- #size-cells: Set to 0 to indicate that the function child nodes do not
+		have a size property.
+
+Optional Properties:
+- interrupts: interrupt which the rmi device is connected to.
+- interrupt-parent: The interrupt controller.
+See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+- syna,reset-delay-ms: The number of milliseconds to wait after resetting the
+			device.
+
+Function Parameters:
+Parameters specific to RMI functions are contained in child nodes of the rmi device
+ node. Documentation for the parameters of each function can be found in:
+Documentation/devicetree/bindings/input/rmi4/rmi_f*.txt.
+
+
+
+Example:
+	&i2c1 {
+		rmi-i2c-dev@2c {
+			compatible = "syna,rmi-i2c";
+			reg = <0x2c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&gpio>;
+			interrupts = <4 2>;
+
+			rmi-f01@1 {
+				reg = <0x1>;
+				syna,nosleep-mode = <1>;
+			};
+
+			rmi-f11@11 {
+				reg = <0x11>;
+				syna,flip-y;
+				syna,sensor-type = <2>;
+			};
+		};
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 82d2ac9..fd075b8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -212,6 +212,7 @@ sprd	Spreadtrum Communications Inc.
 st	STMicroelectronics
 ste	ST-Ericsson
 stericsson	ST-Ericsson
+syna	Synaptics Inc.
 synology	Synology, Inc.
 tbs	TBS Technologies
 tcl	Toby Churchill Ltd.
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index f3e1f2c..aa12f4a 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -130,6 +130,21 @@ static int rmi_function_match(struct device *dev, struct device_driver *drv)
 	return fn->fd.function_number == handler->func;
 }
 
+#ifdef CONFIG_OF
+static void rmi_function_of_probe(struct rmi_function *fn)
+{
+	char of_name[8];
+
+	snprintf(of_name, sizeof(of_name), "rmi-f%02x",
+		fn->fd.function_number);
+	fn->dev.of_node = of_find_node_by_name(
+				fn->rmi_dev->xport->dev->of_node, of_name);
+}
+#else
+static inline void rmi_function_of_probe(struct rmi_function *fn)
+{}
+#endif
+
 static int rmi_function_probe(struct device *dev)
 {
 	struct rmi_function *fn = to_rmi_function(dev);
@@ -137,6 +152,8 @@ static int rmi_function_probe(struct device *dev)
 					to_rmi_function_handler(dev->driver);
 	int error;
 
+	rmi_function_of_probe(fn);
+
 	if (handler->probe) {
 		error = handler->probe(fn);
 		return error;
@@ -263,6 +280,60 @@ struct bus_type rmi_bus_type = {
 	.name		= "rmi",
 };
 
+int rmi_of_property_read_u32(struct device *dev, u32 *result,
+				const char *prop, bool optional)
+{
+	int retval;
+	u32 val = 0;
+
+	retval = of_property_read_u32(dev->of_node, prop, &val);
+	if (retval && (!optional && retval == -EINVAL)) {
+		dev_err(dev, "Failed to get %s value: %d\n",
+			prop, retval);
+		return retval;
+	}
+	*result = val;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rmi_of_property_read_u32);
+
+int rmi_of_property_read_u16(struct device *dev, u16 *result,
+				const char *prop, bool optional)
+{
+	int retval;
+	u16 val = 0;
+
+	retval = of_property_read_u16(dev->of_node, prop, &val);
+	if (retval && (!optional && retval == -EINVAL)) {
+		dev_err(dev, "Failed to get %s value: %d\n",
+			prop, retval);
+		return retval;
+	}
+	*result = val;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rmi_of_property_read_u16);
+
+int rmi_of_property_read_u8(struct device *dev, u8 *result,
+				const char *prop, bool optional)
+{
+	int retval;
+	u8 val = 0;
+
+	retval = of_property_read_u8(dev->of_node, prop, &val);
+	if (retval && (!optional && retval == -EINVAL)) {
+		dev_err(dev, "Failed to get %s value: %d\n",
+			prop, retval);
+		return retval;
+	}
+	*result = val;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rmi_of_property_read_u8);
+
 static int __init rmi_bus_init(void)
 {
 	int error;
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 0d74d26..3a4697f 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -20,6 +20,7 @@
 #include <linux/kconfig.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <uapi/linux/input.h>
 #include <linux/rmi.h>
 #include "rmi_bus.h"
@@ -864,6 +865,27 @@ static int rmi_driver_remove(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static int rmi_driver_of_probe(struct device *dev,
+				struct rmi_device_platform_data *pdata)
+{
+	int retval;
+
+	retval = rmi_of_property_read_u32(dev, &pdata->reset_delay_ms,
+					"syna,reset-delay-ms", 1);
+	if (retval)
+		return retval;
+
+	return 0;
+}
+#else
+static inline int rmi_driver_of_probe(struct device *dev,
+					struct rmi_device_platform_data *pdata)
+{
+	return -ENODEV;
+}
+#endif
+
 static int rmi_driver_probe(struct device *dev)
 {
 	struct rmi_driver *rmi_driver;
@@ -888,6 +910,12 @@ static int rmi_driver_probe(struct device *dev)
 
 	pdata = rmi_get_platform_data(rmi_dev);
 
+	if (rmi_dev->xport->dev->of_node) {
+		retval = rmi_driver_of_probe(rmi_dev->xport->dev, pdata);
+		if (retval)
+			return retval;
+	}
+
 	data = devm_kzalloc(dev, sizeof(struct rmi_driver_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index c6e680d..32f7cae 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -9,6 +9,7 @@
 
 #include <linux/i2c.h>
 #include <linux/rmi.h>
+#include <linux/of.h>
 #include "rmi_driver.h"
 
 #define BUFFER_SIZE_INCREMENT 32
@@ -168,6 +169,14 @@ static const struct rmi_transport_ops rmi_i2c_ops = {
 	.read_block	= rmi_i2c_read_block,
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id rmi_i2c_of_match[] = {
+	{ .compatible = "syna,rmi-i2c" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rmi_i2c_of_match);
+#endif
+
 static int rmi_i2c_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -184,7 +193,7 @@ static int rmi_i2c_probe(struct i2c_client *client,
 
 	pdata = &rmi_i2c->xport.pdata;
 
-	if (client_pdata)
+	if (!client->dev.of_node && client_pdata)
 		*pdata = *client_pdata;
 
 	dev_dbg(&client->dev, "Probing %s.\n", dev_name(&client->dev));
@@ -246,6 +255,7 @@ static struct i2c_driver rmi_i2c_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= "rmi_i2c",
+		.of_match_table = of_match_ptr(rmi_i2c_of_match),
 	},
 	.id_table	= rmi_id,
 	.probe		= rmi_i2c_probe,
-- 
2.5.0
