From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 8/9] input: goodix: add support for ESD
Date: Thu, 28 May 2015 15:47:44 +0300
Message-ID: <1432817265-23891-9-git-send-email-irina.tirdea@intel.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432817265-23891-1-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add ESD (Electrostatic Discharge) protection mechanism.

The driver enables ESD protection in HW and checks a register
to determine if ESD occurred. If ESD is signalled by the HW,
the driver will reset the device.

The ESD poll time (in ms) can be set through
esd-recovery-timeout-ms ACPI/DT property. If it is set to 0,
ESD protection is disabled.

Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 .../bindings/input/touchscreen/goodix.txt          |   4 +
 drivers/input/touchscreen/goodix.c                 | 106 ++++++++++++++++++++-
 2 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 9e4ff69..9132ee0 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -19,6 +19,10 @@ Optional properties:
 
  - device-config	: device configuration information (specified as byte
 			  array). Maximum size is 240 bytes.
+ - esd-recovery-timeout-ms : ESD poll time (in milli seconds) for the driver to
+			     check if ESD occurred and in that case reset the
+			     device. ESD is disabled if this property is not set
+			     or is set to 0.
 
 Example:
 
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index ce7e834..a41d17b 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -38,11 +38,14 @@ struct goodix_ts_data {
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
 	unsigned long irq_flags;
+	unsigned int esd_timeout;
+	struct delayed_work esd_work;
 };
 
-#define GOODIX_GPIO_INT_NAME		"irq"
-#define GOODIX_GPIO_RST_NAME		"reset"
-#define GOODIX_DEVICE_CONFIG_PROPERTY	"device-config"
+#define GOODIX_GPIO_INT_NAME			"irq"
+#define GOODIX_GPIO_RST_NAME			"reset"
+#define GOODIX_DEVICE_CONFIG_PROPERTY		"device-config"
+#define GOODIX_DEVICE_ESD_TIMEOUT_PROPERTY	"esd-recovery-timeout-ms"
 
 #define GOODIX_MAX_HEIGHT		4096
 #define GOODIX_MAX_WIDTH		4096
@@ -55,6 +58,8 @@ struct goodix_ts_data {
 /* Register defines */
 #define GOODIX_REG_COMMAND		0x8040
 #define GOODIX_CMD_SCREEN_OFF		0x05
+#define GOODIX_CMD_ESD_ENABLED		0xAA
+#define GOODIX_REG_ESD_CHECK		0x8041
 
 #define GOODIX_READ_COOR_ADDR		0x814E
 #define GOODIX_REG_CONFIG_DATA		0x8047
@@ -396,6 +401,77 @@ static int goodix_reset(struct goodix_ts_data *ts)
 	return 0;
 }
 
+static void goodix_disable_esd(struct goodix_ts_data *ts)
+{
+	if (!ts->esd_timeout)
+		return;
+	cancel_delayed_work_sync(&ts->esd_work);
+}
+
+static int goodix_enable_esd(struct goodix_ts_data *ts)
+{
+	int ret;
+
+	if (!ts->esd_timeout)
+		return 0;
+
+	ret = goodix_i2c_write_u8(ts->client, GOODIX_REG_ESD_CHECK,
+				  GOODIX_CMD_ESD_ENABLED);
+	if (ret) {
+		dev_err(&ts->client->dev, "Failed to enable ESD: %d\n", ret);
+		return ret;
+	}
+
+	schedule_delayed_work(&ts->esd_work, round_jiffies_relative(
+			      msecs_to_jiffies(ts->esd_timeout)));
+	return 0;
+}
+
+static void goodix_esd_work(struct work_struct *work)
+{
+	struct goodix_ts_data *ts = container_of(work, struct goodix_ts_data,
+						 esd_work.work);
+	int retries = 3, ret;
+	u8 esd_data[2];
+
+	while (--retries) {
+		ret = goodix_i2c_read(ts->client, GOODIX_REG_COMMAND, esd_data,
+				      sizeof(esd_data));
+		if (ret)
+			continue;
+		if (esd_data[0] != GOODIX_CMD_ESD_ENABLED &&
+		    esd_data[1] == GOODIX_CMD_ESD_ENABLED) {
+			/* feed the watchdog */
+			goodix_i2c_write_u8(ts->client,
+					    GOODIX_REG_COMMAND,
+					    GOODIX_CMD_ESD_ENABLED);
+			break;
+		}
+	}
+
+	if (!retries) {
+		dev_dbg(&ts->client->dev, "Performing ESD recovery.\n");
+		goodix_free_irq(ts);
+		ret = goodix_reset(ts);
+		if (ret)
+			goto reschedule;
+		ret = goodix_send_cfg(ts);
+		if (ret)
+			goto reschedule;
+		ret = goodix_request_irq(ts);
+		if (ret)
+			goto reschedule;
+		ret = goodix_enable_esd(ts);
+		if (ret)
+			goto reschedule;
+		return;
+	}
+
+reschedule:
+	schedule_delayed_work(&ts->esd_work, round_jiffies_relative(
+			      msecs_to_jiffies(ts->esd_timeout)));
+}
+
 /**
  * goodix_get_gpio_config - Get GPIO config from ACPI/DT
  *
@@ -599,6 +675,7 @@ static int goodix_ts_probe(struct i2c_client *client,
 
 	ts->client = client;
 	i2c_set_clientdata(client, ts);
+	INIT_DELAYED_WORK(&ts->esd_work, goodix_esd_work);
 
 	error = goodix_i2c_test(client);
 	if (error) {
@@ -641,6 +718,21 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	error = device_property_read_u32(&ts->client->dev,
+					 GOODIX_DEVICE_ESD_TIMEOUT_PROPERTY,
+					 &ts->esd_timeout);
+	if (error < 0)
+		dev_err(&ts->client->dev, "No %s property. Will not use ESD.\n",
+			GOODIX_DEVICE_ESD_TIMEOUT_PROPERTY);
+
+	return goodix_enable_esd(ts);
+}
+
+static int goodix_ts_remove(struct i2c_client *client)
+{
+	struct goodix_ts_data *ts = i2c_get_clientdata(client);
+
+	goodix_disable_esd(ts);
 	return 0;
 }
 
@@ -651,6 +743,7 @@ static int goodix_suspend(struct device *dev)
 	struct goodix_ts_data *ts = i2c_get_clientdata(client);
 	int ret;
 
+	goodix_disable_esd(ts);
 	goodix_free_irq(ts);
 	ret = gpiod_direction_output(ts->gpiod_int, 0);
 	if (ret) {
@@ -690,7 +783,11 @@ static int goodix_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	return goodix_request_irq(ts);
+	ret = goodix_request_irq(ts);
+	if (ret)
+		return ret;
+
+	return goodix_enable_esd(ts);
 }
 #endif
 
@@ -727,6 +824,7 @@ MODULE_DEVICE_TABLE(of, goodix_of_match);
 
 static struct i2c_driver goodix_ts_driver = {
 	.probe = goodix_ts_probe,
+	.remove = goodix_ts_remove,
 	.id_table = goodix_ts_id,
 	.driver = {
 		.name = "Goodix-TS",
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
