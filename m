From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4: Use put_device() and
 device_type.release() to free storage.
Date: Tue, 11 Feb 2014 22:49:25 -0800
Message-ID: <20140212064925.GC15855@core.coreip.homeip.net>
References: <1392160410-8293-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:44385 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbaBLGt3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Feb 2014 01:49:29 -0500
Received: by mail-pa0-f49.google.com with SMTP id hz1so8706122pad.8
        for <linux-input@vger.kernel.org>; Tue, 11 Feb 2014 22:49:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392160410-8293-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Courtney Cavin <courtney.cavin@sonymobile.com>

On Tue, Feb 11, 2014 at 03:13:30PM -0800, Christopher Heiny wrote:
> For rmi_sensor and rmi_function device_types, use put_device() and
> the assocated device_type.release() function to clean up related
> structures and storage in the correct and safe order.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Linux Walleij <linus.walleij@linaro.org>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Courtney Cavin <courtney.cavin@sonymobile.com>
> 
> ---
> 
>  drivers/input/rmi4/rmi_bus.c    | 65 +++++++++++++++--------------------------
>  drivers/input/rmi4/rmi_driver.c | 11 ++-----
>  2 files changed, 25 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index 96a76e7..1b9ad80 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -30,23 +30,6 @@ static struct dentry *rmi_debugfs_root;
>   * purpose. For example F11 is a 2D touch sensor while F01 is a generic
>   * function present in every RMI device.
>   */
> -
> -static void rmi_release_device(struct device *dev)
> -{
> -	struct rmi_device *rmi_dev = to_rmi_device(dev);
> -	kfree(rmi_dev);
> -}
> -
> -struct device_type rmi_device_type = {
> -	.name		= "rmi_sensor",
> -	.release	= rmi_release_device,
> -};
> -
> -bool rmi_is_physical_device(struct device *dev)
> -{
> -	return dev->type == &rmi_device_type;
> -}
> -
>  #ifdef CONFIG_RMI4_DEBUG
>  
>  static void rmi_physical_setup_debugfs(struct rmi_device *rmi_dev)
> @@ -94,8 +77,7 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
>  		return -EINVAL;
>  	}
>  
> -	rmi_dev = devm_kzalloc(xport->dev,
> -				sizeof(struct rmi_device), GFP_KERNEL);
> +	rmi_dev = kzalloc(sizeof(struct rmi_device), GFP_KERNEL);
>  	if (!rmi_dev)
>  		return -ENOMEM;
>  
> @@ -112,8 +94,10 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
>  	rmi_physical_setup_debugfs(rmi_dev);
>  
>  	error = device_register(&rmi_dev->dev);
> -	if (error)
> +	if (error) {
> +		put_device(&rmi_dev->dev);
>  		return error;
> +	}
>  
>  	dev_dbg(xport->dev, "%s: Registered %s as %s.\n", __func__,
>  		pdata->sensor_name, dev_name(&rmi_dev->dev));
> @@ -131,7 +115,6 @@ void rmi_unregister_transport_device(struct rmi_transport_dev *xport)
>  {
>  	struct rmi_device *rmi_dev = xport->rmi_dev;
>  
> -	rmi_physical_teardown_debugfs(rmi_dev);
>  	device_unregister(&rmi_dev->dev);
>  }
>  EXPORT_SYMBOL(rmi_unregister_transport_device);
> @@ -139,21 +122,6 @@ EXPORT_SYMBOL(rmi_unregister_transport_device);
>  
>  /* Function specific stuff */
>  
> -static void rmi_release_function(struct device *dev)
> -{
> -	struct rmi_function *fn = to_rmi_function(dev);
> -	kfree(fn);
> -}
> -
> -struct device_type rmi_function_type = {
> -	.name		= "rmi_function",
> -	.release	= rmi_release_function,
> -};
> -
> -bool rmi_is_function_device(struct device *dev)
> -{
> -	return dev->type == &rmi_function_type;
> -}
>  
>  #ifdef CONFIG_RMI4_DEBUG
>  
> @@ -185,6 +153,23 @@ static void rmi_function_teardown_debugfs(struct rmi_function *fn)
>  }
>  
>  #endif
> +static void rmi_release_function(struct device *dev)
> +{
> +	struct rmi_function *fn = to_rmi_function(dev);
> +	rmi_function_teardown_debugfs(fn);

This is wrong, rmi_release_function should finish cleaning up resources,
however unregistration part should happen much earlier. If someone takes
reference to the device in debugfs the device may never go away as noone
will kick the user out.

Please put the calls to rmi_function_teardown_debugfs() back where they
originally were.

> +	kfree(fn->irq_mask);
> +	kfree(fn);
> +}
> +
> +struct device_type rmi_function_type = {
> +	.name		= "rmi_function",
> +	.release	= rmi_release_function,
> +};
> +
> +bool rmi_is_function_device(struct device *dev)
> +{
> +	return dev->type == &rmi_function_type;
> +}
>  
>  static int rmi_function_match(struct device *dev, struct device_driver *drv)
>  {
> @@ -240,21 +225,17 @@ int rmi_register_function(struct rmi_function *fn)
>  		dev_err(&rmi_dev->dev,
>  			"Failed device_register function device %s\n",
>  			dev_name(&fn->dev));
> -		goto error_exit;
> +		put_device(&fn->dev);
> +		return error;
>  	}
>  
>  	dev_dbg(&rmi_dev->dev, "Registered F%02X.\n", fn->fd.function_number);
>  
>  	return 0;
> -
> -error_exit:
> -	rmi_function_teardown_debugfs(fn);
> -	return error;
>  }
>  
>  void rmi_unregister_function(struct rmi_function *fn)
>  {
> -	rmi_function_teardown_debugfs(fn);
>  	device_unregister(&fn->dev);
>  }
>  
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 34f19e9..43575a1 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -674,8 +674,7 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>  	if (!fn->irq_mask) {
>  		dev_err(dev, "%s: Failed to create irq_mask for F%02X.\n",
>  			__func__, pdt->function_number);
> -		error = -ENOMEM;
> -		goto err_free_mem;
> +		return -ENOMEM;
>  	}
>  
>  	for (i = 0; i < fn->num_of_irqs; i++)
> @@ -683,7 +682,7 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>  
>  	error = rmi_register_function(fn);
>  	if (error)
> -		goto err_free_irq_mask;
> +		return error;
>  
>  	if (pdt->function_number == 0x01)
>  		data->f01_container = fn;
> @@ -691,12 +690,6 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>  	list_add_tail(&fn->node, &data->function_list);
>  
>  	return RMI_SCAN_CONTINUE;
> -
> -err_free_irq_mask:
> -	kfree(fn->irq_mask);
> -err_free_mem:
> -	kfree(fn);
> -	return error;

Unless you create rmi_allocate_function() and do device initialization
there (so that device and kobject are fully initialized and proper ktype
is assigned so that ->release() is set up) you still need to free memory
here if failure happens before calling rmi_register_function().

Thanks.

-- 
Dmitry
