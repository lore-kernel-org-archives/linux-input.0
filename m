From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v4 05/10] Input: synaptics-rmi4: Add device tree support for 2d sensors and F11
Date: Tue, 9 Feb 2016 17:41:36 -0800
Message-ID: <1455068496-12113-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

2D sensors have several parameter which can be set in the platform data.
This patch adds support for getting those values from devicetree.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 .../bindings/input/rmi4/rmi_2d_sensor.txt          |  56 +++++++++++
 .../bindings/input/touchscreen/touchscreen.txt     |   2 +
 drivers/input/rmi4/rmi_2d_sensor.c                 | 108 +++++++++++++++++++++
 drivers/input/rmi4/rmi_2d_sensor.h                 |   3 +
 drivers/input/rmi4/rmi_f11.c                       |   7 +-
 5 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
new file mode 100644
index 0000000..6354915
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
@@ -0,0 +1,56 @@
+Synaptics RMI4 2D Sensor Device Binding
+
+The Synaptics RMI4 core is able to support RMI4 devices using different
+transports and different functions. This file describes the device tree
+bindings for devices which contain 2D sensors using Function 11 or
+Function 12. Complete documentation for transports and other functions
+can be found in:
+Documentation/devicetree/bindings/input/rmi4.
+
+RMI4 Function 11 and Function 12 are for 2D touch position sensing.
+Additional documentation for F11 can be found at:
+http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
+
+Optional Touch Properties:
+Description in Documentation/devicetree/bindings/input/touch
+- touchscreen-inverted-x
+- touchscreen-inverted-y
+- touchscreen-swapped-x-y
+- touchscreen-mm-x
+- touchscreen-mm-y
+
+Optional Properties:
+- syna,clip-x-low: Sets a minimum value for X.
+- syna,clip-y-low: Sets a minimum value for Y.
+- syna,clip-x-high: Sets a maximum value for X.
+- syna,clip-y-high: Sets a maximum value for Y.
+- syna,offset-x: Add an offset to X.
+- syna,offset-y: Add an offset to Y.
+- syna,delta-x-threshold: Set the minimum distance on the X axis required
+				to generate an interrupt in reduced reporting
+				mode.
+- syna,delta-y-threshold: Set the minimum distance on the Y axis required
+				to generate an interrupt in reduced reporting
+				mode.
+- syna,sensor-type: Set the sensor type. 1 for touchscreen 2 for touchpad.
+- syna,disable-report-mask: Mask for disabling posiiton reporting. Used to
+				disable reporing absolute position data.
+- syna,rezero-wait-ms: Time in miliseconds to wait after issuing a rezero
+				command.
+
+
+Example of a RMI4 I2C device with F11:
+Example:
+	&i2c1 {
+		rmi4-i2c-dev@2c {
+			compatible = "syna,rmi4-i2c";
+
+			...
+
+			rmi4-f11@11 {
+				reg = <0x11>;
+				touchscreen-inverted-y;
+				syna,sensor-type = <2>;
+			};
+		};
+	};
diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
index ac23caf..d6674de 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
@@ -18,6 +18,8 @@ Optional properties for Touchscreens:
  - touchscreen-inverted-y	: Y axis is inverted (boolean)
  - touchscreen-swapped-x-y	: X and Y axis are swapped (boolean)
 				  Swapping is done after inverting the axis
+ - touchscreen-mm-x		: horizontal length in mm of the touchscreen
+ - touchscreen-mm-y		: vertical length in mm of the touchscreen
 
 Deprecated properties for Touchscreens:
  - x-size			: deprecated name for touchscreen-size-x
diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index 8f48647..d84bc59 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -219,3 +219,111 @@ int rmi_2d_sensor_configure_input(struct rmi_function *fn,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rmi_2d_sensor_configure_input);
+
+#ifdef CONFIG_OF
+int rmi_2d_sensor_of_probe(struct device *dev,
+			struct rmi_2d_sensor_platform_data *pdata)
+{
+	int retval;
+	u32 val;
+
+	pdata->axis_align.swap_axes = of_property_read_bool(dev->of_node,
+						"touchscreen-swapped-x-y");
+
+	pdata->axis_align.flip_x = of_property_read_bool(dev->of_node,
+						"touchscreen-inverted-x");
+
+	pdata->axis_align.flip_y = of_property_read_bool(dev->of_node,
+						"touchscreen-inverted-y");
+
+	retval = rmi_of_property_read_u32(dev, &val, "syna,clip-x-low", 1);
+	if (retval)
+		return retval;
+
+	pdata->axis_align.clip_x_low = val;
+
+	retval = rmi_of_property_read_u32(dev, &val, "syna,clip-y-low",	1);
+	if (retval)
+		return retval;
+
+	pdata->axis_align.clip_y_low = val;
+
+	retval = rmi_of_property_read_u32(dev, &val, "syna,clip-x-high", 1);
+	if (retval)
+		return retval;
+
+	pdata->axis_align.clip_x_high = val;
+
+	retval = rmi_of_property_read_u32(dev, &val, "syna,clip-y-high", 1);
+	if (retval)
+		return retval;
+
+	pdata->axis_align.clip_y_high = val;
+
+	retval = rmi_of_property_read_u32(dev, &val, "syna,offset-x", 1);
+	if (retval)
+		return retval;
+
+	pdata->axis_align.offset_x = val;
+
+	retval = rmi_of_property_read_u32(dev, &val, "syna,offset-y", 1);
+	if (retval)
+		return retval;
+
+	pdata->axis_align.offset_y = val;
+
+	retval = rmi_of_property_read_u32(dev, &val, "syna,delta-x-threshold",
+						1);
+	if (retval)
+		return retval;
+
+	pdata->axis_align.delta_x_threshold = val;
+
+	retval = rmi_of_property_read_u32(dev, &val, "syna,delta-y-threshold",
+						1);
+	if (retval)
+		return retval;
+
+	pdata->axis_align.delta_y_threshold = val;
+
+	retval = rmi_of_property_read_u32(dev, (u32 *)&pdata->sensor_type,
+			"syna,sensor-type", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev, &val, "touchscreen-mm-x", 1);
+	if (retval)
+		return retval;
+
+	pdata->x_mm = val;
+
+	retval = rmi_of_property_read_u32(dev, &val, "touchscreen-mm-y", 1);
+	if (retval)
+		return retval;
+
+	pdata->y_mm = val;
+
+	retval = rmi_of_property_read_u32(dev, &val,
+				"syna,disable-report-mask", 1);
+	if (retval)
+		return retval;
+
+	pdata->disable_report_mask = val;
+
+	retval = rmi_of_property_read_u32(dev, &val, "syna,rezero-wait-ms",
+						1);
+	if (retval)
+		return retval;
+
+	pdata->rezero_wait = val;
+
+	return 0;
+}
+#else
+inline int rmi_2d_sensor_of_probe(struct device *dev,
+			struct rmi_2d_sensor_platform_data *pdata)
+{
+	return -ENODEV;
+}
+#endif
+EXPORT_SYMBOL_GPL(rmi_2d_sensor_of_probe);
diff --git a/drivers/input/rmi4/rmi_2d_sensor.h b/drivers/input/rmi4/rmi_2d_sensor.h
index 6a715d3..77fcdfe 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.h
+++ b/drivers/input/rmi4/rmi_2d_sensor.h
@@ -69,6 +69,9 @@ struct rmi_2d_sensor {
 	u8 y_mm;
 };
 
+int rmi_2d_sensor_of_probe(struct device *dev,
+				struct rmi_2d_sensor_platform_data *pdata);
+
 void rmi_2d_sensor_abs_process(struct rmi_2d_sensor *sensor,
 				struct rmi_2d_sensor_abs_object *obj,
 				int slot);
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 948a360b..77a5eb8 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1059,8 +1059,13 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	if (!f11)
 		return -ENOMEM;
 
-	if (pdata->sensor_pdata)
+	if (fn->dev.of_node) {
+		rc = rmi_2d_sensor_of_probe(&fn->dev, &f11->sensor_pdata);
+		if (rc)
+			return rc;
+	} else if (pdata->sensor_pdata) {
 		f11->sensor_pdata = *pdata->sensor_pdata;
+	}
 
 	f11->rezero_wait_ms = f11->sensor_pdata.rezero_wait;
 
-- 
2.5.0
