From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4: Delete some obsolete code
Date: Fri, 27 Dec 2013 18:24:14 -0800
Message-ID: <20131228022414.GD14188@core.coreip.homeip.net>
References: <1388195887-26503-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:41470 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853Ab3L1CYS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Dec 2013 21:24:18 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so9719498pbc.25
        for <linux-input@vger.kernel.org>; Fri, 27 Dec 2013 18:24:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1388195887-26503-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Fri, Dec 27, 2013 at 05:58:07PM -0800, Christopher Heiny wrote:
> The answer to the question "is this crap needed with F01 always present?" is
> "no, it's not".  Also delete obsolete [suspend|resume]_one_device.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> ---
> 
>  drivers/input/rmi4/rmi_driver.c | 48 -----------------------------------------
>  1 file changed, 48 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 2ae9af9..a4e5236 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -686,39 +686,6 @@ error_exit:
>  	return retval;
>  }
>  
> -#if 0
> -// XXX is this crap needed with F01 always present?
> -static int f01_notifier_call(struct notifier_block *nb,
> -				unsigned long action, void *data)
> -{
> -	struct device *dev = data;
> -	struct rmi_function *fn;
> -
> -	if (!rmi_is_function_device(dev))
> -		return 0;
> -
> -	fn = to_rmi_function(dev);
> -	if (fn->fd.function_number != 0x01)
> -		return 0;
> -
> -	switch (action) {
> -	case BUS_NOTIFY_BOUND_DRIVER:
> -		dev_dbg(dev, "%s: F01 driver bound.\n", __func__);
> -		enable_sensor(fn->rmi_dev);
> -		break;
> -	case BUS_NOTIFY_UNBIND_DRIVER:
> -		dev_dbg(dev, "%s: F01 driver going away.\n", __func__);
> -		disable_sensor(fn->rmi_dev);
> -		break;
> -	}
> -	return 0;
> -}
> -
> -static struct notifier_block rmi_bus_notifier = {
> -	.notifier_call = f01_notifier_call,
> -};
> -#endif
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int rmi_driver_suspend(struct device *dev)
>  {
> @@ -738,13 +705,6 @@ static int rmi_driver_suspend(struct device *dev)
>  
>  	disable_sensor(rmi_dev);
>  
> -#if 0
> -	/** Do it backwards so F01 comes last. */
> -	list_for_each_entry_reverse(entry, &data->function_list, node)
> -		if (suspend_one_device(entry) < 0)
> -			goto exit;
> -#endif
> -
>  	if (data->post_suspend)
>  		retval = data->post_suspend(data->pm_data);
>  
> @@ -768,14 +728,6 @@ static int rmi_driver_resume(struct device *dev)
>  			goto exit;
>  	}
>  
> -#if 0
> -	/** Do it forwards, so F01 comes first. */
> -	list_for_each_entry(entry, &data->function_list, node) {
> -		if (resume_one_device(entry) < 0)
> -			goto exit;
> -	}
> -#endif
> -
>  	retval = enable_sensor(rmi_dev);
>  	if (retval)
>  		goto exit;

-- 
Dmitry
