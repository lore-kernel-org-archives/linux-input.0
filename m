From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1 1/2] Input: synaptics-rmi4 - factor out functions from probe
Date: Tue,  5 Jul 2016 17:11:14 +0100
Message-ID: <1467735075-530-2-git-send-email-nick@shmanahar.org>
References: <1467735075-530-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:29705 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755208AbcGEQLb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2016 12:11:31 -0400
In-Reply-To: <1467735075-530-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Older <jon.older@itdev.co.uk>, nick.dyer@itdev.co.uk, Nick Dyer <nick@shmanahar.org>

---
 drivers/input/rmi4/rmi_driver.c | 139 +++++++++++++++++++++++++---------------
 1 file changed, 86 insertions(+), 53 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index faa295e..543cf7a 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -39,6 +39,8 @@ static void rmi_free_function_list(struct rmi_device *rmi_dev)
 	struct rmi_function *fn, *tmp;
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 
+	rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Freeing function list\n");
+
 	data->f01_container = NULL;
 
 	/* Doing it in the reverse order so F01 will be removed last */
@@ -842,15 +844,90 @@ static inline int rmi_driver_of_probe(struct device *dev,
 }
 #endif
 
+static int rmi_probe_interrupts(struct rmi_driver_data *data)
+{
+	struct rmi_device *rmi_dev = data->rmi_dev;
+	struct device *dev = &rmi_dev->dev;
+	int irq_count;
+	size_t size;
+	void *irq_memory;
+	int retval;
+
+	/*
+	 * We need to count the IRQs and allocate their storage before scanning
+	 * the PDT and creating the function entries, because adding a new
+	 * function can trigger events that result in the IRQ related storage
+	 * being accessed.
+	 */
+	rmi_dbg(RMI_DEBUG_CORE, dev, "%s: Counting IRQs.\n", __func__);
+	irq_count = 0;
+	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_count_irqs);
+	if (retval < 0) {
+		dev_err(dev, "IRQ counting failed with code %d.\n", retval);
+		return retval;
+	}
+	data->irq_count = irq_count;
+	data->num_of_irq_regs = (data->irq_count + 7) / 8;
+
+	size = BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long);
+	irq_memory = devm_kzalloc(dev, size * 4, GFP_KERNEL);
+	if (!irq_memory) {
+		dev_err(dev, "Failed to allocate memory for irq masks.\n");
+		return retval;
+	}
+
+	data->irq_status	= irq_memory + size * 0;
+	data->fn_irq_bits	= irq_memory + size * 1;
+	data->current_irq_mask	= irq_memory + size * 2;
+	data->new_irq_mask	= irq_memory + size * 3;
+
+	return retval;
+}
+
+static int rmi_init_functions(struct rmi_driver_data *data)
+{
+	struct rmi_device *rmi_dev = data->rmi_dev;
+	struct device *dev = &rmi_dev->dev;
+	int irq_count;
+	int retval;
+
+	irq_count = 0;
+	rmi_dbg(RMI_DEBUG_CORE, dev, "%s: Creating functions.\n", __func__);
+	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
+	if (retval < 0) {
+		dev_err(dev, "Function creation failed with code %d.\n",
+			retval);
+		goto err_destroy_functions;
+	}
+
+	if (!data->f01_container) {
+		dev_err(dev, "Missing F01 container!\n");
+		retval = -EINVAL;
+		goto err_destroy_functions;
+	}
+
+	retval = rmi_read_block(rmi_dev,
+				data->f01_container->fd.control_base_addr + 1,
+				data->current_irq_mask, data->num_of_irq_regs);
+	if (retval < 0) {
+		dev_err(dev, "%s: Failed to read current IRQ mask.\n",
+			__func__);
+		goto err_destroy_functions;
+	}
+
+	return 0;
+
+err_destroy_functions:
+	rmi_free_function_list(rmi_dev);
+	return retval;
+}
+
 static int rmi_driver_probe(struct device *dev)
 {
 	struct rmi_driver *rmi_driver;
 	struct rmi_driver_data *data;
 	struct rmi_device_platform_data *pdata;
 	struct rmi_device *rmi_dev;
-	size_t size;
-	void *irq_memory;
-	int irq_count;
 	int retval;
 
 	rmi_dbg(RMI_DEBUG_CORE, dev, "%s: Starting probe.\n",
@@ -916,35 +993,11 @@ static int rmi_driver_probe(struct device *dev)
 			 PDT_PROPERTIES_LOCATION, retval);
 	}
 
-	/*
-	 * We need to count the IRQs and allocate their storage before scanning
-	 * the PDT and creating the function entries, because adding a new
-	 * function can trigger events that result in the IRQ related storage
-	 * being accessed.
-	 */
-	rmi_dbg(RMI_DEBUG_CORE, dev, "Counting IRQs.\n");
-	irq_count = 0;
-	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_count_irqs);
-	if (retval < 0) {
-		dev_err(dev, "IRQ counting failed with code %d.\n", retval);
-		goto err;
-	}
-	data->irq_count = irq_count;
-	data->num_of_irq_regs = (data->irq_count + 7) / 8;
-
 	mutex_init(&data->irq_mutex);
 
-	size = BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long);
-	irq_memory = devm_kzalloc(dev, size * 4, GFP_KERNEL);
-	if (!irq_memory) {
-		dev_err(dev, "Failed to allocate memory for irq masks.\n");
+	retval = rmi_probe_interrupts(data);
+	if (retval)
 		goto err;
-	}
-
-	data->irq_status	= irq_memory + size * 0;
-	data->fn_irq_bits	= irq_memory + size * 1;
-	data->current_irq_mask	= irq_memory + size * 2;
-	data->new_irq_mask	= irq_memory + size * 3;
 
 	if (rmi_dev->xport->input) {
 		/*
@@ -961,36 +1014,16 @@ static int rmi_driver_probe(struct device *dev)
 			dev_err(dev, "%s: Failed to allocate input device.\n",
 				__func__);
 			retval = -ENOMEM;
-			goto err_destroy_functions;
+			goto err;
 		}
 		rmi_driver_set_input_params(rmi_dev, data->input);
 		data->input->phys = devm_kasprintf(dev, GFP_KERNEL,
 						"%s/input0", dev_name(dev));
 	}
 
-	irq_count = 0;
-	rmi_dbg(RMI_DEBUG_CORE, dev, "Creating functions.");
-	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
-	if (retval < 0) {
-		dev_err(dev, "Function creation failed with code %d.\n",
-			retval);
-		goto err_destroy_functions;
-	}
-
-	if (!data->f01_container) {
-		dev_err(dev, "Missing F01 container!\n");
-		retval = -EINVAL;
-		goto err_destroy_functions;
-	}
-
-	retval = rmi_read_block(rmi_dev,
-				data->f01_container->fd.control_base_addr + 1,
-				data->current_irq_mask, data->num_of_irq_regs);
-	if (retval < 0) {
-		dev_err(dev, "%s: Failed to read current IRQ mask.\n",
-			__func__);
-		goto err_destroy_functions;
-	}
+	retval = rmi_init_functions(data);
+	if (retval)
+		goto err;
 
 	if (data->input) {
 		rmi_driver_set_input_name(rmi_dev, data->input);
-- 
2.5.0

