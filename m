From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH V4] input synaptics-rmi4: Bug fixes to ATTN GPIO handling.
Date: Fri, 27 Dec 2013 17:26:44 -0800
Message-ID: <1388194004-32253-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:31813 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab3L1B0x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Dec 2013 20:26:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

This patch fixes some bugs in handling of the RMI4 attention line GPIO.

1) in enable_sensor(), eliminate the complicated check on ATTN and just 
call process_interrupt_requests().  This will have minimal overhead if ATTN
is not asserted, and clears the state of the RMI4 device in any case.

2) Correctly free the GPIO in rmi_driver_remove().

3) in rmi_driver_probe()
    - declare the name of the attention gpio (GPIO_LABEL)
    - use gpio_request_one() to get the gpio and export it.
    - simplify (somewhat) conditional gpio acquisition logic and combine 
      with interrupt setup

4) use gpio_is_valid() instead of comparing to 0.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_driver.c | 64 ++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 2ae9af9..766954f 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -140,7 +140,6 @@ static int enable_sensor(struct rmi_device *rmi_dev)
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	struct rmi_transport_dev *xport;
 	int retval = 0;
-	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
 
 	if (data->enabled)
 		return 0;
@@ -169,11 +168,7 @@ static int enable_sensor(struct rmi_device *rmi_dev)
 
 	data->enabled = true;
 
-	if (!pdata->level_triggered &&
-		    gpio_get_value(pdata->attn_gpio) == pdata->attn_polarity)
-		retval = process_interrupt_requests(rmi_dev);
-
-	return retval;
+	return process_interrupt_requests(rmi_dev);
 }
 
 static void rmi_free_function_list(struct rmi_device *rmi_dev)
@@ -800,13 +795,21 @@ static SIMPLE_DEV_PM_OPS(rmi_driver_pm, rmi_driver_suspend, rmi_driver_resume);
 static int rmi_driver_remove(struct device *dev)
 {
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
+	const struct rmi_device_platform_data *pdata =
+					to_rmi_platform_data(rmi_dev);
+	const struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 
 	disable_sensor(rmi_dev);
 	rmi_free_function_list(rmi_dev);
 
+	if (gpio_is_valid(pdata->attn_gpio) && data->gpio_held)
+		gpio_free(pdata->attn_gpio);
+
 	return 0;
 }
 
+static const char GPIO_LABEL[] = "attn";
+
 static int rmi_driver_probe(struct device *dev)
 {
 	struct rmi_driver *rmi_driver;
@@ -937,7 +940,9 @@ static int rmi_driver_probe(struct device *dev)
 		mutex_init(&data->suspend_mutex);
 	}
 
-	if (pdata->attn_gpio) {
+	if (gpio_is_valid(pdata->attn_gpio)) {
+		ulong gpio_flags = GPIOF_DIR_IN;
+
 		data->irq = gpio_to_irq(pdata->attn_gpio);
 		if (pdata->level_triggered) {
 			data->irq_flags = IRQF_ONESHOT |
@@ -948,6 +953,32 @@ static int rmi_driver_probe(struct device *dev)
 				(pdata->attn_polarity == RMI_ATTN_ACTIVE_HIGH)
 				? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
 		}
+
+		if (IS_ENABLED(CONFIG_RMI4_DEV))
+			gpio_flags |= GPIOF_EXPORT;
+		retval = gpio_request_one(pdata->attn_gpio, gpio_flags,
+					  GPIO_LABEL);
+		if (retval) {
+			dev_warn(dev, "WARNING: Failed to request ATTN gpio %d, code=%d.\n",
+				 pdata->attn_gpio, retval);
+			retval = 0;
+		} else {
+			dev_info(dev, "Obtained ATTN gpio %d.\n",
+					pdata->attn_gpio);
+			data->gpio_held = true;
+			if (IS_ENABLED(CONFIG_RMI4_DEV)) {
+				retval = gpio_export_link(dev,
+							GPIO_LABEL, pdata->attn_gpio);
+				if (retval) {
+					dev_warn(dev,
+						"WARNING: Failed to symlink ATTN gpio!\n");
+					retval = 0;
+				} else {
+					dev_info(dev, "Exported ATTN gpio %d.",
+						pdata->attn_gpio);
+				}
+			}
+		}
 	} else
 		data->poll_interval = ktime_set(0,
 			(pdata->poll_interval_ms ? pdata->poll_interval_ms :
@@ -958,25 +989,6 @@ static int rmi_driver_probe(struct device *dev)
 		enable_sensor(rmi_dev);
 	}
 
-	if (IS_ENABLED(CONFIG_RMI4_DEV) && pdata->attn_gpio) {
-		retval = gpio_export(pdata->attn_gpio, false);
-		if (retval) {
-			dev_warn(dev, "WARNING: Failed to export ATTN gpio!\n");
-			retval = 0;
-		} else {
-			retval = gpio_export_link(dev,
-						  "attn", pdata->attn_gpio);
-			if (retval) {
-				dev_warn(dev,
-					"WARNING: Failed to symlink ATTN gpio!\n");
-				retval = 0;
-			} else {
-				dev_info(dev, "Exported ATTN GPIO %d.",
-					pdata->attn_gpio);
-			}
-		}
-	}
-
 	return 0;
 
  err_free_data:
