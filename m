From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 8/8] input: goodix: add support for ESD
Date: Mon,  8 Jun 2015 17:37:53 +0300
Message-ID: <1433774273-23103-9-git-send-email-irina.tirdea@intel.com>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

Add ESD (Electrostatic Discharge) protection mechanism.

The driver enables ESD protection in HW and checks a register
to determine if ESD occurred. If ESD is signalled by the HW,
the driver will reset the device.

This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
driver gt9xx.c for Android (publicly available in Android kernel
trees for various devices).

The ESD poll time (in ms) can be set through
esd-recovery-timeout-ms ACPI/DT property. If it is set to 0,
ESD protection is disabled.
For ACPI 5.1, the property can be specified using _DSD properties:

Device (STAC)
{
    Name (_HID, "GDIX1001")
    ...

    Name (_DSD,  Package ()
    {
        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package ()
        {
            Package (2) { "esd-recovery-timeout-ms", Package(1) { 2000 }},
            ...
        }
    }
}

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 .../bindings/input/touchscreen/goodix.txt          |   7 ++
 drivers/input/touchscreen/goodix.c                 | 104 ++++++++++++++++++++-
 2 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 7137881..bc94c6f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -15,6 +15,13 @@ Required properties:
  - irq-gpio		: GPIO pin used for IRQ
  - reset-gpio		: GPIO pin used for reset
 
+Optional properties:
+
+ - esd-recovery-timeout-ms : ESD poll time (in milli seconds) for the driver to
+			     check if ESD occurred and in that case reset the
+			     device. ESD is disabled if this property is not set
+			     or is set to 0.
+
 Example:
 
 	i2c@00000000 {
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 76004a4..a6c5d11 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -39,10 +39,13 @@ struct goodix_ts_data {
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
 	unsigned long irq_flags;
+	unsigned int esd_timeout;
+	struct delayed_work esd_work;
 };
 
-#define GOODIX_GPIO_INT_NAME		"irq"
-#define GOODIX_GPIO_RST_NAME		"reset"
+#define GOODIX_GPIO_INT_NAME			"irq"
+#define GOODIX_GPIO_RST_NAME			"reset"
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
@@ -376,6 +381,77 @@ static int goodix_reset(struct goodix_ts_data *ts)
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
+		ret = goodix_send_cfg(ts, ts->input_dev->id.product);
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
@@ -579,6 +655,7 @@ static int goodix_ts_probe(struct i2c_client *client,
 
 	ts->client = client;
 	i2c_set_clientdata(client, ts);
+	INIT_DELAYED_WORK(&ts->esd_work, goodix_esd_work);
 
 	error = goodix_i2c_test(client);
 	if (error) {
@@ -621,6 +698,21 @@ static int goodix_ts_probe(struct i2c_client *client,
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
 
@@ -631,6 +723,7 @@ static int goodix_suspend(struct device *dev)
 	struct goodix_ts_data *ts = i2c_get_clientdata(client);
 	int ret;
 
+	goodix_disable_esd(ts);
 	goodix_free_irq(ts);
 	/* Output LOW on the INT pin for 5 ms */
 	ret = gpiod_direction_output(ts->gpiod_int, 0);
@@ -677,7 +770,11 @@ static int goodix_resume(struct device *dev)
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
 
@@ -712,6 +809,7 @@ MODULE_DEVICE_TABLE(of, goodix_of_match);
 
 static struct i2c_driver goodix_ts_driver = {
 	.probe = goodix_ts_probe,
+	.remove = goodix_ts_remove,
 	.id_table = goodix_ts_id,
 	.driver = {
 		.name = "Goodix-TS",
-- 
1.9.1
