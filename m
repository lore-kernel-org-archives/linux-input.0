From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 04/13] Input: synaptics-rmi4 - remove mutex calls while updating the firmware
Date: Tue, 29 Nov 2016 11:08:15 +0100
Message-ID: <1480414104-8524-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933306AbcK2KIi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 05:08:38 -0500
In-Reply-To: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This partially reverts commit 29fd0ec2bdbe ("Input: synaptics-rmi4 -
add support for F34 device reflash")

irq_mutex should be used only to protect data->current_irq_mask, not
preventing incoming input to be processed while the upgrade of the
firmware is happening. We can simply disable the irqs when we don't
want them to interfere with the upgrade process.

Tested on S7300 and S7800 (with F34 v7 patch added)

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 drivers/input/rmi4/rmi_driver.c | 40 ++++++++--------------------------------
 drivers/input/rmi4/rmi_f34.c    | 19 ++++++++++++++-----
 2 files changed, 22 insertions(+), 37 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index f04fc41..27c731a 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -42,8 +42,6 @@ void rmi_free_function_list(struct rmi_device *rmi_dev)
 
 	rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Freeing function list\n");
 
-	mutex_lock(&data->irq_mutex);
-
 	devm_kfree(&rmi_dev->dev, data->irq_memory);
 	data->irq_memory = NULL;
 	data->irq_status = NULL;
@@ -60,8 +58,6 @@ void rmi_free_function_list(struct rmi_device *rmi_dev)
 		list_del(&fn->node);
 		rmi_unregister_function(fn);
 	}
-
-	mutex_unlock(&data->irq_mutex);
 }
 EXPORT_SYMBOL_GPL(rmi_free_function_list);
 
@@ -160,25 +156,24 @@ static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	if (!data)
 		return 0;
 
-	mutex_lock(&data->irq_mutex);
-	if (!data->irq_status || !data->f01_container) {
-		mutex_unlock(&data->irq_mutex);
-		return 0;
-	}
-
 	if (!rmi_dev->xport->attn_data) {
 		error = rmi_read_block(rmi_dev,
 				data->f01_container->fd.data_base_addr + 1,
 				data->irq_status, data->num_of_irq_regs);
 		if (error < 0) {
 			dev_err(dev, "Failed to read irqs, code=%d\n", error);
-			mutex_unlock(&data->irq_mutex);
 			return error;
 		}
 	}
 
+	mutex_lock(&data->irq_mutex);
 	bitmap_and(data->irq_status, data->irq_status, data->current_irq_mask,
 	       data->irq_count);
+	/*
+	 * At this point, irq_status has all bits that are set in the
+	 * interrupt status register and are enabled.
+	 */
+	mutex_unlock(&data->irq_mutex);
 
 	/*
 	 * It would be nice to be able to use irq_chip to handle these
@@ -194,8 +189,6 @@ static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	if (data->input)
 		input_sync(data->input);
 
-	mutex_unlock(&data->irq_mutex);
-
 	return 0;
 }
 
@@ -263,18 +256,12 @@ static int rmi_suspend_functions(struct rmi_device *rmi_dev)
 	struct rmi_function *entry;
 	int retval;
 
-	mutex_lock(&data->irq_mutex);
-
 	list_for_each_entry(entry, &data->function_list, node) {
 		retval = suspend_one_function(entry);
-		if (retval < 0) {
-			mutex_unlock(&data->irq_mutex);
+		if (retval < 0)
 			return retval;
-		}
 	}
 
-	mutex_unlock(&data->irq_mutex);
-
 	return 0;
 }
 
@@ -303,18 +290,12 @@ static int rmi_resume_functions(struct rmi_device *rmi_dev)
 	struct rmi_function *entry;
 	int retval;
 
-	mutex_lock(&data->irq_mutex);
-
 	list_for_each_entry(entry, &data->function_list, node) {
 		retval = resume_one_function(entry);
-		if (retval < 0) {
-			mutex_unlock(&data->irq_mutex);
+		if (retval < 0)
 			return retval;
-		}
 	}
 
-	mutex_unlock(&data->irq_mutex);
-
 	return 0;
 }
 
@@ -1043,8 +1024,6 @@ int rmi_init_functions(struct rmi_driver_data *data)
 	int irq_count;
 	int retval;
 
-	mutex_lock(&data->irq_mutex);
-
 	irq_count = 0;
 	rmi_dbg(RMI_DEBUG_CORE, dev, "%s: Creating functions.\n", __func__);
 	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
@@ -1069,13 +1048,10 @@ int rmi_init_functions(struct rmi_driver_data *data)
 		goto err_destroy_functions;
 	}
 
-	mutex_unlock(&data->irq_mutex);
-
 	return 0;
 
 err_destroy_functions:
 	rmi_free_function_list(rmi_dev);
-	mutex_unlock(&data->irq_mutex);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(rmi_init_functions);
diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index 03df85a..01936a4 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -282,7 +282,8 @@ int rmi_f34_update_firmware(struct f34_data *f34, const struct firmware *fw)
 static int rmi_firmware_update(struct rmi_driver_data *data,
 			       const struct firmware *fw)
 {
-	struct device *dev = &data->rmi_dev->dev;
+	struct rmi_device *rmi_dev = data->rmi_dev;
+	struct device *dev = &rmi_dev->dev;
 	struct f34_data *f34;
 	int ret;
 
@@ -305,8 +306,10 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 	if (ret)
 		return ret;
 
+	rmi_disable_irq(rmi_dev, false);
+
 	/* Tear down functions and re-probe */
-	rmi_free_function_list(data->rmi_dev);
+	rmi_free_function_list(rmi_dev);
 
 	ret = rmi_probe_interrupts(data);
 	if (ret)
@@ -322,6 +325,8 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 		return -EINVAL;
 	}
 
+	rmi_enable_irq(rmi_dev, false);
+
 	f34 = dev_get_drvdata(&data->f34_container->dev);
 
 	/* Perform firmware update */
@@ -329,11 +334,13 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 
 	dev_info(&f34->fn->dev, "Firmware update complete, status:%d\n", ret);
 
+	rmi_disable_irq(rmi_dev, false);
+
 	/* Re-probe */
 	rmi_dbg(RMI_DEBUG_FN, dev, "Re-probing device\n");
-	rmi_free_function_list(data->rmi_dev);
+	rmi_free_function_list(rmi_dev);
 
-	ret = rmi_scan_pdt(data->rmi_dev, NULL, rmi_initial_reset);
+	ret = rmi_scan_pdt(rmi_dev, NULL, rmi_initial_reset);
 	if (ret < 0)
 		dev_warn(dev, "RMI reset failed!\n");
 
@@ -345,9 +352,11 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 	if (ret)
 		return ret;
 
+	rmi_enable_irq(rmi_dev, false);
+
 	if (data->f01_container->dev.driver)
 		/* Driver already bound, so enable ATTN now. */
-		return rmi_enable_sensor(data->rmi_dev);
+		return rmi_enable_sensor(rmi_dev);
 
 	rmi_dbg(RMI_DEBUG_FN, dev, "%s complete\n", __func__);
 
-- 
2.7.4

