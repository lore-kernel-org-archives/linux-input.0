From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 05/10] Input: synaptics-rmi4: Add device tree support for 2d sensors and F11
Date: Wed, 25 Nov 2015 16:09:13 -0800
Message-ID: <1448496553-25208-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

2D sensors have several parameter which can be set in the platform data.
This patch adds support for getting those values from devicetree.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 .../bindings/input/rmi4/rmi_2d_sensor.txt          |  54 +++++++++++
 drivers/input/rmi4/rmi_2d_sensor.c                 | 103 +++++++++++++++++++++
 drivers/input/rmi4/rmi_2d_sensor.h                 |   3 +
 drivers/input/rmi4/rmi_f11.c                       |   7 +-
 4 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
new file mode 100644
index 0000000..bbff31b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
@@ -0,0 +1,54 @@
+Synaptics RMI4 2D Sensor Device Binding
+
+The Synaptics RMI4 core is able to support RMI4 devices using differnet
+transports and differnet functions. This file describes the device tree
+bindings for devices which contain 2D sensors using Function 11 or
+Function 12. Complete documentation for transports and other functions
+can be found in:
+Documentation/devicetree/bindings/input/rmi4.
+
+RMI4 Function 11 and Function 12 are for 2D touch position sensing.
+Additional documentation for F11 can be found at:
+http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
+
+Optional Properties:
+- syna,swap-axes: Swap X and Y positions when reporting (boolean).
+- syna,flip-x: Reverse the direction of X (boolean).
+- syna,flip-y: Reverse the direction of Y (boolean).
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
+				syna,flip-y;
+				syna,sensor-type = <2>;
+			};
+		};
+	};
diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index e3c7b7f..427d325 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -218,3 +218,106 @@ int rmi_2d_sensor_configure_input(struct rmi_function *fn,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rmi_2d_sensor_configure_input);
+
+#ifdef CONFIG_OF
+int rmi_2d_sensor_of_probe(struct device *dev,
+			struct rmi_2d_sensor_platform_data *pdata)
+{
+	int retval;
+
+	pdata->axis_align.swap_axes = of_property_read_bool(dev->of_node,
+						"syna,swap-axes");
+
+	pdata->axis_align.flip_x = of_property_read_bool(dev->of_node,
+						"syna,flip-x");
+
+	pdata->axis_align.flip_y = of_property_read_bool(dev->of_node,
+						"syna,flip-y");
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->axis_align.clip_x_low,
+			"syna,clip-x-low", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->axis_align.clip_y_low,
+			"syna,clip-y-low", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->axis_align.clip_x_high,
+			"syna,clip-x-high", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->axis_align.clip_y_high,
+			"syna,clip-y-high", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->axis_align.offset_x,
+			"syna,offset-x", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->axis_align.offset_y,
+			"syna,offset_y", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->axis_align.delta_x_threshold,
+			"syna,delta-x-threshold", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->axis_align.delta_y_threshold,
+			"syna,delta-y-threshold", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->sensor_type,
+			"syna,sensor-type", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->x_mm,
+			"syna,x-mm", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->y_mm,
+			"syna,y-mm", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->disable_report_mask,
+			"syna,disable-report-mask", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev, &pdata->rezero_wait,
+			"syna,rezero-wait", 1);
+	if (retval)
+		return retval;
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
index bc31351..0ee817e 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.h
+++ b/drivers/input/rmi4/rmi_2d_sensor.h
@@ -70,6 +70,9 @@ struct rmi_2d_sensor {
 	u8 y_mm;
 };
 
+int rmi_2d_sensor_of_probe(struct device *dev,
+				struct rmi_2d_sensor_platform_data *pdata);
+
 void rmi_2d_sensor_abs_process(struct rmi_2d_sensor *sensor,
 				struct rmi_2d_sensor_abs_object *obj,
 				int slot);
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 0d1e0e5..fa8e333 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1078,8 +1078,13 @@ static int rmi_f11_initialize(struct rmi_function *fn)
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
