From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 08/26] Input: synaptics-rmi4 - f11: use the unified input node if available
Date: Thu, 5 Nov 2015 15:38:47 -0800
Message-ID: <1446766727-30578-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_f11.c | 60 ++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 7fd808f..dbe2681 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -34,7 +34,6 @@
 #define DEFAULT_MAX_ABS_MT_ORIENTATION 1
 #define DEFAULT_MIN_ABS_MT_TRACKING_ID 1
 #define DEFAULT_MAX_ABS_MT_TRACKING_ID 10
-#define NAME_BUFFER_SIZE 256
 #define FUNCTION_NUMBER 0x11
 
 /** A note about RMI4 F11 register structure.
@@ -518,6 +517,7 @@ struct f11_2d_sensor {
 	u32 type_a;	/* boolean but debugfs API requires u32 */
 	enum rmi_f11_sensor_type sensor_type;
 	struct input_dev *input;
+	bool unified_input;
 	struct rmi_function *fn;
 	char input_phys[NAME_BUFFER_SIZE];
 	u8 report_abs;
@@ -737,7 +737,8 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 	}
 
 	input_mt_sync_frame(sensor->input);
-	input_sync(sensor->input);
+	if (!sensor->unified_input)
+		input_sync(sensor->input);
 }
 
 static int f11_2d_construct_data(struct f11_2d_sensor *sensor)
@@ -1373,35 +1374,42 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 static int rmi_f11_register_devices(struct rmi_function *fn)
 {
 	struct rmi_device *rmi_dev = fn->rmi_dev;
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
 	struct f11_data *f11 = dev_get_drvdata(&fn->dev);
 	struct input_dev *input_dev;
 	struct rmi_driver *driver = rmi_dev->driver;
 	struct f11_2d_sensor *sensor = &f11->sensor;
 	int rc;
 
-	input_dev = input_allocate_device();
+	if (!drv_data->input) {
+		input_dev = input_allocate_device();
+	} else {
+		input_dev = drv_data->input;
+		sensor->unified_input = true;
+	}
 	if (!input_dev) {
 		rc = -ENOMEM;
 		goto error_unregister;
 	}
 
 	sensor->input = input_dev;
-	if (driver->set_input_params) {
-		rc = driver->set_input_params(rmi_dev, input_dev);
-		if (rc < 0) {
-			dev_err(&fn->dev,
-				"%s: Error in setting input device.\n",
-				__func__);
-			goto error_unregister;
+
+	if (!sensor->unified_input) {
+		if (driver->set_input_params) {
+			rc = driver->set_input_params(rmi_dev, input_dev);
+			if (rc < 0) {
+				dev_err(&fn->dev,
+					"%s: Error in setting input device.\n",
+					__func__);
+				goto error_unregister;
+			}
 		}
+		sprintf(sensor->input_phys, "%s.abs/input0",
+			dev_name(&fn->dev));
+		input_dev->phys = sensor->input_phys;
+		input_dev->dev.parent = &rmi_dev->dev;
 	}
-	sprintf(sensor->input_phys, "%s.abs/input0",
-		dev_name(&fn->dev));
-	input_dev->phys = sensor->input_phys;
-	input_dev->dev.parent = &rmi_dev->dev;
-	input_set_drvdata(input_dev, f11);
 
-	set_bit(EV_SYN, input_dev->evbit);
 	set_bit(EV_ABS, input_dev->evbit);
 	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
 
@@ -1413,19 +1421,21 @@ static int rmi_f11_register_devices(struct rmi_function *fn)
 		set_bit(REL_X, input_dev->relbit);
 		set_bit(REL_Y, input_dev->relbit);
 	}
-	rc = input_register_device(input_dev);
-	if (rc) {
-		input_free_device(input_dev);
-		sensor->input = NULL;
-		goto error_unregister;
+	if (!sensor->unified_input) {
+		rc = input_register_device(input_dev);
+		if (rc) {
+			input_free_device(input_dev);
+			sensor->input = NULL;
+			goto error_unregister;
+		}
 	}
 
 	return 0;
 
 error_unregister:
-	if (f11->sensor.input) {
-		input_unregister_device(f11->sensor.input);
-		f11->sensor.input = NULL;
+	if (!sensor->unified_input && sensor->input) {
+		input_unregister_device(sensor->input);
+		sensor->input = NULL;
 	}
 
 	return rc;
@@ -1525,7 +1535,7 @@ static void rmi_f11_remove(struct rmi_function *fn)
 {
 	struct f11_data *f11 = dev_get_drvdata(&fn->dev);
 
-	if (f11->sensor.input)
+	if (!f11->sensor.unified_input && f11->sensor.input)
 		input_unregister_device(f11->sensor.input);
 }
 
-- 
2.1.4
