From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH] input synaptics-rmi4: Use put_device() and
 device_type.release() to free storage.
Date: Thu, 13 Feb 2014 13:59:31 -0800
Message-ID: <20140213215930.GH1706@sonymobile.com>
References: <1392160410-8293-1-git-send-email-cheiny@synaptics.com>
 <20140212064925.GC15855@core.coreip.homeip.net>
 <52FC2E68.1060709@synaptics.com>
 <20140213061524.GA15260@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:5536 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750932AbaBMV5q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 16:57:46 -0500
Content-Disposition: inline
In-Reply-To: <20140213061524.GA15260@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christopher Heiny <cheiny@synaptics.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Thu, Feb 13, 2014 at 07:15:24AM +0100, Dmitry Torokhov wrote:
> On Wed, Feb 12, 2014 at 06:31:04PM -0800, Christopher Heiny wrote:
> > Input: synaptics-rmi4 - Use put_device() and device_type.release()
> > to free storage.
> > 
> > From: Christopher Heiny <cheiny@synaptics.com>
> > 
> > For rmi_sensor and rmi_function device_types, use put_device() and
> > the assocated device_type.release() function to clean up related
> > structures and storage in the correct and safe order.
> > 
> > Allocate irq_mask as part of struct rmi_function.
> > 
> > Delete unused rmi_driver_irq_get_mask() function.
[...]
> Input: synaptics-rmi4 - use put_device() to free devices
> 
> From: Christopher Heiny <cheiny@synaptics.com>
> 
> For rmi_sensor and rmi_function device_types, use put_device() and
> the associated device_type->release() function to clean up related
> structures and storage in the correct and safe order.
> 
> Allocate irq_mask as part of struct rmi_function.
> 
> Suggested-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/rmi4/rmi_bus.c    |   30 +++++++++++++++++++++---------
>  drivers/input/rmi4/rmi_bus.h    |    7 ++++---
>  drivers/input/rmi4/rmi_driver.c |   25 +++++++------------------
>  3 files changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
[...]  
> @@ -142,6 +150,7 @@ EXPORT_SYMBOL(rmi_unregister_transport_device);
>  static void rmi_release_function(struct device *dev)
>  {
>  	struct rmi_function *fn = to_rmi_function(dev);
> +
>  	kfree(fn);
>  }

Ownership of this memory is a bit weird...

[...]
>  void rmi_unregister_function(struct rmi_function *fn)
>  {
> +	device_del(&fn->dev);
>  	rmi_function_teardown_debugfs(fn);
> -	device_unregister(&fn->dev);
> +	put_device(&fn->dev);
>  }

Here clearly the bus code owns it...

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
[...]  
>  static int rmi_create_function(struct rmi_device *rmi_dev,
> -			      void *ctx, const struct pdt_entry *pdt)
> +			       void *ctx, const struct pdt_entry *pdt)
>  {
>  	struct device *dev = &rmi_dev->dev;
>  	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> @@ -630,7 +629,9 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>  	dev_dbg(dev, "Initializing F%02X for %s.\n",
>  		pdt->function_number, pdata->sensor_name);
>  
> -	fn = kzalloc(sizeof(struct rmi_function), GFP_KERNEL);
> +	fn = kzalloc(sizeof(struct rmi_function) +
> +			BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
> +		     GFP_KERNEL);

But it's allocated in the chip driver...

>  	if (!fn) {
>  		dev_err(dev, "Failed to allocate memory for F%02X\n",
>  			pdt->function_number);
> @@ -646,22 +647,12 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>  	fn->irq_pos = *current_irq_count;
>  	*current_irq_count += fn->num_of_irqs;
>  
> -	fn->irq_mask = kzalloc(
> -		BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
> -		GFP_KERNEL);
> -	if (!fn->irq_mask) {
> -		dev_err(dev, "%s: Failed to create irq_mask for F%02X.\n",
> -			__func__, pdt->function_number);
> -		error = -ENOMEM;
> -		goto err_free_mem;
> -	}
> -
>  	for (i = 0; i < fn->num_of_irqs; i++)
>  		set_bit(fn->irq_pos + i, fn->irq_mask);
>  
>  	error = rmi_register_function(fn);
>  	if (error)
> -		goto err_free_irq_mask;
> +		goto err_put_fn;
>  
>  	if (pdt->function_number == 0x01)
>  		data->f01_container = fn;
> @@ -670,10 +661,8 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>  
>  	return RMI_SCAN_CONTINUE;
>  
> -err_free_irq_mask:
> -	kfree(fn->irq_mask);
> -err_free_mem:
> -	kfree(fn);
> +err_put_fn:
> +	put_device(&fn->dev);

And the chip driver now is expected to know it's a device, and trust
that the bus code knows how to free the memory.

>  	return error;
>  }
>  

As this clearly fixes a bug or two, I say we should take this patch
as-is and worry about proper ownership at some other time.

-Courtney
