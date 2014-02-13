From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4: Use put_device() and
 device_type.release() to free storage.
Date: Wed, 12 Feb 2014 22:15:24 -0800
Message-ID: <20140213061524.GA15260@core.coreip.homeip.net>
References: <1392160410-8293-1-git-send-email-cheiny@synaptics.com>
 <20140212064925.GC15855@core.coreip.homeip.net>
 <52FC2E68.1060709@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:37234 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbaBMGPf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 01:15:35 -0500
Received: by mail-pb0-f49.google.com with SMTP id up15so10296202pbc.22
        for <linux-input@vger.kernel.org>; Wed, 12 Feb 2014 22:15:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52FC2E68.1060709@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Courtney Cavin <courtney.cavin@sonymobile.com>

On Wed, Feb 12, 2014 at 06:31:04PM -0800, Christopher Heiny wrote:
> Input: synaptics-rmi4 - Use put_device() and device_type.release()
> to free storage.
> 
> From: Christopher Heiny <cheiny@synaptics.com>
> 
> For rmi_sensor and rmi_function device_types, use put_device() and
> the assocated device_type.release() function to clean up related
> structures and storage in the correct and safe order.
> 
> Allocate irq_mask as part of struct rmi_function.
> 
> Delete unused rmi_driver_irq_get_mask() function.
> 
> Suggested-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> 
> ---
> 
>  drivers/input/rmi4/rmi_bus.c    | 17 ++++++++-------
>  drivers/input/rmi4/rmi_bus.h    |  2 +-
>  drivers/input/rmi4/rmi_driver.c | 46
> +++++------------------------------------
>  3 files changed, 15 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index 96a76e7..6342b45 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -34,6 +34,7 @@ static struct dentry *rmi_debugfs_root;
>  static void rmi_release_device(struct device *dev)
>  {
>  	struct rmi_device *rmi_dev = to_rmi_device(dev);
> +
>  	kfree(rmi_dev);
>  }
> 
> @@ -94,8 +95,7 @@ int rmi_register_transport_device(struct
> rmi_transport_dev *xport)
>  		return -EINVAL;
>  	}
> 
> -	rmi_dev = devm_kzalloc(xport->dev,
> -				sizeof(struct rmi_device), GFP_KERNEL);
> +	rmi_dev = kzalloc(sizeof(struct rmi_device), GFP_KERNEL);
>  	if (!rmi_dev)
>  		return -ENOMEM;
> 
> @@ -112,8 +112,10 @@ int rmi_register_transport_device(struct
> rmi_transport_dev *xport)
>  	rmi_physical_setup_debugfs(rmi_dev);
> 
>  	error = device_register(&rmi_dev->dev);
> -	if (error)
> +	if (error) {
> +		put_device(&rmi_dev->dev);

We also need to tear down debugfs here.

>  		return error;
> +	}
> 
>  	dev_dbg(xport->dev, "%s: Registered %s as %s.\n", __func__,
>  		pdata->sensor_name, dev_name(&rmi_dev->dev));
> @@ -142,6 +144,7 @@ EXPORT_SYMBOL(rmi_unregister_transport_device);
>  static void rmi_release_function(struct device *dev)
>  {
>  	struct rmi_function *fn = to_rmi_function(dev);
> +
>  	kfree(fn);
>  }
> 
> @@ -240,16 +243,14 @@ int rmi_register_function(struct rmi_function *fn)
>  		dev_err(&rmi_dev->dev,
>  			"Failed device_register function device %s\n",
>  			dev_name(&fn->dev));
> -		goto error_exit;
> +		rmi_function_teardown_debugfs(fn);
> +		put_device(&fn->dev);

This is not proper place to free structures since
rmi_register_function() was not the one that allocated them.

OK, I split the rmi_driver_irq_get_mask() removal into a separate patch
and applied it, this leaves us with the patch below (BTW, your mailed
damaged - line wrapped - the patch so I had to reconstruct it).
I switched from using device_register/device_unregister to
device_initialize/device_add/device_del/put_device as it allows better
control over error unwinding and destroying the objects which is
important if you want to delete debugfs entries once all fucntion
handler have been unregister but before our memory is gone.

Thanks.

-- 
Dmitry

Input: synaptics-rmi4 - use put_device() to free devices

From: Christopher Heiny <cheiny@synaptics.com>

For rmi_sensor and rmi_function device_types, use put_device() and
the associated device_type->release() function to clean up related
structures and storage in the correct and safe order.

Allocate irq_mask as part of struct rmi_function.

Suggested-by: Courtney Cavin <courtney.cavin@sonymobile.com>
Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_bus.c    |   30 +++++++++++++++++++++---------
 drivers/input/rmi4/rmi_bus.h    |    7 ++++---
 drivers/input/rmi4/rmi_driver.c |   25 +++++++------------------
 3 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 96a76e7..7efe7ed 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -34,6 +34,7 @@ static struct dentry *rmi_debugfs_root;
 static void rmi_release_device(struct device *dev)
 {
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
+
 	kfree(rmi_dev);
 }
 
@@ -94,11 +95,12 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
 		return -EINVAL;
 	}
 
-	rmi_dev = devm_kzalloc(xport->dev,
-				sizeof(struct rmi_device), GFP_KERNEL);
+	rmi_dev = kzalloc(sizeof(struct rmi_device), GFP_KERNEL);
 	if (!rmi_dev)
 		return -ENOMEM;
 
+	device_initialize(&rmi_dev->dev);
+
 	rmi_dev->xport = xport;
 	rmi_dev->number = atomic_inc_return(&transport_device_count) - 1;
 
@@ -111,14 +113,19 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
 
 	rmi_physical_setup_debugfs(rmi_dev);
 
-	error = device_register(&rmi_dev->dev);
+	error = device_add(&rmi_dev->dev);
 	if (error)
-		return error;
+		goto err_put_device;
 
 	dev_dbg(xport->dev, "%s: Registered %s as %s.\n", __func__,
 		pdata->sensor_name, dev_name(&rmi_dev->dev));
 
 	return 0;
+
+err_put_device:
+	rmi_physical_teardown_debugfs(rmi_dev);
+	put_device(&rmi_dev->dev);
+	return error;
 }
 EXPORT_SYMBOL_GPL(rmi_register_transport_device);
 
@@ -131,8 +138,9 @@ void rmi_unregister_transport_device(struct rmi_transport_dev *xport)
 {
 	struct rmi_device *rmi_dev = xport->rmi_dev;
 
+	device_del(&rmi_dev->dev);
 	rmi_physical_teardown_debugfs(rmi_dev);
-	device_unregister(&rmi_dev->dev);
+	put_device(&rmi_dev->dev);
 }
 EXPORT_SYMBOL(rmi_unregister_transport_device);
 
@@ -142,6 +150,7 @@ EXPORT_SYMBOL(rmi_unregister_transport_device);
 static void rmi_release_function(struct device *dev)
 {
 	struct rmi_function *fn = to_rmi_function(dev);
+
 	kfree(fn);
 }
 
@@ -226,6 +235,8 @@ int rmi_register_function(struct rmi_function *fn)
 	struct rmi_device *rmi_dev = fn->rmi_dev;
 	int error;
 
+	device_initialize(&fn->dev);
+
 	dev_set_name(&fn->dev, "%s.fn%02x",
 		     dev_name(&rmi_dev->dev), fn->fd.function_number);
 
@@ -235,27 +246,28 @@ int rmi_register_function(struct rmi_function *fn)
 
 	rmi_function_setup_debugfs(fn);
 
-	error = device_register(&fn->dev);
+	error = device_add(&fn->dev);
 	if (error) {
 		dev_err(&rmi_dev->dev,
 			"Failed device_register function device %s\n",
 			dev_name(&fn->dev));
-		goto error_exit;
+		goto err_teardown_debugfs;
 	}
 
 	dev_dbg(&rmi_dev->dev, "Registered F%02X.\n", fn->fd.function_number);
 
 	return 0;
 
-error_exit:
+err_teardown_debugfs:
 	rmi_function_teardown_debugfs(fn);
 	return error;
 }
 
 void rmi_unregister_function(struct rmi_function *fn)
 {
+	device_del(&fn->dev);
 	rmi_function_teardown_debugfs(fn);
-	device_unregister(&fn->dev);
+	put_device(&fn->dev);
 }
 
 /**
diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 5ad94c6..1672b05 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -45,14 +45,15 @@ struct rmi_function {
 	struct rmi_function_descriptor fd;
 	struct rmi_device *rmi_dev;
 	struct device dev;
-	int num_of_irqs;
-	int irq_pos;
-	unsigned long *irq_mask;
 	struct list_head node;
 
 #ifdef CONFIG_RMI4_DEBUG
 	struct dentry *debugfs_root;
 #endif
+
+	unsigned int num_of_irqs;
+	unsigned int irq_pos;
+	unsigned long irq_mask[];
 };
 
 #define to_rmi_function(d)	container_of(d, struct rmi_function, dev)
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 473efbc..788343a 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -185,7 +185,6 @@ static void rmi_free_function_list(struct rmi_device *rmi_dev)
 	list_for_each_entry_safe_reverse(fn, tmp,
 					 &data->function_list, node) {
 		list_del(&fn->node);
-		kfree(fn->irq_mask);
 		rmi_unregister_function(fn);
 	}
 }
@@ -617,7 +616,7 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
 }
 
 static int rmi_create_function(struct rmi_device *rmi_dev,
-			      void *ctx, const struct pdt_entry *pdt)
+			       void *ctx, const struct pdt_entry *pdt)
 {
 	struct device *dev = &rmi_dev->dev;
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
@@ -630,7 +629,9 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	dev_dbg(dev, "Initializing F%02X for %s.\n",
 		pdt->function_number, pdata->sensor_name);
 
-	fn = kzalloc(sizeof(struct rmi_function), GFP_KERNEL);
+	fn = kzalloc(sizeof(struct rmi_function) +
+			BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
+		     GFP_KERNEL);
 	if (!fn) {
 		dev_err(dev, "Failed to allocate memory for F%02X\n",
 			pdt->function_number);
@@ -646,22 +647,12 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	fn->irq_pos = *current_irq_count;
 	*current_irq_count += fn->num_of_irqs;
 
-	fn->irq_mask = kzalloc(
-		BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
-		GFP_KERNEL);
-	if (!fn->irq_mask) {
-		dev_err(dev, "%s: Failed to create irq_mask for F%02X.\n",
-			__func__, pdt->function_number);
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
-
 	for (i = 0; i < fn->num_of_irqs; i++)
 		set_bit(fn->irq_pos + i, fn->irq_mask);
 
 	error = rmi_register_function(fn);
 	if (error)
-		goto err_free_irq_mask;
+		goto err_put_fn;
 
 	if (pdt->function_number == 0x01)
 		data->f01_container = fn;
@@ -670,10 +661,8 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 
 	return RMI_SCAN_CONTINUE;
 
-err_free_irq_mask:
-	kfree(fn->irq_mask);
-err_free_mem:
-	kfree(fn);
+err_put_fn:
+	put_device(&fn->dev);
 	return error;
 }
 
