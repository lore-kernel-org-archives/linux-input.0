From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 03/13] Input: synaptics-rmi4 - add rmi_enable/disable_irq
Date: Tue, 29 Nov 2016 11:08:14 +0100
Message-ID: <1480414104-8524-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Set the .enabled boolean and trigger an event processing when enabling
for edge-triggered systems.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_driver.c | 83 +++++++++++++++++++++++++++++++----------
 drivers/input/rmi4/rmi_driver.h |  2 +
 include/linux/rmi.h             |  1 +
 3 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 2b17d8c..f04fc41 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -215,6 +215,7 @@ static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
 static int rmi_irq_init(struct rmi_device *rmi_dev)
 {
 	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	int irq_flags = irq_get_trigger_type(pdata->irq);
 	int ret;
 
@@ -232,6 +233,8 @@ static int rmi_irq_init(struct rmi_device *rmi_dev)
 		return ret;
 	}
 
+	data->enabled = true;
+
 	return 0;
 }
 
@@ -866,17 +869,54 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	return error;
 }
 
-int rmi_driver_suspend(struct rmi_device *rmi_dev, bool enable_wake)
+void rmi_enable_irq(struct rmi_device *rmi_dev, bool clear_wake)
 {
 	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	int irq = pdata->irq;
-	int retval = 0;
+	int irq_flags;
+	int retval;
 
-	retval = rmi_suspend_functions(rmi_dev);
-	if (retval)
-		dev_warn(&rmi_dev->dev, "Failed to suspend functions: %d\n",
-			retval);
+	mutex_lock(&data->enabled_mutex);
+
+	if (data->enabled)
+		goto out;
+
+	enable_irq(irq);
+	data->enabled = true;
+	if (clear_wake && device_may_wakeup(rmi_dev->xport->dev)) {
+		retval = disable_irq_wake(irq);
+		if (!retval)
+			dev_warn(&rmi_dev->dev,
+				 "Failed to disable irq for wake: %d\n",
+				 retval);
+	}
+
+	/*
+	 * Call rmi_process_interrupt_requests() after enabling irq,
+	 * otherwise we may lose interrupt on edge-triggered systems.
+	 */
+	irq_flags = irq_get_trigger_type(pdata->irq);
+	if (irq_flags & IRQ_TYPE_EDGE_BOTH)
+		rmi_process_interrupt_requests(rmi_dev);
+
+out:
+	mutex_unlock(&data->enabled_mutex);
+}
+
+void rmi_disable_irq(struct rmi_device *rmi_dev, bool enable_wake)
+{
+	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	int irq = pdata->irq;
+	int retval;
+
+	mutex_lock(&data->enabled_mutex);
+
+	if (!data->enabled)
+		goto out;
 
+	data->enabled = false;
 	disable_irq(irq);
 	if (enable_wake && device_may_wakeup(rmi_dev->xport->dev)) {
 		retval = enable_irq_wake(irq);
@@ -885,24 +925,30 @@ int rmi_driver_suspend(struct rmi_device *rmi_dev, bool enable_wake)
 				 "Failed to enable irq for wake: %d\n",
 				 retval);
 	}
+
+out:
+	mutex_unlock(&data->enabled_mutex);
+}
+
+int rmi_driver_suspend(struct rmi_device *rmi_dev, bool enable_wake)
+{
+	int retval;
+
+	retval = rmi_suspend_functions(rmi_dev);
+	if (retval)
+		dev_warn(&rmi_dev->dev, "Failed to suspend functions: %d\n",
+			retval);
+
+	rmi_disable_irq(rmi_dev, enable_wake);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(rmi_driver_suspend);
 
 int rmi_driver_resume(struct rmi_device *rmi_dev, bool clear_wake)
 {
-	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
-	int irq = pdata->irq;
 	int retval;
 
-	enable_irq(irq);
-	if (clear_wake && device_may_wakeup(rmi_dev->xport->dev)) {
-		retval = disable_irq_wake(irq);
-		if (!retval)
-			dev_warn(&rmi_dev->dev,
-				 "Failed to disable irq for wake: %d\n",
-				 retval);
-	}
+	rmi_enable_irq(rmi_dev, clear_wake);
 
 	retval = rmi_resume_functions(rmi_dev);
 	if (retval)
@@ -916,10 +962,8 @@ EXPORT_SYMBOL_GPL(rmi_driver_resume);
 static int rmi_driver_remove(struct device *dev)
 {
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
-	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
-	int irq = pdata->irq;
 
-	disable_irq(irq);
+	rmi_disable_irq(rmi_dev, false);
 
 	rmi_f34_remove_sysfs(rmi_dev);
 	rmi_free_function_list(rmi_dev);
@@ -1108,6 +1152,7 @@ static int rmi_driver_probe(struct device *dev)
 	}
 
 	mutex_init(&data->irq_mutex);
+	mutex_init(&data->enabled_mutex);
 
 	retval = rmi_probe_interrupts(data);
 	if (retval)
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 5b201f3..c9fe3d3 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -101,6 +101,8 @@ int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
 		 int (*callback)(struct rmi_device *rmi_dev, void *ctx,
 		 const struct pdt_entry *entry));
 int rmi_probe_interrupts(struct rmi_driver_data *data);
+void rmi_enable_irq(struct rmi_device *rmi_dev, bool clear_wake);
+void rmi_disable_irq(struct rmi_device *rmi_dev, bool enable_wake);
 int rmi_init_functions(struct rmi_driver_data *data);
 int rmi_initial_reset(struct rmi_device *rmi_dev, void *ctx,
 		      const struct pdt_entry *pdt);
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 0b118ab..621f098 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -356,6 +356,7 @@ struct rmi_driver_data {
 	u8 num_tx_electrodes;
 
 	bool enabled;
+	struct mutex enabled_mutex;
 };
 
 int rmi_register_transport_device(struct rmi_transport_dev *xport);
-- 
2.7.4
