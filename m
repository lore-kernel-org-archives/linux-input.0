From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] Revert "HID: i2c-hid: Add support for ACPI GPIO interrupts"
Date: Thu, 13 Oct 2016 11:30:44 +0200
Message-ID: <1476351045-8829-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1476351045-8829-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476351045-8829-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: David Arcari <darcari@redhat.com>

This reverts commit a485923efbb8 ("HID: i2c-hid: Add support for ACPI
GPIO interrupts") and commit a7d2bf25a483 ("HID: i2c-hid: Do not fail
probing if gpiolib is not enabled") at the same time.

Since commit c884fbd45214 ("gpio / ACPI: Add support for retrieving
GpioInt resources from a device") i2c_core already set the IRQ by
looking into the ACPI tree and retrieving the gpioInt. So we just
have some boiler-plate here that is not needed anymore.

The only downside effect here is that now we are not exiting early
enough if the irq is set to -EPROBE_DEFER or any other error, but
this is going to be fixed in the following patch.

Signed-off-by: David Arcari <darcari@redhat.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 71 +++++++++++--------------------------------
 1 file changed, 18 insertions(+), 53 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index b3ec4f2..4cd606c 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -37,7 +37,6 @@
 #include <linux/mutex.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
-#include <linux/gpio/consumer.h>
 
 #include <linux/i2c/i2c-hid.h>
 
@@ -145,8 +144,6 @@ struct i2c_hid {
 	unsigned long		flags;		/* device flags */
 
 	wait_queue_head_t	wait;		/* For waiting the interrupt */
-	struct gpio_desc	*desc;
-	int			irq;
 
 	struct i2c_hid_platform_data pdata;
 
@@ -808,16 +805,16 @@ static int i2c_hid_init_irq(struct i2c_client *client)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	int ret;
 
-	dev_dbg(&client->dev, "Requesting IRQ: %d\n", ihid->irq);
+	dev_dbg(&client->dev, "Requesting IRQ: %d\n", client->irq);
 
-	ret = request_threaded_irq(ihid->irq, NULL, i2c_hid_irq,
+	ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
 			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 			client->name, ihid);
 	if (ret < 0) {
 		dev_warn(&client->dev,
 			"Could not register for %s interrupt, irq = %d,"
 			" ret = %d\n",
-			client->name, ihid->irq, ret);
+			client->name, client->irq, ret);
 
 		return ret;
 	}
@@ -864,14 +861,6 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 }
 
 #ifdef CONFIG_ACPI
-
-/* Default GPIO mapping */
-static const struct acpi_gpio_params i2c_hid_irq_gpio = { 0, 0, true };
-static const struct acpi_gpio_mapping i2c_hid_acpi_gpios[] = {
-	{ "gpios", &i2c_hid_irq_gpio, 1 },
-	{ },
-};
-
 static int i2c_hid_acpi_pdata(struct i2c_client *client,
 		struct i2c_hid_platform_data *pdata)
 {
@@ -882,7 +871,6 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 	union acpi_object *obj;
 	struct acpi_device *adev;
 	acpi_handle handle;
-	int ret;
 
 	handle = ACPI_HANDLE(&client->dev);
 	if (!handle || acpi_bus_get_device(handle, &adev))
@@ -898,9 +886,7 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 	pdata->hid_descriptor_address = obj->integer.value;
 	ACPI_FREE(obj);
 
-	/* GPIOs are optional */
-	ret = acpi_dev_add_driver_gpios(adev, i2c_hid_acpi_gpios);
-	return ret < 0 && ret != -ENXIO ? ret : 0;
+	return 0;
 }
 
 static const struct acpi_device_id i2c_hid_acpi_match[] = {
@@ -964,6 +950,12 @@ static int i2c_hid_probe(struct i2c_client *client,
 
 	dbg_hid("HID probe called for i2c 0x%02x\n", client->addr);
 
+	if (!client->irq) {
+		dev_err(&client->dev,
+			"HID over i2c has not been provided an Int IRQ\n");
+		return -EINVAL;
+	}
+
 	ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
 	if (!ihid)
 		return -ENOMEM;
@@ -983,23 +975,6 @@ static int i2c_hid_probe(struct i2c_client *client,
 		ihid->pdata = *platform_data;
 	}
 
-	if (client->irq > 0) {
-		ihid->irq = client->irq;
-	} else if (ACPI_COMPANION(&client->dev)) {
-		ihid->desc = gpiod_get(&client->dev, NULL, GPIOD_IN);
-		if (IS_ERR(ihid->desc)) {
-			dev_err(&client->dev, "Failed to get GPIO interrupt\n");
-			return PTR_ERR(ihid->desc);
-		}
-
-		ihid->irq = gpiod_to_irq(ihid->desc);
-		if (ihid->irq < 0) {
-			gpiod_put(ihid->desc);
-			dev_err(&client->dev, "Failed to convert GPIO to IRQ\n");
-			return ihid->irq;
-		}
-	}
-
 	i2c_set_clientdata(client, ihid);
 
 	ihid->client = client;
@@ -1064,16 +1039,13 @@ err_mem_free:
 	hid_destroy_device(hid);
 
 err_irq:
-	free_irq(ihid->irq, ihid);
+	free_irq(client->irq, ihid);
 
 err_pm:
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
 
 err:
-	if (ihid->desc)
-		gpiod_put(ihid->desc);
-
 	i2c_hid_free_buffers(ihid);
 	kfree(ihid);
 	return ret;
@@ -1092,18 +1064,13 @@ static int i2c_hid_remove(struct i2c_client *client)
 	hid = ihid->hid;
 	hid_destroy_device(hid);
 
-	free_irq(ihid->irq, ihid);
+	free_irq(client->irq, ihid);
 
 	if (ihid->bufsize)
 		i2c_hid_free_buffers(ihid);
 
-	if (ihid->desc)
-		gpiod_put(ihid->desc);
-
 	kfree(ihid);
 
-	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&client->dev));
-
 	return 0;
 }
 
@@ -1142,11 +1109,11 @@ static int i2c_hid_suspend(struct device *dev)
 		/* Save some power */
 		i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
 
-		disable_irq(ihid->irq);
+		disable_irq(client->irq);
 	}
 
 	if (device_may_wakeup(&client->dev)) {
-		wake_status = enable_irq_wake(ihid->irq);
+		wake_status = enable_irq_wake(client->irq);
 		if (!wake_status)
 			ihid->irq_wake_enabled = true;
 		else
@@ -1166,7 +1133,7 @@ static int i2c_hid_resume(struct device *dev)
 	int wake_status;
 
 	if (device_may_wakeup(&client->dev) && ihid->irq_wake_enabled) {
-		wake_status = disable_irq_wake(ihid->irq);
+		wake_status = disable_irq_wake(client->irq);
 		if (!wake_status)
 			ihid->irq_wake_enabled = false;
 		else
@@ -1179,7 +1146,7 @@ static int i2c_hid_resume(struct device *dev)
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	enable_irq(ihid->irq);
+	enable_irq(client->irq);
 	ret = i2c_hid_hwreset(client);
 	if (ret)
 		return ret;
@@ -1197,19 +1164,17 @@ static int i2c_hid_resume(struct device *dev)
 static int i2c_hid_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
 	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
-	disable_irq(ihid->irq);
+	disable_irq(client->irq);
 	return 0;
 }
 
 static int i2c_hid_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
-	enable_irq(ihid->irq);
+	enable_irq(client->irq);
 	i2c_hid_set_power(client, I2C_HID_PWR_ON);
 	return 0;
 }
-- 
2.7.4
