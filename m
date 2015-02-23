From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 3/3] HID: i2c-hid: Add support for ACPI GPIO interrupts
Date: Mon, 23 Feb 2015 15:52:45 +0200
Message-ID: <1424699565-138045-4-git-send-email-mika.westerberg@linux.intel.com>
References: <1424699565-138045-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424699565-138045-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mark Rutland <mark.rutland@arm.com>, sb@m-labs.hk, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The HID over I2C specification allows to have the interrupt for a HID
device to be GPIO instead of directly connected to the IO-APIC.

Add support for this so that when the driver does not find proper interrupt
number from the I2C client structure we check if it has ACPI GpioInt()
resource listed in _CRS. If it is found we convert it to an interrupt
number and use it instead.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 68 +++++++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 404ccde49acd..c6cad72f6296 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -37,6 +37,7 @@
 #include <linux/mutex.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/gpio/consumer.h>
 
 #include <linux/i2c/i2c-hid.h>
 
@@ -144,6 +145,8 @@ struct i2c_hid {
 	unsigned long		flags;		/* device flags */
 
 	wait_queue_head_t	wait;		/* For waiting the interrupt */
+	struct gpio_desc	*desc;
+	int			irq;
 
 	struct i2c_hid_platform_data pdata;
 };
@@ -790,16 +793,16 @@ static int i2c_hid_init_irq(struct i2c_client *client)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	int ret;
 
-	dev_dbg(&client->dev, "Requesting IRQ: %d\n", client->irq);
+	dev_dbg(&client->dev, "Requesting IRQ: %d\n", ihid->irq);
 
-	ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
+	ret = request_threaded_irq(ihid->irq, NULL, i2c_hid_irq,
 			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 			client->name, ihid);
 	if (ret < 0) {
 		dev_warn(&client->dev,
 			"Could not register for %s interrupt, irq = %d,"
 			" ret = %d\n",
-			client->name, client->irq, ret);
+			client->name, ihid->irq, ret);
 
 		return ret;
 	}
@@ -846,6 +849,14 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 }
 
 #ifdef CONFIG_ACPI
+
+/* Default GPIO mapping */
+static const struct acpi_gpio_params i2c_hid_irq_gpio = { 0, 0, true };
+static const struct acpi_gpio_mapping i2c_hid_acpi_gpios[] = {
+	{ "gpios", &i2c_hid_irq_gpio, 1 },
+	{ },
+};
+
 static int i2c_hid_acpi_pdata(struct i2c_client *client,
 		struct i2c_hid_platform_data *pdata)
 {
@@ -871,7 +882,7 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 	pdata->hid_descriptor_address = obj->integer.value;
 	ACPI_FREE(obj);
 
-	return 0;
+	return acpi_dev_add_driver_gpios(adev, i2c_hid_acpi_gpios);
 }
 
 static const struct acpi_device_id i2c_hid_acpi_match[] = {
@@ -935,12 +946,6 @@ static int i2c_hid_probe(struct i2c_client *client,
 
 	dbg_hid("HID probe called for i2c 0x%02x\n", client->addr);
 
-	if (!client->irq) {
-		dev_err(&client->dev,
-			"HID over i2c has not been provided an Int IRQ\n");
-		return -EINVAL;
-	}
-
 	ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
 	if (!ihid)
 		return -ENOMEM;
@@ -960,6 +965,23 @@ static int i2c_hid_probe(struct i2c_client *client,
 		ihid->pdata = *platform_data;
 	}
 
+	if (client->irq > 0) {
+		ihid->irq = client->irq;
+	} else if (ACPI_COMPANION(&client->dev)) {
+		ihid->desc = gpiod_get(&client->dev, NULL, GPIOD_IN);
+		if (IS_ERR(ihid->desc)) {
+			dev_err(&client->dev, "Failed to get GPIO interrupt\n");
+			return PTR_ERR(ihid->desc);
+		}
+
+		ihid->irq = gpiod_to_irq(ihid->desc);
+		if (ihid->irq < 0) {
+			gpiod_put(ihid->desc);
+			dev_err(&client->dev, "Failed to convert GPIO to IRQ\n");
+			return ihid->irq;
+		}
+	}
+
 	i2c_set_clientdata(client, ihid);
 
 	ihid->client = client;
@@ -1022,13 +1044,16 @@ err_mem_free:
 	hid_destroy_device(hid);
 
 err_irq:
-	free_irq(client->irq, ihid);
+	free_irq(ihid->irq, ihid);
 
 err_pm:
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
 
 err:
+	if (ihid->desc)
+		gpiod_put(ihid->desc);
+
 	i2c_hid_free_buffers(ihid);
 	kfree(ihid);
 	return ret;
@@ -1047,13 +1072,18 @@ static int i2c_hid_remove(struct i2c_client *client)
 	hid = ihid->hid;
 	hid_destroy_device(hid);
 
-	free_irq(client->irq, ihid);
+	free_irq(ihid->irq, ihid);
 
 	if (ihid->bufsize)
 		i2c_hid_free_buffers(ihid);
 
+	if (ihid->desc)
+		gpiod_put(ihid->desc);
+
 	kfree(ihid);
 
+	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&client->dev));
+
 	return 0;
 }
 
@@ -1065,9 +1095,9 @@ static int i2c_hid_suspend(struct device *dev)
 	struct hid_device *hid = ihid->hid;
 	int ret = 0;
 
-	disable_irq(client->irq);
+	disable_irq(ihid->irq);
 	if (device_may_wakeup(&client->dev))
-		enable_irq_wake(client->irq);
+		enable_irq_wake(ihid->irq);
 
 	if (hid->driver && hid->driver->suspend)
 		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
@@ -1085,13 +1115,13 @@ static int i2c_hid_resume(struct device *dev)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid = ihid->hid;
 
-	enable_irq(client->irq);
+	enable_irq(ihid->irq);
 	ret = i2c_hid_hwreset(client);
 	if (ret)
 		return ret;
 
 	if (device_may_wakeup(&client->dev))
-		disable_irq_wake(client->irq);
+		disable_irq_wake(ihid->irq);
 
 	if (hid->driver && hid->driver->reset_resume) {
 		ret = hid->driver->reset_resume(hid);
@@ -1106,17 +1136,19 @@ static int i2c_hid_resume(struct device *dev)
 static int i2c_hid_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
 	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
-	disable_irq(client->irq);
+	disable_irq(ihid->irq);
 	return 0;
 }
 
 static int i2c_hid_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
-	enable_irq(client->irq);
+	enable_irq(ihid->irq);
 	i2c_hid_set_power(client, I2C_HID_PWR_ON);
 	return 0;
 }
-- 
2.1.4
