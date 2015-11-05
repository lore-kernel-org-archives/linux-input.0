From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 03/26] Input: synaptics-rmi4 - explicitly request polling when needed
Date: Thu, 5 Nov 2015 15:34:03 -0800
Message-ID: <1446766466-30043-4-git-send-email-aduggan@synaptics.com>
References: <1446766466-30043-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446766466-30043-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Host Notify does not work with neither IRQ nor polling. Allow a RMI4 driver
to request or not polling depending on the attn_gpio.

When neither the internal IRQ or polling systems are used, the
transport driver can call rmi_process_interrupt_requests() to
trigger a process of the alert.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_driver.c | 18 +++++++++---------
 drivers/input/rmi4/rmi_driver.h |  3 +++
 include/linux/rmi.h             |  3 +++
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 95f9386..2fdc7e8 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -67,15 +67,13 @@ static irqreturn_t rmi_irq_thread(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int process_interrupt_requests(struct rmi_device *rmi_dev);
-
 static void rmi_poll_work(struct work_struct *work)
 {
 	struct rmi_driver_data *data =
 			container_of(work, struct rmi_driver_data, poll_work);
 	struct rmi_device *rmi_dev = data->rmi_dev;
 
-	process_interrupt_requests(rmi_dev);
+	rmi_process_interrupt_requests(rmi_dev);
 }
 
 /*
@@ -124,7 +122,7 @@ static void disable_sensor(struct rmi_device *rmi_dev)
 	if (!data->enabled)
 		return;
 
-	if (!data->irq)
+	if (data->polling)
 		disable_polling(rmi_dev);
 
 	if (rmi_dev->xport->ops->disable_device)
@@ -163,7 +161,7 @@ static int enable_sensor(struct rmi_device *rmi_dev)
 				dev_name(&rmi_dev->dev), xport);
 		if (retval)
 			return retval;
-	} else {
+	} else if (data->polling) {
 		retval = enable_polling(rmi_dev);
 		if (retval < 0)
 			return retval;
@@ -171,7 +169,7 @@ static int enable_sensor(struct rmi_device *rmi_dev)
 
 	data->enabled = true;
 
-	return process_interrupt_requests(rmi_dev);
+	return rmi_process_interrupt_requests(rmi_dev);
 }
 
 static void rmi_free_function_list(struct rmi_device *rmi_dev)
@@ -274,7 +272,7 @@ static void process_one_interrupt(struct rmi_driver_data *data,
 	}
 }
 
-static int process_interrupt_requests(struct rmi_device *rmi_dev)
+int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	struct device *dev = &rmi_dev->dev;
@@ -315,6 +313,7 @@ static int process_interrupt_requests(struct rmi_device *rmi_dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(rmi_process_interrupt_requests);
 
 /**
  * rmi_driver_set_input_params - set input device id and other data.
@@ -421,7 +420,7 @@ static int rmi_driver_irq_handler(struct rmi_device *rmi_dev, int irq)
 		return 0;
 	}
 
-	return process_interrupt_requests(rmi_dev);
+	return rmi_process_interrupt_requests(rmi_dev);
 }
 
 static int rmi_driver_reset_handler(struct rmi_device *rmi_dev)
@@ -949,10 +948,11 @@ static int rmi_driver_probe(struct device *dev)
 				}
 			}
 		}
-	} else {
+	} else if (pdata->attn_gpio == RMI_POLLING) {
 		data->poll_interval = ktime_set(0,
 			(pdata->poll_interval_ms ? pdata->poll_interval_ms :
 			DEFAULT_POLL_INTERVAL_MS) * 1000 * 1000);
+		data->polling = true;
 	}
 
 	if (data->f01_container->dev.driver) {
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 36ca34b..8a2d91a 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -43,6 +43,7 @@ struct rmi_driver_data {
 	u32 attn_count;
 	u32 irq_debug;	/* Should be bool, but debugfs wants u32 */
 	bool gpio_held;
+	bool polling;
 	int irq;
 	int irq_flags;
 	int num_of_irq_regs;
@@ -115,6 +116,8 @@ bool rmi_is_physical_driver(struct device_driver *);
 int rmi_register_physical_driver(void);
 void rmi_unregister_physical_driver(void);
 
+int rmi_process_interrupt_requests(struct rmi_device *rmi_dev);
+
 int rmi_register_f01_handler(void);
 void rmi_unregister_f01_handler(void);
 char *rmi_f01_get_product_ID(struct rmi_function *fn);
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 1d22985..b771f41 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -23,6 +23,9 @@
 #include <linux/wait.h>
 #include <linux/debugfs.h>
 
+#define RMI_POLLING	-1
+#define RMI_CUSTOM_IRQ	-2
+
 enum rmi_attn_polarity {
 	RMI_ATTN_ACTIVE_LOW = 0,
 	RMI_ATTN_ACTIVE_HIGH = 1
-- 
2.1.4
