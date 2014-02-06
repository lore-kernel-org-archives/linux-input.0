From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4: rmi_driver.c tidying
Date: Wed, 5 Feb 2014 18:15:49 -0800
Message-ID: <1391652949-21083-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:40288 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbaBFCQO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Feb 2014 21:16:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Remove pdt_mutex, since it's no longer needed.

Remove obsolete comment in rmi_drive_irq_save().  Fix
some operator spacing (or lack thereof) in rmi_drive_irq_save().

Remove XXX comment about F01 ordering.  New structure doesn't
require F01 to be first.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---

 drivers/input/rmi4/rmi_driver.c | 24 ++----------------------
 drivers/input/rmi4/rmi_driver.h |  1 -
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 96bb47d..2943b2c4 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -347,21 +347,15 @@ static int rmi_driver_irq_save(struct rmi_device *rmi_dev,
 	if (!data->irq_stored) {
 		/* Save current enabled interrupts */
 		retval = rmi_read_block(rmi_dev,
-				data->f01_container->fd.control_base_addr+1,
+				data->f01_container->fd.control_base_addr + 1,
 				data->irq_mask_store, data->num_of_irq_regs);
 		if (retval < 0) {
 			dev_err(dev, "%s: Failed to read enabled interrupts!",
 								__func__);
 			goto error_unlock;
 		}
-		/*
-		 * Disable every interrupt except for function 54
-		 * TODO:Will also want to not disable function 1-like functions.
-		 * No need to take care of this now, since there's no good way
-		 * to identify them.
-		 */
 		retval = rmi_write_block(rmi_dev,
-				data->f01_container->fd.control_base_addr+1,
+				data->f01_container->fd.control_base_addr + 1,
 				new_ints, data->num_of_irq_regs);
 		if (retval < 0) {
 			dev_err(dev, "%s: Failed to change enabled interrupts!",
@@ -562,24 +556,15 @@ static int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
 					void *ctx,
 					const struct pdt_entry *entry))
 {
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	int page;
 	int retval = RMI_SCAN_DONE;
 
-	/*
-	 * TODO: With F01 and reflash as part of the core now, is this
-	 * lock still required?
-	 */
-	mutex_lock(&data->pdt_mutex);
-
 	for (page = 0; page <= RMI4_MAX_PAGE; page++) {
 		retval = rmi_scan_pdt_page(rmi_dev, page, ctx, callback);
 		if (retval != RMI_SCAN_CONTINUE)
 			break;
 	}
 
-	mutex_unlock(&data->pdt_mutex);
-
 	return retval < 0 ? retval : 0;
 }
 
@@ -829,7 +814,6 @@ static int rmi_driver_probe(struct device *dev)
 	INIT_LIST_HEAD(&data->function_list);
 	data->rmi_dev = rmi_dev;
 	dev_set_drvdata(&rmi_dev->dev, data);
-	mutex_init(&data->pdt_mutex);
 
 	/*
 	 * Right before a warm boot, the sensor might be in some unusual state,
@@ -897,10 +881,6 @@ static int rmi_driver_probe(struct device *dev)
 	data->current_irq_mask	= irq_memory + size * 2;
 	data->irq_mask_store	= irq_memory + size * 3;
 
-	/*
-	 * XXX need to make sure we create F01 first...
-	 * XXX or do we?  It might not be required in the updated structure.
-	 */
 	irq_count = 0;
 	dev_dbg(dev, "Creating functions.");
 	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index d071ff5..a22a4e6 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -56,7 +56,6 @@ struct rmi_driver_data {
 	struct work_struct poll_work;
 	ktime_t poll_interval;
 
-	struct mutex pdt_mutex;
 	u8 pdt_props;
 	u8 bsr;
 
