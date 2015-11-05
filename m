From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 13/26] Input: synaptics-rmi4: Add device tree support for RMI4 I2C devices
Date: Thu, 5 Nov 2015 15:40:28 -0800
Message-ID: <1446766828-30806-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:5467 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965324AbbKEXkg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Nov 2015 18:40:36 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

Add devicetree binding for I2C devices and add bindings for optional
parameters in the function drivers. Parameters for function drivers are
defined in child nodes for each of the functions.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 .../devicetree/bindings/input/rmi4/rmi_f01.txt     | 40 +++++++++++
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     | 55 ++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/input/rmi4/rmi_bus.c                       | 83 ++++++++++++++++++++--
 drivers/input/rmi4/rmi_bus.h                       | 12 +++-
 drivers/input/rmi4/rmi_driver.c                    | 38 +++++++++-
 drivers/input/rmi4/rmi_f01.c                       | 50 ++++++++++++-
 drivers/input/rmi4/rmi_i2c.c                       | 35 +++++----
 8 files changed, 292 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
new file mode 100644
index 0000000..ee44755
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
@@ -0,0 +1,40 @@
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
+
diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
new file mode 100644
index 0000000..1b46598
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
@@ -0,0 +1,55 @@
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
+- syna,poll-interval-ms: The interval in milliseconds to wait between reading
+			interrupts when the driver is polling.
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
index 40ce2df..3ea0a43 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -85,6 +85,7 @@ spansion	Spansion Inc.
 st	STMicroelectronics
 ste	ST-Ericsson
 stericsson	ST-Ericsson
+syna	Synaptics Inc.
 ti	Texas Instruments
 tlm	Trusted Logic Mobility
 toshiba	Toshiba Corporation
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index bbc80e6..9222c7a 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/debugfs.h>
+#include <linux/of.h>
 #include "rmi_bus.h"
 #include "rmi_driver.h"
 
@@ -86,15 +87,10 @@ static void rmi_physical_teardown_debugfs(struct rmi_device *rmi_dev)
 int rmi_register_transport_device(struct rmi_transport_dev *xport)
 {
 	static atomic_t transport_device_count = ATOMIC_INIT(0);
-	struct rmi_device_platform_data *pdata = xport->dev->platform_data;
+	struct rmi_device_platform_data *pdata = &xport->pdata;
 	struct rmi_device *rmi_dev;
 	int error;
 
-	if (!pdata) {
-		dev_err(xport->dev, "no platform data!\n");
-		return -EINVAL;
-	}
-
 	rmi_dev = kzalloc(sizeof(struct rmi_device), GFP_KERNEL);
 	if (!rmi_dev)
 		return -ENOMEM;
@@ -203,6 +199,21 @@ static int rmi_function_match(struct device *dev, struct device_driver *drv)
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
@@ -210,6 +221,8 @@ static int rmi_function_probe(struct device *dev)
 					to_rmi_function_handler(dev->driver);
 	int error;
 
+	rmi_function_of_probe(fn);
+
 	if (handler->probe) {
 		error = handler->probe(fn);
 		return error;
@@ -267,6 +280,10 @@ void rmi_unregister_function(struct rmi_function *fn)
 {
 	device_del(&fn->dev);
 	rmi_function_teardown_debugfs(fn);
+
+	if (fn->dev.of_node)
+		of_node_put(fn->dev.of_node);
+
 	put_device(&fn->dev);
 }
 
@@ -335,6 +352,60 @@ struct bus_type rmi_bus_type = {
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
 #ifdef CONFIG_RMI4_DEBUG
 
 static void rmi_bus_setup_debugfs(void)
diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 2a892be..ecd0b8e 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -184,6 +184,8 @@ struct rmi_transport_dev {
 	const char *proto_name;
 	const struct rmi_transport_ops *ops;
 	struct rmi_transport_stats stats;
+
+	struct rmi_device_platform_data pdata;
 };
 
 /**
@@ -227,10 +229,10 @@ struct rmi_device {
 
 #define to_rmi_device(d) container_of(d, struct rmi_device, dev)
 
-static inline const struct rmi_device_platform_data *
+static inline struct rmi_device_platform_data *
 rmi_get_platform_data(struct rmi_device *d)
 {
-	return dev_get_platdata(d->xport->dev);
+	return &d->xport->pdata;
 }
 
 bool rmi_is_physical_device(struct device *dev);
@@ -318,4 +320,10 @@ int rmi_for_each_dev(void *data, int (*func)(struct device *dev, void *data));
 
 extern struct bus_type rmi_bus_type;
 
+int rmi_of_property_read_u32(struct device *dev, u32 *result,
+				const char *prop, bool optional);
+int rmi_of_property_read_u16(struct device *dev, u16 *result,
+				const char *prop, bool optional);
+int rmi_of_property_read_u8(struct device *dev, u8 *result,
+				const char *prop, bool optional);
 #endif
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5efcaca..b569aab 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -26,6 +26,7 @@
 #include <linux/pm.h>
 #include <linux/rmi.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/input.h>
 #include "rmi_bus.h"
@@ -755,11 +756,40 @@ static int rmi_driver_remove(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static int rmi_driver_of_probe(struct device *dev,
+				struct rmi_device_platform_data *pdata)
+{
+	int retval;
+
+	retval = rmi_of_property_read_u32(dev, &pdata->poll_interval_ms,
+					"syna,poll-interval-ms", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev, &pdata->reset_delay_ms,
+					"syna,reset-delay-ms", 1);
+	if (retval)
+		return retval;
+
+	pdata->unified_input = of_property_read_bool(dev->of_node,
+					"syna,unified_input");
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
 	struct rmi_driver_data *data;
-	const struct rmi_device_platform_data *pdata;
+	struct rmi_device_platform_data *pdata;
 	struct rmi_device *rmi_dev;
 	size_t size;
 	void *irq_memory;
@@ -779,6 +809,12 @@ static int rmi_driver_probe(struct device *dev)
 
 	pdata = rmi_get_platform_data(rmi_dev);
 
+	if (rmi_dev->xport->dev->of_node) {
+		retval = rmi_driver_of_probe(rmi_dev->xport->dev, pdata);
+		if (retval)
+			return retval;
+	}
+
 	data = kzalloc(sizeof(struct rmi_driver_data), GFP_KERNEL);
 	if (!data) {
 		dev_err(dev, "%s: Failed to allocate driver data.\n", __func__);
diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 2d72dc8..5347989 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -12,6 +12,7 @@
 #include <linux/rmi.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/of.h>
 #include "rmi_driver.h"
 
 #define RMI_PRODUCT_ID_LENGTH    10
@@ -183,16 +184,63 @@ char *rmi_f01_get_product_ID(struct rmi_function *fn)
 	return f01->properties.product_id;
 }
 
+#ifdef CONFIG_OF
+static int rmi_f01_of_probe(struct device *dev,
+				struct rmi_device_platform_data *pdata)
+{
+	int retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->power_management.nosleep,
+			"syna,nosleep-mode", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->power_management.wakeup_threshold,
+			"syna,wakeup-threshold", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->power_management.doze_holdoff,
+			"syna,doze-holdoff", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->power_management.doze_interval,
+			"syna,doze-interval", 1);
+	if (retval)
+		return retval;
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
 	struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
-	const struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
+	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
 	struct f01_data *f01;
 	int error;
 	u16 ctrl_base_addr = fn->fd.control_base_addr;
 	u8 device_status;
 	u8 temp;
+	int retval;
+
+	if (fn->dev.of_node) {
+		retval = rmi_f01_of_probe(&fn->dev, pdata);
+		if (retval)
+			return retval;
+	}
 
 	f01 = devm_kzalloc(&fn->dev, sizeof(struct f01_data), GFP_KERNEL);
 	if (!f01) {
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index 277cdc8..62cc8ba 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/rmi.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include "rmi_driver.h"
 
 #define BUFFER_SIZE_INCREMENT 32
@@ -183,18 +184,32 @@ static const struct rmi_transport_ops rmi_i2c_ops = {
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
-	const struct rmi_device_platform_data *pdata =
-				dev_get_platdata(&client->dev);
+	struct rmi_device_platform_data *pdata;
+	struct rmi_device_platform_data *client_pdata =
+					dev_get_platdata(&client->dev);
 	struct rmi_i2c_xport *rmi_i2c;
 	int retval;
 
-	if (!pdata) {
-		dev_err(&client->dev, "no platform data\n");
-		return -EINVAL;
-	}
+	rmi_i2c = devm_kzalloc(&client->dev, sizeof(struct rmi_i2c_xport),
+				GFP_KERNEL);
+	if (!rmi_i2c)
+		return -ENOMEM;
+
+	pdata = &rmi_i2c->xport.pdata;
+
+	if (!client->dev.of_node)
+		*pdata = *client_pdata;
 
 	dev_dbg(&client->dev, "Probing %s at %#02x.\n",
 		pdata->sensor_name ? pdata->sensor_name : "-no name-",
@@ -206,11 +221,6 @@ static int rmi_i2c_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	rmi_i2c = devm_kzalloc(&client->dev, sizeof(struct rmi_i2c_xport),
-				GFP_KERNEL);
-	if (!rmi_i2c)
-		return -ENOMEM;
-
 	rmi_i2c->client = client;
 	mutex_init(&rmi_i2c->page_mutex);
 
@@ -262,7 +272,8 @@ MODULE_DEVICE_TABLE(i2c, rmi_id);
 static struct i2c_driver rmi_i2c_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
-		.name	= "rmi_i2c"
+		.name	= "rmi_i2c",
+		.of_match_table = of_match_ptr(rmi_i2c_of_match),
 	},
 	.id_table	= rmi_id,
 	.probe		= rmi_i2c_probe,
-- 
2.1.4

