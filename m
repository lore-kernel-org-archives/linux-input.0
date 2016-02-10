From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v4 03/10] Input: synaptics-rmi4: Add device tree support for RMI4 I2C devices
Date: Tue, 9 Feb 2016 17:40:57 -0800
Message-ID: <1455068457-12014-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add devicetree binding for I2C devices and add bindings for optional
parameters in the function drivers. Parameters for function drivers are
defined in child nodes for each of the functions.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 .../devicetree/bindings/input/rmi4/rmi_f01.txt     | 39 ++++++++++++++++
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     | 53 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/input/rmi4/rmi_bus.c                       | 35 ++++++++++++++
 drivers/input/rmi4/rmi_bus.h                       |  4 --
 drivers/input/rmi4/rmi_driver.c                    | 28 ++++++++++++
 drivers/input/rmi4/rmi_f01.c                       | 50 ++++++++++++++++++++
 drivers/input/rmi4/rmi_i2c.c                       | 12 ++++-
 8 files changed, 217 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
new file mode 100644
index 0000000..079cad2
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
@@ -0,0 +1,39 @@
+Synaptics RMI4 F01 Device Binding
+
+The Synaptics RMI4 core is able to support RMI4 devices using different
+transports and different functions. This file describes the device tree
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
+- syna,doze-holdoff-ms: The delay to wait after the last finger lift and the
+				first doze cycle.
+- syna,doze-interval-ms: The time period that the device sleeps between finger
+				activity.
+
+
+Example of a RMI4 I2C device with F01:
+	Example:
+	&i2c1 {
+		rmi4-i2c-dev@2c {
+			compatible = "syna,rmi4-i2c";
+
+			...
+
+			rmi4-f01@1 {
+				reg = <0x1>;
+				syna,nosleep-mode = <1>;
+			};
+		};
+	};
diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
new file mode 100644
index 0000000..95fa715
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
@@ -0,0 +1,53 @@
+Synaptics RMI4 I2C Device Binding
+
+The Synaptics RMI4 core is able to support RMI4 devices using different
+transports and different functions. This file describes the device tree
+bindings for devices using the I2C transport driver. Complete documentation
+for other transports and functions can be found in
+Documentation/devicetree/bindings/input/rmi4.
+
+Required Properties:
+- compatible: syna,rmi4-i2c
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
+		rmi4-i2c-dev@2c {
+			compatible = "syna,rmi4-i2c";
+			reg = <0x2c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&gpio>;
+			interrupts = <4 2>;
+
+			rmi4-f01@1 {
+				reg = <0x1>;
+				syna,nosleep-mode = <1>;
+			};
+
+			rmi4-f11@11 {
+				reg = <0x11>;
+				touchscreen-inverted-y;
+				syna,sensor-type = <2>;
+			};
+		};
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 55df1d4..7a1bf68 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -220,6 +220,7 @@ sprd	Spreadtrum Communications Inc.
 st	STMicroelectronics
 ste	ST-Ericsson
 stericsson	ST-Ericsson
+syna	Synaptics Inc.
 synology	Synology, Inc.
 tbs	TBS Technologies
 tcl	Toby Churchill Ltd.
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index c5be70c..7f3f8e1 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -153,6 +153,21 @@ static int rmi_function_match(struct device *dev, struct device_driver *drv)
 	return fn->fd.function_number == handler->func;
 }
 
+#ifdef CONFIG_OF
+static void rmi_function_of_probe(struct rmi_function *fn)
+{
+	char of_name[9];
+
+	snprintf(of_name, sizeof(of_name), "rmi4-f%02x",
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
@@ -160,6 +175,8 @@ static int rmi_function_probe(struct device *dev)
 					to_rmi_function_handler(dev->driver);
 	int error;
 
+	rmi_function_of_probe(fn);
+
 	if (handler->probe) {
 		error = handler->probe(fn);
 		return error;
@@ -328,6 +345,24 @@ err_unregister_function_handlers:
 	return ret;
 }
 
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
 static int __init rmi_bus_init(void)
 {
 	int error;
diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 13b148d..8995798 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -172,10 +172,6 @@ extern struct bus_type rmi_bus_type;
 
 int rmi_of_property_read_u32(struct device *dev, u32 *result,
 				const char *prop, bool optional);
-int rmi_of_property_read_u16(struct device *dev, u16 *result,
-				const char *prop, bool optional);
-int rmi_of_property_read_u8(struct device *dev, u8 *result,
-				const char *prop, bool optional);
 
 #define RMI_DEBUG_CORE			BIT(0)
 #define RMI_DEBUG_XPORT			BIT(1)
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index b0f34b5..da38f0a 100644
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
@@ -821,6 +822,27 @@ static int rmi_driver_remove(struct device *dev)
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
@@ -846,6 +868,12 @@ static int rmi_driver_probe(struct device *dev)
 
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
diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index e50ecc6..eb362bc 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -247,6 +247,50 @@ char *rmi_f01_get_product_ID(struct rmi_function *fn)
 	return f01->properties.product_id;
 }
 
+#ifdef CONFIG_OF
+static int rmi_f01_of_probe(struct device *dev,
+				struct rmi_device_platform_data *pdata)
+{
+	int retval;
+	u32 val;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->power_management.nosleep,
+			"syna,nosleep-mode", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev, &val,
+			"syna,wakeup-threshold", 1);
+	if (retval)
+		return retval;
+
+	pdata->power_management.wakeup_threshold = val;
+
+	retval = rmi_of_property_read_u32(dev, &val,
+			"syna,doze-holdoff-ms", 1);
+	if (retval)
+		return retval;
+
+	pdata->power_management.doze_holdoff = val * 100;
+
+	retval = rmi_of_property_read_u32(dev, &val,
+			"syna,doze-interval-ms", 1);
+	if (retval)
+		return retval;
+
+	pdata->power_management.doze_interval = val / 10;
+
+	return 0;
+}
+#else
+static inline int rmi_f01_of_probe(struct device *dev,
+					struct rmi_device_platform_data *pdata)
+{
+	return -ENODEV;
+}
+#endif
+
 static int rmi_f01_probe(struct rmi_function *fn)
 {
 	struct rmi_device *rmi_dev = fn->rmi_dev;
@@ -258,6 +302,12 @@ static int rmi_f01_probe(struct rmi_function *fn)
 	u8 device_status;
 	u8 temp;
 
+	if (fn->dev.of_node) {
+		error = rmi_f01_of_probe(&fn->dev, pdata);
+		if (error)
+			return error;
+	}
+
 	f01 = devm_kzalloc(&fn->dev, sizeof(struct f01_data), GFP_KERNEL);
 	if (!f01)
 		return -ENOMEM;
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index e67662a..07d4d98 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -10,6 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/rmi.h>
 #include <linux/irq.h>
+#include <linux/of.h>
 #include "rmi_driver.h"
 
 #define BUFFER_SIZE_INCREMENT 32
@@ -207,6 +208,14 @@ static int rmi_i2c_init_irq(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id rmi_i2c_of_match[] = {
+	{ .compatible = "syna,rmi4-i2c" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rmi_i2c_of_match);
+#endif
+
 static int rmi_i2c_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -223,7 +232,7 @@ static int rmi_i2c_probe(struct i2c_client *client,
 
 	pdata = &rmi_i2c->xport.pdata;
 
-	if (client_pdata)
+	if (!client->dev.of_node && client_pdata)
 		*pdata = *client_pdata;
 
 	if (client->irq > 0)
@@ -373,6 +382,7 @@ static struct i2c_driver rmi_i2c_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "rmi4_i2c",
 		.pm	= &rmi_i2c_pm,
+		.of_match_table = of_match_ptr(rmi_i2c_of_match),
 	},
 	.id_table	= rmi_id,
 	.probe		= rmi_i2c_probe,
-- 
2.5.0
