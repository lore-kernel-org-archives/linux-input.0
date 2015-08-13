From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v2] Input: synaptics-rmi4: Add device tree support for RMI4 I2C devices
Date: Thu, 13 Aug 2015 12:12:07 -0700
Message-ID: <1439493127-15147-2-git-send-email-aduggan@synaptics.com>
References: <1439493127-15147-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439493127-15147-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

Add devicetree binding for I2C devices and add bindings for optional
parameters in the function drivers. Parameters for function drivers are
defined in child nodes for each of the functions.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
This version depends on the "Use generic interrupt handling" patch so that
it can leverage the generic interrupt bindings.

Thanks,
Andrew

 .../devicetree/bindings/input/rmi4/rmi_f01.txt     |  37 ++++++
 .../devicetree/bindings/input/rmi4/rmi_f11.txt     |  54 +++++++++
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |  51 ++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/input/rmi4/rmi_bus.c                       |  70 +++++++++++
 drivers/input/rmi4/rmi_bus.h                       |   8 +-
 drivers/input/rmi4/rmi_driver.c                    |  34 +++++-
 drivers/input/rmi4/rmi_f01.c                       |  50 +++++++-
 drivers/input/rmi4/rmi_f11.c                       | 133 ++++++++++++++++++++-
 drivers/input/rmi4/rmi_i2c.c                       |  58 ++++++++-
 include/linux/rmi.h                                |   2 +-
 11 files changed, 489 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f11.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
new file mode 100644
index 0000000..63a1793
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
@@ -0,0 +1,37 @@
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
+- syna,nosleep: If set the device will run at full power without sleeping.
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
+				syna,nosleep = <1>;
+			};
+		};
+	};
+
diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_f11.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_f11.txt
new file mode 100644
index 0000000..8236a1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_f11.txt
@@ -0,0 +1,54 @@
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
+- syna,swap-axes: Swap X and Y positions when reporting.
+- syna,flip-x: Reverse the direction of X.
+- syna,flip-y: Reverse the direction of Y.
+- syna,clip-x-low: Sets a minimum value for X.
+- syna,clip-y-low: Sets a minimum value for Y.
+- syna,clip-x-high: Sets a maximum value for X.
+- syna,clip-y-high: Sets a maximum value for Y.
+- syna,offset-x: Add an offset to X.
+- syna,offset_y: Add an offset to Y.
+- syna,delta-x-threshold: Set the minimum distance on the X axis required
+				to generate an interrupt in reduced reporting
+				mode.
+- syna,delta-y-threshold: Set the minimum distance on the Y axis required
+				to generate an interrupt in reduced reporting
+				mode.
+- syna,type-a: Report type A multitouch events.
+- syna,sensor-type: Set the sensor type. 1 for touchscreen 2 for touchpad.
+- syna,x-mm: The length in millimeters of the X axis.
+- syna,y-mm: The length in millimeters of the Y axis.
+- syna,disable-report-mask: Mask for disabling posiiton reporting. Used to
+				disable reporing absolute position data.
+- syna,rezero-wait: Time in miliseconds to wait after issuing a rezero
+				command.
+
+
+Example of a RMI4 I2C device with F11:
+Example:
+	&i2c1 {
+		rmi-i2c-dev@2c {
+			compatible = "syna,rmi-i2c";
+
+			...
+
+			rmi-f11@11 {
+				reg = <0x11>;
+				syna,flip-y = <1>;
+				syna,sensor-type = <2>;
+			};
+		};
+	};
+
diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
new file mode 100644
index 0000000..e3fcacd
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
@@ -0,0 +1,51 @@
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
+- interrupts: interrupt which the rmi device is connected to.
+- interrupt-parent: The interrupt controller.
+See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+- syna,sensor-name: The string containing the name of the sensor.
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
+			interrupt-parent = <&gpio>;
+			interrupts = <4 2>;
+			syna,sensor-name="TM1949";
+
+			rmi-f01@1 {
+				reg = <0x1>;
+				syna,f01-nosleep = <1>;
+			};
+
+			rmi-f11@11 {
+				reg = <0x11>;
+				syna,f11-flip-y = <1>;
+				syna,f11-sensor-type = <2>;
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
index 6e0454a..26f9f17 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/debugfs.h>
+#include <linux/of.h>
 #include "rmi_bus.h"
 #include "rmi_driver.h"
 
@@ -203,6 +204,21 @@ static int rmi_function_match(struct device *dev, struct device_driver *drv)
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
@@ -210,6 +226,8 @@ static int rmi_function_probe(struct device *dev)
 					to_rmi_function_handler(dev->driver);
 	int error;
 
+	rmi_function_of_probe(fn);
+
 	if (handler->probe) {
 		error = handler->probe(fn);
 		return error;
@@ -267,6 +285,10 @@ void rmi_unregister_function(struct rmi_function *fn)
 {
 	device_del(&fn->dev);
 	rmi_function_teardown_debugfs(fn);
+
+	if (fn->dev.of_node)
+		of_node_put(fn->dev.of_node);
+
 	put_device(&fn->dev);
 }
 
@@ -335,6 +357,54 @@ struct bus_type rmi_bus_type = {
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
index 4e3bca3..2241bd8 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -226,7 +226,7 @@ struct rmi_device {
 
 #define to_rmi_device(d) container_of(d, struct rmi_device, dev)
 
-static inline const struct rmi_device_platform_data *
+static inline struct rmi_device_platform_data *
 rmi_get_platform_data(struct rmi_device *d)
 {
 	return dev_get_platdata(d->xport->dev);
@@ -317,4 +317,10 @@ int rmi_for_each_dev(void *data, int (*func)(struct device *dev, void *data));
 
 extern struct bus_type rmi_bus_type;
 
+int rmi_of_property_read_u32(struct device *dev, u32 *result,
+				const char *prop, bool optional);
+int rmi_of_property_read_u16(struct device *dev, u16 *result,
+				const char *prop, bool optional);
+int rmi_of_property_read_u8(struct device *dev, u8 *result,
+				const char *prop, bool optional);
 #endif
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 585bd7b..67cd7fa 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -717,11 +717,37 @@ static int rmi_driver_remove(struct device *dev)
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
@@ -741,6 +767,12 @@ static int rmi_driver_probe(struct device *dev)
 
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
index ee5f4a1..9882593 100644
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
+			"syna,nosleep", 1);
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
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 7af4f68..56add28 100644
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
+			"syna,swap-axes", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			&pdata->f11_sensor_data->axis_align.flip_x,
+			"syna,flip-x", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			&pdata->f11_sensor_data->axis_align.flip_y,
+			"syna,flip-y", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->f11_sensor_data->axis_align.clip_x_low,
+			"syna,clip-x-low", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->f11_sensor_data->axis_align.clip_y_low,
+			"syna,clip-y-low", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->f11_sensor_data->axis_align.clip_x_high,
+			"syna,clip-x-high", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->f11_sensor_data->axis_align.clip_y_high,
+			"syna,clip-y-high", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->f11_sensor_data->axis_align.offset_x,
+			"syna,offset-x", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->f11_sensor_data->axis_align.offset_y,
+			"syna,offset_y", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->f11_sensor_data->axis_align.delta_x_threshold,
+			"syna,delta-x-threshold", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->f11_sensor_data->axis_align.delta_y_threshold,
+			"syna,delta-y-threshold", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev, &val,
+			"syna,type-a", 1);
+	if (retval)
+		return retval;
+	pdata->f11_sensor_data->type_a = !!val;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->f11_sensor_data->sensor_type,
+			"syna,sensor-type", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->f11_sensor_data->x_mm,
+			"syna,x-mm", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->f11_sensor_data->y_mm,
+			"syna,y-mm", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->f11_sensor_data->disable_report_mask,
+			"syna,disable-report-mask", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev, &pdata->f11_rezero_wait,
+			"syna,rezero-wait", 1);
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
 
+	if (fn->dev.of_node) {
+		pdata->f11_sensor_data = kzalloc(
+				sizeof(struct rmi_f11_sensor_data),
+				GFP_KERNEL);
+		if (!pdata->f11_sensor_data)
+			return -ENOMEM;
+
+		rc = rmi_f11_of_initialize(&fn->dev, pdata);
+		if (rc)
+			return rc;
+	}
+
 	mask_size = BITS_TO_LONGS(drvdata->irq_count) * sizeof(unsigned long);
 
 	/*
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index cf537c9..ab44e14 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/rmi.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include "rmi_driver.h"
 
 #define BUFFER_SIZE_INCREMENT 32
@@ -183,17 +184,65 @@ static const struct rmi_transport_ops rmi_i2c_ops = {
 	.read_block	= rmi_i2c_read_block,
 };
 
+#ifdef CONFIG_OF
+static int rmi_i2c_of_probe(struct i2c_client *client,
+				struct rmi_device_platform_data *pdata)
+{
+	struct device *dev = &client->dev;
+	int retval;
+
+	dev_info(&client->dev, "%s: client dev of_node: %s (%p)\n", __func__,
+		dev->of_node->name, dev->of_node);
+
+	retval = of_property_read_string(dev->of_node, "syna,sensor-name",
+						&pdata->sensor_name);
+	if (retval && retval != -EINVAL) {
+		dev_err(&client->dev, "Failed to get sensor name: %d\n",
+			retval);
+		return retval;
+	}
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
 
 	dev_dbg(&client->dev, "Probing %s at %#02x.\n",
@@ -261,7 +310,8 @@ MODULE_DEVICE_TABLE(i2c, rmi_id);
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
index 2f3c79d..1dd0591 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -241,7 +241,7 @@ struct rmi_device_platform_data_spi {
  * functions.
  */
 struct rmi_device_platform_data {
-	char *sensor_name;	/* Used for diagnostics. */
+	const char *sensor_name;	/* Used for diagnostics. */
 
 	int poll_interval_ms;
 
-- 
2.1.4
