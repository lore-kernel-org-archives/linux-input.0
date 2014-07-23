From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 02/02] input synaptics-rmi4: improved interrupt enable
 management
Date: Tue, 22 Jul 2014 23:10:30 -0700
Message-ID: <20140723061030.GF25004@core.coreip.homeip.net>
References: <1393990760-2587-1-git-send-email-cheiny@synaptics.com>
 <1393990760-2587-2-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:57794 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbaGWGKi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 02:10:38 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so983372pdb.41
        for <linux-input@vger.kernel.org>; Tue, 22 Jul 2014 23:10:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1393990760-2587-2-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Tue, Mar 04, 2014 at 07:39:20PM -0800, Christopher Heiny wrote:
> The previous interrupt save/restore routine was inflexible.  Remove
> that and add set_bits() and clear_bits() functions, allowing simpler
> management of individual function interrupt enables.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Linux Walleij <linus.walleij@linaro.org>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> Cc: Jiri Kosina <jkosina@suse.cz>

Applied both, thank you.

> 
> ---
> 
>  drivers/input/rmi4/rmi_bus.h    |  12 ++---
>  drivers/input/rmi4/rmi_driver.c | 104 ++++++++++++++++------------------------
>  drivers/input/rmi4/rmi_driver.h |   3 +-
>  3 files changed, 48 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
> index 1672b05..d4cfc85 100644
> --- a/drivers/input/rmi4/rmi_bus.h
> +++ b/drivers/input/rmi4/rmi_bus.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2011-2013 Synaptics Incorporated
> + * Copyright (c) 2011-2014 Synaptics Incorporated
>   * Copyright (c) 2011 Unixphere
>   *
>   * This program is free software; you can redistribute it and/or modify it
> @@ -111,9 +111,8 @@ void rmi_unregister_function_handler(struct rmi_function_handler *);
>   * @driver: Device driver model driver
>   * @irq_handler: Callback for handling irqs
>   * @reset_handler: Called when a reset is detected.
> - * @get_func_irq_mask: Callback for calculating interrupt mask
> - * @store_irq_mask: Callback for storing and replacing interrupt mask
> - * @restore_irq_mask: Callback for restoring previously stored interrupt mask
> + * @clear_irq_bits: Clear the specified bits in the current interrupt mask.
> + * @set_irq_bist: Set the specified bits in the current interrupt mask.
>   * @store_productid: Callback for cache product id from function 01
>   * @data: Private data pointer
>   *
> @@ -123,9 +122,8 @@ struct rmi_driver {
>  
>  	int (*irq_handler)(struct rmi_device *rmi_dev, int irq);
>  	int (*reset_handler)(struct rmi_device *rmi_dev);
> -	int (*store_irq_mask)(struct rmi_device *rmi_dev,
> -				unsigned long *new_interupts);
> -	int (*restore_irq_mask)(struct rmi_device *rmi_dev);
> +	int (*clear_irq_bits)(struct rmi_device *rmi_dev, unsigned long *mask);
> +	int (*set_irq_bits)(struct rmi_device *rmi_dev, unsigned long *mask);
>  	int (*store_productid)(struct rmi_device *rmi_dev);
>  	int (*set_input_params)(struct rmi_device *rmi_dev,
>  			struct input_dev *input);
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 4406a7f..2172c80 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -330,78 +330,56 @@ static int rmi_driver_set_input_params(struct rmi_device *rmi_dev,
>  	return 0;
>  }
>  
> -/**
> - * This pair of functions allows functions like function 54 to request to have
> - * other interrupts disabled until the restore function is called. Only one
> - * store happens at a time.
> - */
> -static int rmi_driver_irq_save(struct rmi_device *rmi_dev,
> -				unsigned long *new_ints)
> +static int rmi_driver_set_irq_bits(struct rmi_device *rmi_dev,
> +				   unsigned long *mask)
>  {
> -	int retval = 0;
> +	int error = 0;
>  	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
>  	struct device *dev = &rmi_dev->dev;
>  
>  	mutex_lock(&data->irq_mutex);
> -	if (!data->irq_stored) {
> -		/* Save current enabled interrupts */
> -		retval = rmi_read_block(rmi_dev,
> -				data->f01_container->fd.control_base_addr + 1,
> -				data->irq_mask_store, data->num_of_irq_regs);
> -		if (retval < 0) {
> -			dev_err(dev, "%s: Failed to read enabled interrupts!",
> -								__func__);
> -			goto error_unlock;
> -		}
> -		retval = rmi_write_block(rmi_dev,
> -				data->f01_container->fd.control_base_addr + 1,
> -				new_ints, data->num_of_irq_regs);
> -		if (retval < 0) {
> -			dev_err(dev, "%s: Failed to change enabled interrupts!",
> -								__func__);
> -			goto error_unlock;
> -		}
> -		bitmap_copy(data->current_irq_mask, new_ints, data->irq_count);
> -		data->irq_stored = true;
> -	} else {
> -		retval = -ENOSPC; /* No space to store IRQs.*/
> -		dev_err(dev, "Attempted to save IRQs when already stored!");
> +	bitmap_or(data->new_irq_mask,
> +		  data->current_irq_mask, mask, data->irq_count);
> +	error = rmi_write_block(rmi_dev,
> +			data->f01_container->fd.control_base_addr + 1,
> +			data->new_irq_mask, data->num_of_irq_regs);
> +	if (error < 0) {
> +		dev_err(dev, "%s: Failed to change enabled interrupts!",
> +							__func__);
> +		goto error_unlock;
>  	}
> +	bitmap_copy(data->current_irq_mask, data->new_irq_mask,
> +		    data->num_of_irq_regs);
>  
>  error_unlock:
>  	mutex_unlock(&data->irq_mutex);
> -	return retval;
> +	return error;
>  }
>  
> -static int rmi_driver_irq_restore(struct rmi_device *rmi_dev)
> +static int rmi_driver_clear_irq_bits(struct rmi_device *rmi_dev,
> +				     unsigned long *mask)
>  {
> -	int retval = 0;
> +	int error = 0;
>  	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
>  	struct device *dev = &rmi_dev->dev;
>  
>  	mutex_lock(&data->irq_mutex);
> -
> -	if (data->irq_stored) {
> -		retval = rmi_write_block(rmi_dev,
> -				data->f01_container->fd.control_base_addr+1,
> -				data->irq_mask_store, data->num_of_irq_regs);
> -		if (retval < 0) {
> -			dev_err(dev, "%s: Failed to write enabled interupts!",
> -								__func__);
> -			goto error_unlock;
> -		}
> -		memcpy(data->current_irq_mask, data->irq_mask_store,
> -					data->num_of_irq_regs * sizeof(u8));
> -		data->irq_stored = false;
> -	} else {
> -		retval = -EINVAL;
> -		dev_err(dev, "%s: Attempted to restore values when not stored!",
> -			__func__);
> +	bitmap_andnot(data->new_irq_mask,
> +		  data->current_irq_mask, mask, data->irq_count);
> +	error = rmi_write_block(rmi_dev,
> +			data->f01_container->fd.control_base_addr + 1,
> +			data->new_irq_mask, data->num_of_irq_regs);
> +	if (error < 0) {
> +		dev_err(dev, "%s: Failed to change enabled interrupts!",
> +							__func__);
> +		goto error_unlock;
>  	}
> +	bitmap_copy(data->current_irq_mask, data->new_irq_mask,
> +		    data->num_of_irq_regs);
>  
>  error_unlock:
>  	mutex_unlock(&data->irq_mutex);
> -	return retval;
> +	return error;
>  }
>  
>  static int rmi_driver_irq_handler(struct rmi_device *rmi_dev, int irq)
> @@ -437,21 +415,23 @@ static int rmi_driver_reset_handler(struct rmi_device *rmi_dev)
>  		return 0;
>  	}
>  
> +	error = rmi_read_block(rmi_dev,
> +			       data->f01_container->fd.control_base_addr + 1,
> +			       data->current_irq_mask, data->num_of_irq_regs);
> +	if (error < 0) {
> +		dev_err(&rmi_dev->dev, "%s: Failed to read current IRQ mask.\n",
> +			__func__);
> +		return error;
> +	}
> +
>  	error = rmi_driver_process_reset_requests(rmi_dev);
>  	if (error < 0)
>  		return error;
>  
> -
>  	error = rmi_driver_process_config_requests(rmi_dev);
>  	if (error < 0)
>  		return error;
>  
> -	if (data->irq_stored) {
> -		error = rmi_driver_irq_restore(rmi_dev);
> -		if (error < 0)
> -			return error;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -846,7 +826,7 @@ static int rmi_driver_probe(struct device *dev)
>  	data->irq_status	= irq_memory + size * 0;
>  	data->fn_irq_bits	= irq_memory + size * 1;
>  	data->current_irq_mask	= irq_memory + size * 2;
> -	data->irq_mask_store	= irq_memory + size * 3;
> +	data->new_irq_mask	= irq_memory + size * 3;
>  
>  	irq_count = 0;
>  	dev_dbg(dev, "Creating functions.");
> @@ -957,8 +937,8 @@ static struct rmi_driver rmi_physical_driver = {
>  	},
>  	.irq_handler = rmi_driver_irq_handler,
>  	.reset_handler = rmi_driver_reset_handler,
> -	.store_irq_mask = rmi_driver_irq_save,
> -	.restore_irq_mask = rmi_driver_irq_restore,
> +	.clear_irq_bits = rmi_driver_clear_irq_bits,
> +	.set_irq_bits = rmi_driver_set_irq_bits,
>  	.set_input_params = rmi_driver_set_input_params,
>  };
>  
> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> index a22a4e6..34f7a7d 100644
> --- a/drivers/input/rmi4/rmi_driver.h
> +++ b/drivers/input/rmi4/rmi_driver.h
> @@ -47,8 +47,7 @@ struct rmi_driver_data {
>  	unsigned long *irq_status;
>  	unsigned long *fn_irq_bits;
>  	unsigned long *current_irq_mask;
> -	unsigned long *irq_mask_store;
> -	bool irq_stored;
> +	unsigned long *new_irq_mask;
>  	struct mutex irq_mutex;
>  
>  	/* Following are used when polling. */

-- 
Dmitry
