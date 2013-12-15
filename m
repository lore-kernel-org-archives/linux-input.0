From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4: Debugfs initialization fixes
Date: Sun, 15 Dec 2013 03:56:50 -0800
Message-ID: <20131215115650.GC14818@core.coreip.homeip.net>
References: <1386727924-11522-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:45386 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab3LOL45 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Dec 2013 06:56:57 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so4235064pdj.39
        for <linux-input@vger.kernel.org>; Sun, 15 Dec 2013 03:56:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386727924-11522-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Tue, Dec 10, 2013 at 06:12:04PM -0800, Christopher Heiny wrote:
> This fixes the broken #ifdefs on CONFIG_RMI4_DEBUG.  Per device debugfs
> setup is reordered to ensure that the debugfs tree for a given device is
> created before it is registered (since the action of registering a device
> may cause other things to happen that depend on debugfs being initialized
> already).
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Joerie de Gram <j.de.gram@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 

Applied, thank you.

> ---
> 
> This patch implements changes to the synaptics-rmi4 branch of
> Dmitry's input tree.  The base for the patch is commit
> f154022b208a59b048f52b7b5d58a5ec1949b96e.
> 
>  drivers/input/rmi4/rmi_bus.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index cb14cf6..173f6be 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -47,7 +47,7 @@ bool rmi_is_physical_device(struct device *dev)
>  	return dev->type == &rmi_device_type;
>  }
>  
> -#if CONFIG_RMI4_DEBUG
> +#ifdef CONFIG_RMI4_DEBUG
>  
>  static void rmi_physical_setup_debugfs(struct rmi_device *rmi_dev)
>  {
> @@ -109,12 +109,12 @@ int rmi_register_physical_device(struct rmi_phys_device *phys)
>  
>  	phys->rmi_dev = rmi_dev;
>  
> +	rmi_physical_setup_debugfs(rmi_dev);
> +
>  	error = device_register(&rmi_dev->dev);
>  	if (error)
>  		return error;
>  
> -	rmi_physical_setup_debugfs(rmi_dev);
> -
>  	dev_dbg(phys->dev, "%s: Registered %s as %s.\n", __func__,
>  		pdata->sensor_name, dev_name(&rmi_dev->dev));
>  
> @@ -155,7 +155,7 @@ bool rmi_is_function_device(struct device *dev)
>  	return dev->type == &rmi_function_type;
>  }
>  
> -#if CONFIG_RMI4_DEBUG
> +#ifdef CONFIG_RMI4_DEBUG
>  
>  static void rmi_function_setup_debugfs(struct rmi_function *fn)
>  {
> @@ -233,18 +233,23 @@ int rmi_register_function(struct rmi_function *fn)
>  	fn->dev.type = &rmi_function_type;
>  	fn->dev.bus = &rmi_bus_type;
>  
> +	rmi_function_setup_debugfs(fn);
> +
>  	error = device_register(&fn->dev);
>  	if (error) {
>  		dev_err(&rmi_dev->dev,
>  			"Failed device_register function device %s\n",
>  			dev_name(&fn->dev));
> -		return error;
> +		goto error_exit;
>  	}
>  
>  	dev_dbg(&rmi_dev->dev, "Registered F%02X.\n", fn->fd.function_number);
>  
> -	rmi_function_setup_debugfs(fn);
>  	return 0;
> +
> +error_exit:
> +	rmi_function_teardown_debugfs(fn);
> +	return error;
>  }
>  
>  void rmi_unregister_function(struct rmi_function *fn)
> @@ -357,6 +362,8 @@ static int __init rmi_bus_init(void)
>  		return error;
>  	}
>  
> +	rmi_bus_setup_debugfs();
> +
>  	error = rmi_register_f01_handler();
>  	if (error) {
>  		pr_err("%s: error registering the RMI F01 handler: %d\n",
> @@ -371,13 +378,12 @@ static int __init rmi_bus_init(void)
>  		goto err_unregister_f01;
>  	}
>  
> -	rmi_bus_setup_debugfs();
> -
>  	return 0;
>  
>  err_unregister_f01:
>  	rmi_unregister_f01_handler();
>  err_unregister_bus:
> +	rmi_bus_teardown_debugfs();
>  	bus_unregister(&rmi_bus_type);
>  	return error;
>  }
> @@ -390,9 +396,9 @@ static void __exit rmi_bus_exit(void)
>  	 * all we have to do at this point is unregister ourselves.
>  	 */
>  
> -	rmi_bus_teardown_debugfs();
>  	rmi_unregister_physical_driver();
>  	rmi_unregister_f01_handler();
> +	rmi_bus_teardown_debugfs();
>  	bus_unregister(&rmi_bus_type);
>  }
>  module_exit(rmi_bus_exit);

-- 
Dmitry
