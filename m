From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 06/13] Input: synaptics-rmi4 - have only one struct platform data
Date: Tue, 29 Nov 2016 11:08:17 +0100
Message-ID: <1480414104-8524-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If struct rmi_device_platform_data contains pointers to other struct,
it gets difficult to allocate a fixed size struct and copy it over between
drivers.

Change the pointers into a struct and change the code in rmi4 accordingly.

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---
 drivers/input/rmi4/rmi_f11.c | 4 ++--
 drivers/input/rmi4/rmi_f12.c | 4 ++--
 drivers/input/rmi4/rmi_f30.c | 9 ++++-----
 include/linux/rmi.h          | 4 ++--
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 3401aac..44fc275 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1079,8 +1079,8 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 		rc = rmi_2d_sensor_of_probe(&fn->dev, &f11->sensor_pdata);
 		if (rc)
 			return rc;
-	} else if (pdata->sensor_pdata) {
-		f11->sensor_pdata = *pdata->sensor_pdata;
+	} else {
+		f11->sensor_pdata = pdata->sensor_pdata;
 	}
 
 	f11->rezero_wait_ms = f11->sensor_pdata.rezero_wait;
diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index d7255f1..82a4964 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -352,8 +352,8 @@ static int rmi_f12_probe(struct rmi_function *fn)
 		ret = rmi_2d_sensor_of_probe(&fn->dev, &f12->sensor_pdata);
 		if (ret)
 			return ret;
-	} else if (pdata->sensor_pdata) {
-		f12->sensor_pdata = *pdata->sensor_pdata;
+	} else {
+		f12->sensor_pdata = pdata->sensor_pdata;
 	}
 
 	ret = rmi_read_register_desc(rmi_dev, query_addr,
diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
index 485907f..f696137 100644
--- a/drivers/input/rmi4/rmi_f30.c
+++ b/drivers/input/rmi4/rmi_f30.c
@@ -196,7 +196,7 @@ static int rmi_f30_config(struct rmi_function *fn)
 				rmi_get_platform_data(fn->rmi_dev);
 	int error;
 
-	if (pdata->f30_data && pdata->f30_data->disable) {
+	if (pdata->f30_data.disable) {
 		drv->clear_irq_bits(fn->rmi_dev, fn->irq_mask);
 	} else {
 		/* Write Control Register values back to device */
@@ -355,7 +355,7 @@ static inline int rmi_f30_initialize(struct rmi_function *fn)
 	f30->gpioled_key_map = (u16 *)map_memory;
 
 	pdata = rmi_get_platform_data(rmi_dev);
-	if (pdata && f30->has_gpio) {
+	if (f30->has_gpio) {
 		button = BTN_LEFT;
 		for (i = 0; i < f30->gpioled_count; i++) {
 			if (rmi_f30_is_valid_button(i, f30->ctrl)) {
@@ -366,8 +366,7 @@ static inline int rmi_f30_initialize(struct rmi_function *fn)
 				 * f30->has_mech_mouse_btns, but I am
 				 * not sure, so use only the pdata info
 				 */
-				if (pdata->f30_data &&
-				    pdata->f30_data->buttonpad)
+				if (pdata->f30_data.buttonpad)
 					break;
 			}
 		}
@@ -382,7 +381,7 @@ static int rmi_f30_probe(struct rmi_function *fn)
 	const struct rmi_device_platform_data *pdata =
 				rmi_get_platform_data(fn->rmi_dev);
 
-	if (pdata->f30_data && pdata->f30_data->disable)
+	if (pdata->f30_data.disable)
 		return 0;
 
 	rc = rmi_f30_initialize(fn);
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 621f098..7780e40 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -218,9 +218,9 @@ struct rmi_device_platform_data {
 	struct rmi_device_platform_data_spi spi_data;
 
 	/* function handler pdata */
-	struct rmi_2d_sensor_platform_data *sensor_pdata;
+	struct rmi_2d_sensor_platform_data sensor_pdata;
 	struct rmi_f01_power_management power_management;
-	struct rmi_f30_data *f30_data;
+	struct rmi_f30_data f30_data;
 };
 
 /**
-- 
2.7.4
