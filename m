From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 05/11] Input: synaptics-rmi4 - call rmi_driver_process_config_requests in enable_sensor
Date: Tue, 23 Jun 2015 15:17:24 -0400
Message-ID: <1435087050-11444-6-git-send-email-benjamin.tissoires@redhat.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44094 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933042AbbFWTRm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2015 15:17:42 -0400
In-Reply-To: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>
Cc: Stephen Chandler Paul <cpaul@redhat.com>, benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

The SMBus devices have their IRQs disabled after a reset. We need to
configure them by calling rmi_driver_process_config_request() when
enabling the sensor.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_driver.c | 78 ++++++++++++++++++++++-------------------
 drivers/input/rmi4/rmi_f11.c    |  4 +++
 2 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index fe5f2f9..264bc62 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -136,42 +136,6 @@ static void disable_sensor(struct rmi_device *rmi_dev)
 	data->enabled = false;
 }
 
-static int enable_sensor(struct rmi_device *rmi_dev)
-{
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	struct rmi_transport_dev *xport;
-	int retval = 0;
-
-	if (data->enabled)
-		return 0;
-
-	if (rmi_dev->xport->ops->enable_device) {
-		retval = rmi_dev->xport->ops->enable_device(rmi_dev->xport);
-		if (retval)
-			return retval;
-	}
-
-	xport = rmi_dev->xport;
-	if (data->irq) {
-		retval = request_threaded_irq(data->irq,
-				xport->hard_irq ? xport->hard_irq : NULL,
-				xport->irq_thread ?
-					xport->irq_thread : rmi_irq_thread,
-				data->irq_flags,
-				dev_name(&rmi_dev->dev), xport);
-		if (retval)
-			return retval;
-	} else if (data->polling) {
-		retval = enable_polling(rmi_dev);
-		if (retval < 0)
-			return retval;
-	}
-
-	data->enabled = true;
-
-	return rmi_process_interrupt_requests(rmi_dev);
-}
-
 static void rmi_free_function_list(struct rmi_device *rmi_dev)
 {
 	struct rmi_function *fn, *tmp;
@@ -318,6 +282,46 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 }
 EXPORT_SYMBOL_GPL(rmi_process_interrupt_requests);
 
+static int enable_sensor(struct rmi_device *rmi_dev)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_transport_dev *xport;
+	int retval = 0;
+
+	if (data->enabled)
+		return 0;
+
+	if (rmi_dev->xport->ops->enable_device) {
+		retval = rmi_dev->xport->ops->enable_device(rmi_dev->xport);
+		if (retval)
+			return retval;
+	}
+
+	retval = rmi_driver_process_config_requests(rmi_dev);
+	if (retval < 0)
+		return retval;
+
+	xport = rmi_dev->xport;
+	if (data->irq) {
+		retval = request_threaded_irq(data->irq,
+				xport->hard_irq ? xport->hard_irq : NULL,
+				xport->irq_thread ?
+					xport->irq_thread : rmi_irq_thread,
+				data->irq_flags,
+				dev_name(&rmi_dev->dev), xport);
+		if (retval)
+			return retval;
+	} else if (data->polling) {
+		retval = enable_polling(rmi_dev);
+		if (retval < 0)
+			return retval;
+	}
+
+	data->enabled = true;
+
+	return rmi_process_interrupt_requests(rmi_dev);
+}
+
 /**
  * rmi_driver_set_input_params - set input device id and other data.
  *
@@ -960,7 +964,7 @@ static int rmi_driver_probe(struct device *dev)
 
 	if (data->f01_container->dev.driver) {
 		/* Driver already bound, so enable ATTN now. */
-		enable_sensor(rmi_dev);
+		return enable_sensor(rmi_dev);
 	}
 
 	return 0;
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 4bdf4a5..99d6181 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1440,9 +1440,13 @@ static int rmi_f11_config(struct rmi_function *fn)
 
 	if (!sensor->report_abs)
 		drv->clear_irq_bits(fn->rmi_dev, f11->abs_mask);
+	else
+		drv->set_irq_bits(fn->rmi_dev, f11->abs_mask);
 
 	if (!sensor->report_rel)
 		drv->clear_irq_bits(fn->rmi_dev, f11->rel_mask);
+	else
+		drv->set_irq_bits(fn->rmi_dev, f11->rel_mask);
 
 	rc = f11_write_control_regs(fn, &f11->sensor.sens_query,
 			   &f11->dev_controls, fn->fd.query_base_addr);
-- 
2.4.3

