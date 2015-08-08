From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] Input: synaptics-rmi4: Add device tree support for RMI4 I2C devices
Date: Fri, 7 Aug 2015 17:37:49 -0700
Message-ID: <1438994270-29809-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:27138 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946435AbbHHAh6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2015 20:37:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

Add devicetree binding for I2C devices and add bindings for optional
parameters in the function drivers.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
I saw Benjamin Tissoires's email about the lack of a devicetree implementation
for rmi_i2c.c. I decided to clean up and add documentation to the implementaion
which I have been using and submit it for review.

This patch applies to the current implementation of Dmitry's synaptics-rmi4
branch in the input repository. If Benjamin's patchset gets applied before
this I can rebase this patch.

Thanks,
Andrew

 .../devicetree/bindings/input/rmi4/rmi_f01.txt     |  34 ++++++
 .../devicetree/bindings/input/rmi4/rmi_f11.txt     |  51 ++++++++
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |  40 +++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/input/rmi4/rmi_bus.c                       |  49 ++++++++
 drivers/input/rmi4/rmi_bus.h                       |   8 +-
 drivers/input/rmi4/rmi_driver.c                    |  46 ++++++-
 drivers/input/rmi4/rmi_f01.c                       |  50 +++++++-
 drivers/input/rmi4/rmi_f11.c                       | 133 ++++++++++++++++++++-
 drivers/input/rmi4/rmi_i2c.c                       |  60 +++++++++-
 include/linux/rmi.h                                |   2 +-
 11 files changed, 465 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f11.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
new file mode 100644
index 0000000..53846e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
@@ -0,0 +1,34 @@
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
+- syna,f01-nosleep: If set the device will run at full power without sleeping.
+- syna,f01-wakeup-threshold: Defines the amplitude of the disturbance to the
+				background capacitance that will cause the
+				device to wake from dozing.
+- syna,f01-doze-holdoff: The delay to wait after the last finger lift and the
+				first doze cycle (in 0.1 second units).
+- syna,f01-doze-interval: The time period that the device sleeps between finger
+				activity (in 10 ms units).
+
+
+Example of a RMI4 I2C device with F01:
+	&i2c1 {
+		rmi-i2c-dev@2c {
+			compatible = "syna,rmi-i2c";
+			reg = <0x2c>;
+			syna,sensor-name="TM1949";
+			syna,attn-gpio = <4 2>;
+			syna,attn-polarity = <0>;
+			syna,level-triggered = <1>;
+			syna,f01-nosleep = <1>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_f11.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_f11.txt
new file mode 100644
index 0000000..2405523
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_f11.txt
@@ -0,0 +1,51 @@
+Synaptics RMI4 F11 Device Binding
+
+The Synaptics RMI4 core is able to support RMI4 devices using differnet
+transports and differnet functions. This file describes the device tree
+bindings for devices which contain Function 11. Complete documentation
+for transports and other functions can be found in:
+Documentation/devicetree/bindings/input/rmi4.
+
+RMI4 Function 11 is for 2D touch position sensing. Additional documentation for
+F11 can be found at:
+http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
+
+Optional Properties:
+- syna,f11-swap-axes: Swap X and Y positions when reporting.
+- syna,f11-flip-x: Reverse the direction of X.
+- syna,f11-flip-y: Reverse the direction of Y.
+- syna,f11-clip-x-low: Sets a minimum value for X.
+- syna,f11-clip-y-low: Sets a minimum value for Y.
+- syna,f11-clip-x-high: Sets a maximum value for X.
+- syna,f11-clip-y-high: Sets a maximum value for Y.
+- syna,f11-offset-x: Add an offset to X.
+- syna,f11-offset_y: Add an offset to Y.
+- syna,f11-delta-x-threshold: Set the minimum distance on the X axis required
+				to generate an interrupt in reduced reporting
+				mode.
+- syna,f11-delta-y-threshold: Set the minimum distance on the Y axis required
+				to generate an interrupt in reduced reporting
+				mode.
+- syna,f11-type-a: Report type A multitouch events.
+- syna,f11-sensor-type: Set the sensor type. 1 for touchscreen 2 for touchpad.
+- syna,f11-x-mm: The length in millimeters of the X axis.
+- syna,f11-y-mm: The length in millimeters of the Y axis.
+- syna,f11-disable-report-mask: Mask for disabling posiiton reporting. Used to
+				disable reporing absolute position data.
+- syna,f11-rezero-wait: Time in miliseconds to wait after issuing a rezero
+				command.
+
+
+Example of a RMI4 I2C device with F11:
+	&i2c1 {
+		rmi-i2c-dev@2c {
+			compatible = "syna,rmi-i2c";
+			reg = <0x2c>;
+			syna,sensor-name="TM1949";
+			syna,attn-gpio = <4 2>;
+			syna,attn-polarity = <0>;
+			syna,level-triggered = <1>;
+			syna,f11-flip-y = <1>;
+			syna,f11-sensor-type = <2>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
new file mode 100644
index 0000000..f27c965
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
@@ -0,0 +1,40 @@
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
+
+Optional Properties:
+- syna,sensor-name: The string containing the name of the sensor.
+- syna,attn-gpio: The GPIO number used to assert attention.
+- syna,attn-polarity: The polarity of the attention GPIO.
+- syna,level-triggered: Set to 1 if attention GPIO is level triggered, 0 if
+			edge triggered.
+- syna,poll-interval-ms: The interval in milliseconds to wait between reading
+			interrupts when the driver is polling.
+- syna,reset-delay-ms: The number of milliseconds to wait after resetting the
+			device.
+- syna,f01-*: Additional parameters specific to RMI4 function 1
+		see Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt.
+- syna,f11-*: Additional parameters specific to RMI4 function 11
+		see Documentation/devicetree/bindings/input/rmi4/rmi_f11.txt.
+
+
+Example:
+	&i2c1 {
+		rmi-i2c-dev@2c {
+			compatible = "syna,rmi-i2c";
+			reg = <0x2c>;
+			syna,sensor-name="TM1949";
+			syna,attn-gpio = <4 2>;
+			syna,attn-polarity = <0>;
+			syna,level-triggered = <1>;
+			syna,f11-flip-y = <1>;
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
index 6e0454a..611c748 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/debugfs.h>
+#include <linux/of.h>
 #include "rmi_bus.h"
 #include "rmi_driver.h"
 
@@ -335,6 +336,54 @@ struct bus_type rmi_bus_type = {
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
+	u32 val = 0;
+
+	retval = rmi_of_property_read_u32(dev, &val, prop, optional);
+	if (retval)
+		return retval;
+	*result = val;
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(rmi_of_property_read_u16);
+
+int rmi_of_property_read_u8(struct device *dev, u8 *result,
+				const char *prop, bool optional)
+{
+	int retval;
+	u32 val = 0;
+
+	retval = rmi_of_property_read_u32(dev, &val, prop, optional);
+	if (retval)
+		return retval;
+	*result = val;
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(rmi_of_property_read_u8);
+
 #ifdef CONFIG_RMI4_DEBUG
 
 static void rmi_bus_setup_debugfs(void)
diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index d4cfc85..4cafeeb 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -223,7 +223,7 @@ struct rmi_device {
 
 #define to_rmi_device(d) container_of(d, struct rmi_device, dev)
 
-static inline const struct rmi_device_platform_data *
+static inline struct rmi_device_platform_data *
 rmi_get_platform_data(struct rmi_device *d)
 {
 	return dev_get_platdata(d->xport->dev);
@@ -314,4 +314,10 @@ int rmi_for_each_dev(void *data, int (*func)(struct device *dev, void *data));
 
 extern struct bus_type rmi_bus_type;
 
+int rmi_of_property_read_u32(struct device *dev, u32 *result,
+				const char *prop, bool optional);
+int rmi_of_property_read_u16(struct device *dev, u16 *result,
+				const char *prop, bool optional);
+int rmi_of_property_read_u8(struct device *dev, u8 *result,
+				const char *prop, bool optional);
 #endif
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index b9db709..0f86fdb 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -732,11 +732,49 @@ static int rmi_driver_remove(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static int rmi_driver_of_probe(struct device *dev,
+				struct rmi_device_platform_data *pdata)
+{
+	u32 val;
+	int retval;
+
+	retval = rmi_of_property_read_u32(dev, &pdata->attn_polarity,
+					"syna,attn-polarity", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev, &val,
+					"syna,level-triggered", 1);
+	if (retval)
+		return retval;
+	pdata->level_triggered = !!val;
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
@@ -756,6 +794,12 @@ static int rmi_driver_probe(struct device *dev)
 
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
index ee5f4a1..7793df7 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -12,6 +12,7 @@
 #include <linux/rmi.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/of.h>
 #include "rmi_driver.h"
 
 #define RMI_PRODUCT_ID_LENGTH    10
@@ -176,16 +177,63 @@ static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static int rmi_f01_of_probe(struct device *dev,
+				struct rmi_device_platform_data *pdata)
+{
+	int retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->power_management.nosleep,
+			"syna,f01-nosleep", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->power_management.wakeup_threshold,
+			"syna,f01-wakeup-threshold", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->power_management.doze_holdoff,
+			"syna,f01-doze-holdoff", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->power_management.doze_interval,
+			"syna,f01-doze-interval", 1);
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
+	if (rmi_dev->xport->dev->of_node) {
+		retval = rmi_f01_of_probe(rmi_dev->xport->dev, pdata);
+		if (retval)
+			return retval;
+	}
 
 	f01 = devm_kzalloc(&fn->dev, sizeof(struct f01_data), GFP_KERNEL);
 	if (!f01) {
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 7af4f68..bffd7a7 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -15,6 +15,7 @@
 #include <linux/kconfig.h>
 #include <linux/rmi.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include "rmi_driver.h"
 
 #define F11_MAX_NUM_OF_FINGERS		10
@@ -1206,6 +1207,124 @@ static void f11_set_abs_params(struct rmi_function *fn, struct f11_data *f11)
 				     0, MT_TOOL_FINGER, 0, 0);
 }
 
+#ifdef CONFIG_OF
+static int rmi_f11_of_initialize(struct device *dev,
+				struct rmi_device_platform_data *pdata)
+{
+	u32 val;
+	int retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			&pdata->f11_sensor_data->axis_align.swap_axes,
+			"syna,f11-swap-axes", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			&pdata->f11_sensor_data->axis_align.flip_x,
+			"syna,f11-flip-x", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			&pdata->f11_sensor_data->axis_align.flip_y,
+			"syna,f11-flip-y", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->f11_sensor_data->axis_align.clip_x_low,
+			"syna,f11-clip-x-low", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->f11_sensor_data->axis_align.clip_y_low,
+			"syna,f11-clip-y-low", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->f11_sensor_data->axis_align.clip_x_high,
+			"syna,f11-clip-x-high", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->f11_sensor_data->axis_align.clip_y_high,
+			"syna,f11-clip-y-high", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->f11_sensor_data->axis_align.offset_x,
+			"syna,f11-offset-x", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->f11_sensor_data->axis_align.offset_y,
+			"syna,f11-offset_y", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->f11_sensor_data->axis_align.delta_x_threshold,
+			"syna,f11-delta-x-threshold", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->f11_sensor_data->axis_align.delta_y_threshold,
+			"syna,f11-delta-y-threshold", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev, &val,
+			"syna,f11-type-a", 1);
+	if (retval)
+		return retval;
+	pdata->f11_sensor_data->type_a = !!val;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->f11_sensor_data->sensor_type,
+			"syna,f11-sensor-type", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->f11_sensor_data->x_mm,
+			"syna,f11-x-mm", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->f11_sensor_data->y_mm,
+			"syna,f11-y-mm", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->f11_sensor_data->disable_report_mask,
+			"syna,f11-disable-report-mask", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev, &pdata->f11_rezero_wait,
+			"syna,f11-rezero-wait", 1);
+	if (retval)
+		return retval;
+
+	return 0;
+}
+#else
+static inline int rmi_f11_of_initialize(struct device *dev,
+					struct rmi_device_platform_data *pdata)
+{
+	return -ENODEV;
+}
+#endif
+
 static int rmi_f11_initialize(struct rmi_function *fn)
 {
 	struct rmi_device *rmi_dev = fn->rmi_dev;
@@ -1216,7 +1335,7 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	u16 control_base_addr;
 	u16 max_x_pos, max_y_pos, temp;
 	int rc;
-	const struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
+	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	struct f11_2d_sensor *sensor;
 	u8 buf;
@@ -1225,6 +1344,18 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	dev_dbg(&fn->dev, "Initializing F11 values for %s.\n",
 		 pdata->sensor_name);
 
+	if (rmi_dev->xport->dev->of_node) {
+		pdata->f11_sensor_data = kzalloc(
+				sizeof(struct rmi_f11_sensor_data),
+				GFP_KERNEL);
+		if (!pdata->f11_sensor_data)
+			return -ENOMEM;
+
+		rc = rmi_f11_of_initialize(rmi_dev->xport->dev, pdata);
+		if (rc)
+			return rc;
+	}
+
 	mask_size = BITS_TO_LONGS(drvdata->irq_count) * sizeof(unsigned long);
 
 	/*
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index 24d8a04..e3b91d6 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/rmi.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include "rmi_driver.h"
 
 #define BUFFER_SIZE_INCREMENT 32
@@ -183,17 +184,67 @@ static const struct rmi_transport_ops rmi_i2c_ops = {
 	.read_block	= rmi_i2c_read_block,
 };
 
+#ifdef CONFIG_OF
+static int rmi_i2c_of_probe(struct i2c_client *client,
+				struct rmi_device_platform_data *pdata)
+{
+	struct device *dev = &client->dev;
+	int retval;
+
+	retval = of_property_read_string(dev->of_node, "syna,sensor-name",
+						&pdata->sensor_name);
+	if (retval && retval != -EINVAL) {
+		dev_err(&client->dev, "Failed to get sensor name: %d\n",
+			retval);
+		return retval;
+	}
+
+	retval = rmi_of_property_read_u32(dev, &pdata->attn_gpio,
+						"syna,attn-gpio", 1);
+	if (retval)
+		return -ENODEV;
+
+	return 0;
+}
+
+static const struct of_device_id rmi_i2c_of_match[] = {
+	{ .compatible = "syna,rmi-i2c" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rmi_i2c_of_match);
+#else
+static inline int rmi_i2c_of_probe(struct i2c_client *client,
+					struct rmi_device_platform_data *pdata)
+{
+	return -ENODEV;
+}
+#endif
+
 static int rmi_i2c_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	const struct rmi_device_platform_data *pdata =
+	struct rmi_device_platform_data *pdata =
 				dev_get_platdata(&client->dev);
 	struct rmi_i2c_xport *rmi_i2c;
 	int retval;
 
 	if (!pdata) {
-		dev_err(&client->dev, "no platform data\n");
-		return -EINVAL;
+		if (client->dev.of_node) {
+			pdata = kzalloc(
+				sizeof(struct rmi_device_platform_data),
+				GFP_KERNEL);
+			if (!pdata)
+				return -ENOMEM;
+
+			retval = rmi_i2c_of_probe(client, pdata);
+			if (retval)
+				return retval;
+
+			client->dev.platform_data = pdata;
+		} else {
+			dev_err(&client->dev, "no platform data\n");
+			return -EINVAL;
+		}
 	}
 
 	dev_dbg(&client->dev, "Probing %s at %#02x (GPIO %d).\n",
@@ -280,7 +331,8 @@ MODULE_DEVICE_TABLE(i2c, rmi_id);
 static struct i2c_driver rmi_i2c_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
-		.name	= "rmi_i2c"
+		.name	= "rmi_i2c",
+		.of_match_table = of_match_ptr(rmi_i2c_of_match),
 	},
 	.id_table	= rmi_id,
 	.probe		= rmi_i2c_probe,
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index ca35b2f..ae77e71 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -254,7 +254,7 @@ struct rmi_device_platform_data_spi {
  * functions.
  */
 struct rmi_device_platform_data {
-	char *sensor_name;	/* Used for diagnostics. */
+	const char *sensor_name;	/* Used for diagnostics. */
 
 	int attn_gpio;
 	enum rmi_attn_polarity attn_polarity;
-- 
2.1.4

