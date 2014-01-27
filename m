From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: synaptics-rmi4 - Count IRQs before creating
 functions; save F01 container.
Date: Sun, 26 Jan 2014 22:36:58 -0800
Message-ID: <20140127063658.GB32605@core.coreip.homeip.net>
References: <1389390814-4063-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:35283 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbaA0GhC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jan 2014 01:37:02 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so5499188pbc.32
        for <linux-input@vger.kernel.org>; Sun, 26 Jan 2014 22:37:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389390814-4063-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Christopher,

On Fri, Jan 10, 2014 at 01:53:34PM -0800, Christopher Heiny wrote:
>  
>   err_free_data:
> +	rmi_free_function_list(rmi_dev);
> +	if (gpio_is_valid(pdata->attn_gpio))
> +		gpio_free(pdata->attn_gpio);
> +	devm_kfree(&rmi_dev->dev, data->irq_status);
> +	devm_kfree(&rmi_dev->dev, data->current_irq_mask);
> +	devm_kfree(&rmi_dev->dev, data->irq_mask_store);
> +	devm_kfree(&rmi_dev->dev, data);

It is rarely makes sense to explicitly free devm-managed data. In
general I find that RMI code is very confused about when devm-managed
resources are released (they only released after failed probe or remove,
but we use devm_kzalloc to allocate function's interrupt masks during
device creation and they will get freed only when parent unbinds, etc).

Given that you mentioned firmware flash in the work and I expect we'll
be destroying and re-creating functions and other data structures at
will I think we should limit use of devm APIs so that lifetime
management is explicit and clear.

I tried adjusting the patch so that it works with the version of PDT
cleanup patch I posted a few minutes ago, please let me know what you
think.

Thanks.

-- 
Dmitry

Input: synaptics-rmi4 - count IRQs before creating functions

From: Christopher Heiny <cheiny@synaptics.com>

Because creating a function can trigger events that result in the IRQ related
storage being accessed, we need to count the IRQs and allocate their storage
before the functions are created, rather than counting them as the functions
are created and allocating them afterwards. Since we know the number of IRQs
already, we can allocate the mask at function creation time, rather than in
a post-creation loop.  Also, the F01 function_container is needed elsewhere,
so we need to save it here.

In order to keep the IRQ count logic sane in bootloader mode, we move the
check for bootloader mode from F01 initialization to the IRQ counting routine.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c |  250 +++++++++++++++++++++++----------------
 drivers/input/rmi4/rmi_driver.h |    1 
 drivers/input/rmi4/rmi_f01.c    |    9 -
 3 files changed, 149 insertions(+), 111 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index b9eb8a5..3362f58 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -184,6 +184,7 @@ static void rmi_free_function_list(struct rmi_device *rmi_dev)
 	list_for_each_entry_safe_reverse(fn, tmp,
 					 &data->function_list, node) {
 		list_del(&fn->node);
+		kfree(fn->irq_mask);
 		rmi_unregister_function(fn);
 	}
 }
@@ -256,21 +257,20 @@ static int rmi_driver_process_config_requests(struct rmi_device *rmi_dev)
 	return 0;
 }
 
-static void process_one_interrupt(struct rmi_function *fn,
-		unsigned long *irq_status, struct rmi_driver_data *data)
+static void process_one_interrupt(struct rmi_driver_data *data,
+				  struct rmi_function *fn)
 {
 	struct rmi_function_handler *fh;
-	DECLARE_BITMAP(irq_bits, data->num_of_irq_regs);
 
 	if (!fn || !fn->dev.driver)
 		return;
 
 	fh = to_rmi_function_handler(fn->dev.driver);
 	if (fn->irq_mask && fh->attention) {
-		bitmap_and(irq_bits, irq_status, fn->irq_mask,
-				data->irq_count);
-		if (!bitmap_empty(irq_bits, data->irq_count))
-			fh->attention(fn, irq_bits);
+		bitmap_and(data->fn_irq_bits, data->irq_status, fn->irq_mask,
+			   data->irq_count);
+		if (!bitmap_empty(data->fn_irq_bits, data->irq_count))
+			fh->attention(fn, data->fn_irq_bits);
 	}
 }
 
@@ -306,11 +306,9 @@ static int process_interrupt_requests(struct rmi_device *rmi_dev)
 	 * recent kernels (say, 3.3 and higher), this should be switched to
 	 * use irq_chip.
 	 */
-	list_for_each_entry(entry, &data->function_list, node) {
+	list_for_each_entry(entry, &data->function_list, node)
 		if (entry->irq_mask)
-			process_one_interrupt(entry, data->irq_status,
-					      data);
-	}
+			process_one_interrupt(data, entry);
 
 	return 0;
 }
@@ -469,12 +467,12 @@ static int rmi_driver_reset_handler(struct rmi_device *rmi_dev)
 int rmi_driver_irq_get_mask(struct rmi_device *rmi_dev,
 			    struct rmi_function *fn)
 {
-	int i;
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	int i;
 
 	/* call devm_kcalloc when it will be defined in kernel in future */
 	fn->irq_mask = devm_kzalloc(&rmi_dev->dev,
-			BITS_TO_LONGS(data->irq_count)*sizeof(unsigned long),
+			BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
 			GFP_KERNEL);
 
 	if (fn->irq_mask) {
@@ -604,7 +602,7 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
 			return error;
 		}
 
-		mdelay(pdata->reset_delay_ms);
+		mdelay(pdata->reset_delay_ms ?: DEFAULT_RESET_DELAY_MS);
 
 		return RMI_SCAN_DONE;
 	}
@@ -613,6 +611,51 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
 	return pdt->page_start == 0 ? RMI_SCAN_CONTINUE : -ENODEV;
 }
 
+/* Indicates that flash programming is enabled (bootloader mode). */
+#define RMI_F01_STATUS_BOOTLOADER(status)	(!!((status) & 0x40))
+
+/*
+ * Given the PDT entry for F01, read the device status register to determine
+ * if we're stuck in bootloader mode or not.
+ *
+ */
+static int rmi_check_bootloader_mode(struct rmi_device *rmi_dev,
+				     const struct pdt_entry *pdt)
+{
+	int error;
+	u8 device_status;
+
+	error = rmi_read(rmi_dev, pdt->data_base_addr + pdt->page_start,
+			 &device_status);
+	if (error) {
+		dev_err(&rmi_dev->dev,
+			"Failed to read device status: %d\n", error);
+		return error;
+	}
+
+	return RMI_F01_STATUS_BOOTLOADER(device_status);
+}
+
+static int rmi_count_irqs(struct rmi_device *rmi_dev,
+			  void *ctx, const struct pdt_entry *pdt)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	int *irq_count = ctx;
+
+	*irq_count += pdt->interrupt_source_count;
+	if (pdt->function_number == 0x01) {
+		data->f01_bootloader_mode =
+			rmi_check_bootloader_mode(rmi_dev, pdt);
+		if (data->f01_bootloader_mode) {
+			dev_warn(&rmi_dev->dev,
+				 "WARNING: RMI4 device is in bootloader mode!\n");
+			return RMI_SCAN_DONE;
+		}
+	}
+
+	return RMI_SCAN_CONTINUE;
+}
+
 static int rmi_create_function(struct rmi_device *rmi_dev,
 			       void *ctx, const struct pdt_entry *pdt)
 {
@@ -621,6 +664,7 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
 	int *current_irq_count = ctx;
 	struct rmi_function *fn;
+	int i;
 	int error;
 
 	dev_dbg(dev, "Initializing F%02X for %s.\n",
@@ -634,53 +678,46 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	}
 
 	INIT_LIST_HEAD(&fn->node);
+	rmi_driver_copy_pdt_to_fd(pdt, &fn->fd);
 
 	fn->rmi_dev = rmi_dev;
-	fn->num_of_irqs = pdt->interrupt_source_count;
 
+	fn->num_of_irqs = pdt->interrupt_source_count;
 	fn->irq_pos = *current_irq_count;
 	*current_irq_count += fn->num_of_irqs;
 
-	rmi_driver_copy_pdt_to_fd(pdt, &fn->fd);
+	fn->irq_mask = kcalloc(BITS_TO_LONGS(data->irq_count),
+			       sizeof(unsigned long),
+			       GFP_KERNEL);
+	if (!fn->irq_mask) {
+		dev_err(dev, "%s: Failed to create irq_mask for F%02X.\n",
+			__func__, pdt->function_number);
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	for (i = 0; i < fn->num_of_irqs; i++)
+		__set_bit(fn->irq_pos + i, fn->irq_mask);
 
 	error = rmi_register_function(fn);
 	if (error)
-		goto err_free_mem;
+		goto err_free_irq_mask;
+
+	if (pdt->function_number == 0x01)
+		data->f01_container = fn;
 
 	list_add_tail(&fn->node, &data->function_list);
 
-	return data->f01_bootloader_mode ? RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
+	return pdt->function_number == 0x01 && data->f01_bootloader_mode ?
+		RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
 
+err_free_irq_mask:
+	kfree(fn->irq_mask);
 err_free_mem:
 	kfree(fn);
 	return error;
 }
 
-static int rmi_create_functions(struct rmi_device *rmi_dev)
-{
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	int irq_count = 0;
-	int retval;
-
-	/*
-	 * XXX need to make sure we create F01 first...
-	 * XXX or do we?  It might not be required in the updated structure.
-	 */
-	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
-	if (retval < 0)
-		return retval;
-
-	/*
-	 * TODO: I think we need to count the IRQs before creating the
-	 * functions.
-	 */
-	data->irq_count = irq_count;
-	data->num_of_irq_regs = (irq_count + 7) / 8;
-
-	return 0;
-}
-
-
 #ifdef CONFIG_PM_SLEEP
 static int rmi_driver_suspend(struct device *dev)
 {
@@ -747,9 +784,9 @@ static SIMPLE_DEV_PM_OPS(rmi_driver_pm, rmi_driver_suspend, rmi_driver_resume);
 static int rmi_driver_remove(struct device *dev)
 {
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	const struct rmi_device_platform_data *pdata =
 					to_rmi_platform_data(rmi_dev);
-	const struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 
 	disable_sensor(rmi_dev);
 	rmi_free_function_list(rmi_dev);
@@ -757,17 +794,22 @@ static int rmi_driver_remove(struct device *dev)
 	if (data->gpio_held)
 		gpio_free(pdata->attn_gpio);
 
+	kfree(data->irq_status);
+	kfree(data);
+
 	return 0;
 }
 
 static int rmi_driver_probe(struct device *dev)
 {
 	struct rmi_driver *rmi_driver;
-	struct rmi_driver_data *data = NULL;
-	struct rmi_function *fn;
-	struct rmi_device_platform_data *pdata;
-	int retval = 0;
+	struct rmi_driver_data *data;
+	const struct rmi_device_platform_data *pdata;
 	struct rmi_device *rmi_dev;
+	size_t size;
+	void *irq_memory;
+	int irq_count;
+	int retval;
 
 	dev_dbg(dev, "%s: Starting probe.\n", __func__);
 
@@ -787,6 +829,7 @@ static int rmi_driver_probe(struct device *dev)
 		dev_err(dev, "%s: Failed to allocate driver data.\n", __func__);
 		return -ENOMEM;
 	}
+
 	INIT_LIST_HEAD(&data->function_list);
 	data->rmi_dev = rmi_dev;
 	dev_set_drvdata(&rmi_dev->dev, data);
@@ -813,80 +856,79 @@ static int rmi_driver_probe(struct device *dev)
 	 * and leave the customer's device unusable.  So we warn them, and
 	 * continue processing.
 	 */
-	if (!pdata->reset_delay_ms)
-		pdata->reset_delay_ms = DEFAULT_RESET_DELAY_MS;
 	retval = rmi_scan_pdt(rmi_dev, NULL, rmi_initial_reset);
-	if (retval)
+	if (retval < 0)
 		dev_warn(dev, "RMI initial reset failed! Continuing in spite of this.\n");
 
-	retval = rmi_create_functions(rmi_dev);
+	retval = rmi_read(rmi_dev, PDT_PROPERTIES_LOCATION, &data->pdt_props);
 	if (retval) {
-		dev_err(dev, "PDT scan for %s failed with code %d.\n",
-			pdata->sensor_name, retval);
-		goto err_free_data;
+		/*
+		 * We'll print out a warning and continue since failure to
+		 * get the PDT properties is not a cause to fail.
+		 */
+		dev_warn(dev, "Could not read PDT properties from %#06x: %d. Assuming 0x00.\n",
+			 PDT_PROPERTIES_LOCATION, retval);
 	}
 
-	if (!data->f01_container) {
-		dev_err(dev, "missing F01 container!\n");
-		retval = -EINVAL;
-		goto err_free_data;
+	/*
+	 * We need to count the IRQs and allocate their storage before scanning
+	 * the PDT and creating the function entries, because adding a new
+	 * function can trigger events that result in the IRQ related storage
+	 * being accessed.
+	 */
+	dev_dbg(dev, "Counting IRQs.\n");
+	irq_count = 0;
+	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_count_irqs);
+	if (retval < 0) {
+		dev_err(dev, "IRQ counting for %s failed with code %d.\n",
+			pdata->sensor_name, retval);
+		goto err_free_mem;
 	}
 
-	list_for_each_entry(fn, &data->function_list, node) {
-		retval = rmi_driver_irq_get_mask(rmi_dev, fn);
-		if (retval < 0) {
-			dev_err(dev, "%s: Failed to create irq_mask.\n",
-				__func__);
-			goto err_free_data;
-		}
-	}
+	data->irq_count = irq_count;
+	data->num_of_irq_regs = (data->irq_count + 7) / 8;
 
-	retval = rmi_read(rmi_dev, PDT_PROPERTIES_LOCATION, &data->pdt_props);
-	if (retval < 0) {
-		/*
-		 * we'll print out a warning and continue since
-		 * failure to get the PDT properties is not a cause to fail
-		 */
-		dev_warn(dev, "Could not read PDT properties from %#06x. Assuming 0x00.\n",
-			 PDT_PROPERTIES_LOCATION);
+	mutex_init(&data->irq_mutex);
+
+	size = BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long);
+	irq_memory = kzalloc(size * 4, GFP_KERNEL);
+	if (!irq_memory) {
+		dev_err(dev, "Failed to allocate memory for irq masks.\n");
+		goto err_free_mem;
 	}
 
-	mutex_init(&data->irq_mutex);
-	data->irq_status = devm_kzalloc(dev,
-		BITS_TO_LONGS(data->irq_count)*sizeof(unsigned long),
-		GFP_KERNEL);
-	if (!data->irq_status) {
-		dev_err(dev, "Failed to allocate irq_status.\n");
-		retval = -ENOMEM;
-		goto err_free_data;
+	data->irq_status	= irq_memory + size * 0;
+	data->fn_irq_bits	= irq_memory + size * 1;
+	data->current_irq_mask	= irq_memory + size * 2;
+	data->irq_mask_store	= irq_memory + size * 3;
+
+	/*
+	 * XXX need to make sure we create F01 first...
+	 * XXX or do we?  It might not be required in the updated structure.
+	 */
+	irq_count = 0;
+	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
+	if (retval < 0) {
+		dev_err(dev, "Function creation failed with code %d.\n",
+			retval);
+		goto err_destroy_functions;
 	}
 
-	data->current_irq_mask = devm_kzalloc(dev,
-				data->num_of_irq_regs,
-				GFP_KERNEL);
-	if (!data->current_irq_mask) {
-		dev_err(dev, "Failed to allocate current_irq_mask.\n");
-		retval = -ENOMEM;
-		goto err_free_data;
+	if (!data->f01_container) {
+		dev_err(dev, "missing F01 container!\n");
+		retval = -EINVAL;
+		goto err_destroy_functions;
 	}
 
 	retval = rmi_read_block(rmi_dev,
-				data->f01_container->fd.control_base_addr+1,
+				data->f01_container->fd.control_base_addr + 1,
 				data->current_irq_mask, data->num_of_irq_regs);
 	if (retval < 0) {
 		dev_err(dev, "%s: Failed to read current IRQ mask.\n",
 			__func__);
-		goto err_free_data;
+		goto err_destroy_functions;
 	}
 
-	data->irq_mask_store = devm_kzalloc(dev,
-		BITS_TO_LONGS(data->irq_count)*sizeof(unsigned long),
-		GFP_KERNEL);
-	if (!data->irq_mask_store) {
-		dev_err(dev, "Failed to allocate mask store.\n");
-		retval = -ENOMEM;
-		goto err_free_data;
-	}
 	if (IS_ENABLED(CONFIG_PM)) {
 		data->pm_data = pdata->pm_data;
 		data->pre_suspend = pdata->pre_suspend;
@@ -951,8 +993,12 @@ static int rmi_driver_probe(struct device *dev)
 
 	return 0;
 
- err_free_data:
-	return retval;
+err_destroy_functions:
+	rmi_free_function_list(rmi_dev);
+	kfree(irq_memory);
+err_free_mem:
+	kfree(data);
+	return retval < 0 ? retval : 0;
 }
 
 struct rmi_driver rmi_physical_driver = {
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 9ecd31b..d071ff5 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -45,6 +45,7 @@ struct rmi_driver_data {
 	int num_of_irq_regs;
 	int irq_count;
 	unsigned long *irq_status;
+	unsigned long *fn_irq_bits;
 	unsigned long *current_irq_mask;
 	unsigned long *irq_mask_store;
 	bool irq_stored;
diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index cf1081f..381ad60 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -59,8 +59,6 @@ struct f01_basic_properties {
 
 /* Most recent device status event */
 #define RMI_F01_STATUS_CODE(status)		((status) & 0x0f)
-/* Indicates that flash programming is enabled (bootloader mode). */
-#define RMI_F01_STATUS_BOOTLOADER(status)	(!!((status) & 0x40))
 /* The device has lost its configuration for some reason. */
 #define RMI_F01_STATUS_UNCONFIGURED(status)	(!!((status) & 0x80))
 
@@ -372,13 +370,6 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 		goto error_exit;
 	}
 
-	driver_data->f01_bootloader_mode =
-			RMI_F01_STATUS_BOOTLOADER(data->device_status);
-	if (driver_data->f01_bootloader_mode)
-		dev_warn(&rmi_dev->dev,
-			 "WARNING: RMI4 device is in bootloader mode!\n");
-
-
 	if (RMI_F01_STATUS_UNCONFIGURED(data->device_status)) {
 		dev_err(&fn->dev,
 			"Device was reset during configuration process, status: %#02x!\n",
