From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4 trivial: rmi_driver.c tidy-up
Date: Mon, 30 Dec 2013 18:54:46 -0800
Message-ID: <1388458486-31102-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:11415 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab3LaCy4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Dec 2013 21:54:56 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

This has three trivial changes:

1) multi-line commenting is changed to kernel coding standard

2) reset_and_reflash() function is renamed to rmi_initial_reset() and
recommentedto reflect what it actually does.

3) #endif comment was updated to actuall match the opening #if CONFIG_PM_SLEEP
condition.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_driver.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index a4e5236..82ae30c 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -77,8 +77,10 @@ static void rmi_poll_work(struct work_struct *work)
 	process_interrupt_requests(rmi_dev);
 }
 
-/* This is the timer function for polling - it simply has to schedule work
- * and restart the timer. */
+/*
+ * This is the timer function for polling - it simply has to schedule work
+ * and restart the timer.
+ */
 static enum hrtimer_restart rmi_poll_timer(struct hrtimer *timer)
 {
 	struct rmi_driver_data *data =
@@ -295,12 +297,14 @@ static int process_interrupt_requests(struct rmi_device *rmi_dev)
 	mutex_lock(&data->irq_mutex);
 	bitmap_and(data->irq_status, data->irq_status, data->current_irq_mask,
 	       data->irq_count);
-	/* At this point, irq_status has all bits that are set in the
+	/*
+	 * At this point, irq_status has all bits that are set in the
 	 * interrupt status register and are enabled.
 	 */
 	mutex_unlock(&data->irq_mutex);
 
-	/* It would be nice to be able to use irq_chip to handle these
+	/*
+	 * It would be nice to be able to use irq_chip to handle these
 	 * nested IRQs.  Unfortunately, most of the current customers for
 	 * this driver are using older kernels (3.0.x) that don't support
 	 * the features required for that.  Once they've shifted to more
@@ -418,7 +422,8 @@ static int rmi_driver_irq_handler(struct rmi_device *rmi_dev, int irq)
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 
 	might_sleep();
-	/* Can get called before the driver is fully ready to deal with
+	/*
+	 * Can get called before the driver is fully ready to deal with
 	 * interrupts.
 	 */
 	if (!data || !data->f01_container) {
@@ -435,7 +440,8 @@ static int rmi_driver_reset_handler(struct rmi_device *rmi_dev)
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	int error;
 
-	/* Can get called before the driver is fully ready to deal with
+	/*
+	 * Can get called before the driver is fully ready to deal with
 	 * this situation.
 	 */
 	if (!data || !data->f01_container) {
@@ -571,13 +577,10 @@ err_free_mem:
  * forces application of any pending updates from reflashing the
  * firmware or configuration.
  *
- * At this time, we also reflash the device if (a) in kernel reflashing is
- * enabled, and (b) the reflash module decides it requires reflashing.
- *
  * We have to do this before actually building the PDT because the reflash
- * might cause various registers to move around.
+ * updates (if any) might cause various registers to move around.
  */
-static int reset_and_reflash(struct rmi_device *rmi_dev)
+static int rmi_initial_reset(struct rmi_device *rmi_dev)
 {
 	struct pdt_entry pdt_entry;
 	int page;
@@ -745,7 +748,7 @@ exit:
 	return retval;
 }
 
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_SLEEP */
 
 static SIMPLE_DEV_PM_OPS(rmi_driver_pm, rmi_driver_suspend, rmi_driver_resume);
 
@@ -791,7 +794,8 @@ static int rmi_driver_probe(struct device *dev)
 	dev_set_drvdata(&rmi_dev->dev, data);
 	mutex_init(&data->pdt_mutex);
 
-	/* Right before a warm boot, the sensor might be in some unusual state,
+	/*
+	 * Right before a warm boot, the sensor might be in some unusual state,
 	 * such as F54 diagnostics, or F34 bootloader mode.  In order to clear
 	 * the sensor to a known state, we issue a initial reset to clear any
 	 * previous settings and force it into normal operation.
@@ -808,7 +812,7 @@ static int rmi_driver_probe(struct device *dev)
 	 */
 	if (!pdata->reset_delay_ms)
 		pdata->reset_delay_ms = DEFAULT_RESET_DELAY_MS;
-	retval = reset_and_reflash(rmi_dev);
+	retval = rmi_initial_reset(rmi_dev);
 	if (retval)
 		dev_warn(dev, "RMI initial reset failed! Continuing in spite of this.\n");
 
@@ -836,7 +840,8 @@ static int rmi_driver_probe(struct device *dev)
 
 	retval = rmi_read(rmi_dev, PDT_PROPERTIES_LOCATION, &data->pdt_props);
 	if (retval < 0) {
-		/* we'll print out a warning and continue since
+		/*
+		 * we'll print out a warning and continue since
 		 * failure to get the PDT properties is not a cause to fail
 		 */
 		dev_warn(dev, "Could not read PDT properties from %#06x. Assuming 0x00.\n",
