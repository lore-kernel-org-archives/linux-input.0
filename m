From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 3/7] Input: synaptics-rmi4 - allow to add attention data
Date: Fri,  2 Dec 2016 12:41:52 +0100
Message-ID: <1480678916-6469-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1480678916-6469-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480678916-6469-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The HID implementation of RMI4 provides the data during
the interrupt (in the input report). We need to provide
a way for this transport driver to provide the attention
data while calling an IRQ.

We use a fifo in rmi_core to not lose any incoming event.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
---
 drivers/input/rmi4/rmi_driver.c | 49 +++++++++++++++++++++++++++++++++++++++--
 include/linux/rmi.h             | 11 +++++++++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index a718e51..85062e4 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -191,16 +191,53 @@ static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	return 0;
 }
 
+void rmi_set_attn_data(struct rmi_device *rmi_dev, unsigned long irq_status,
+		       void *data, size_t size)
+{
+	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi4_attn_data attn_data;
+	void *fifo_data;
+
+	if (!drvdata->enabled)
+		return;
+
+	fifo_data = kmemdup(data, size, GFP_ATOMIC);
+	if (!fifo_data)
+		return;
+
+	attn_data.irq_status = irq_status;
+	attn_data.size = size;
+	attn_data.data = fifo_data;
+
+	kfifo_put(&drvdata->attn_fifo, attn_data);
+}
+EXPORT_SYMBOL_GPL(rmi_set_attn_data);
+
 static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
 {
 	struct rmi_device *rmi_dev = dev_id;
-	int ret;
+	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi4_attn_data attn_data = {0};
+	int ret, count;
+
+	count = kfifo_get(&drvdata->attn_fifo, &attn_data);
+	if (count) {
+		*(drvdata->irq_status) = attn_data.irq_status;
+		rmi_dev->xport->attn_data = attn_data.data;
+		rmi_dev->xport->attn_size = attn_data.size;
+	}
 
 	ret = rmi_process_interrupt_requests(rmi_dev);
 	if (ret)
 		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
 			"Failed to process interrupt request: %d\n", ret);
 
+	if (count)
+		kfree(attn_data.data);
+
+	if (!kfifo_is_empty(&drvdata->attn_fifo))
+		return rmi_irq_fn(irq, dev_id);
+
 	return IRQ_HANDLED;
 }
 
@@ -880,8 +917,9 @@ void rmi_disable_irq(struct rmi_device *rmi_dev, bool enable_wake)
 {
 	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi4_attn_data attn_data = {0};
 	int irq = pdata->irq;
-	int retval;
+	int retval, count;
 
 	mutex_lock(&data->enabled_mutex);
 
@@ -898,6 +936,13 @@ void rmi_disable_irq(struct rmi_device *rmi_dev, bool enable_wake)
 				 retval);
 	}
 
+	/* make sure the fifo is clean */
+	while (!kfifo_is_empty(&data->attn_fifo)) {
+		count = kfifo_get(&data->attn_fifo, &attn_data);
+		if (count)
+			kfree(attn_data.data);
+	}
+
 out:
 	mutex_unlock(&data->enabled_mutex);
 }
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 7780e40..1d48656 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
+#include <linux/kfifo.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -331,6 +332,12 @@ struct rmi_device {
 
 };
 
+struct rmi4_attn_data {
+	unsigned long irq_status;
+	size_t size;
+	void *data;
+};
+
 struct rmi_driver_data {
 	struct list_head function_list;
 
@@ -357,11 +364,15 @@ struct rmi_driver_data {
 
 	bool enabled;
 	struct mutex enabled_mutex;
+	DECLARE_KFIFO(attn_fifo, struct rmi4_attn_data, 16);
 };
 
 int rmi_register_transport_device(struct rmi_transport_dev *xport);
 void rmi_unregister_transport_device(struct rmi_transport_dev *xport);
 
+void rmi_set_attn_data(struct rmi_device *rmi_dev, unsigned long irq_status,
+		       void *data, size_t size);
+
 int rmi_driver_suspend(struct rmi_device *rmi_dev, bool enable_wake);
 int rmi_driver_resume(struct rmi_device *rmi_dev, bool clear_wake);
 #endif
-- 
2.9.3
