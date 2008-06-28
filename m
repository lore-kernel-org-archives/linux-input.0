From: "Alfred E. Heggestad" <aeh@db.org>
Subject: Re: [patch]reliably killing urbs in yealink driver
Date: Sat, 28 Jun 2008 17:11:17 +0200
Message-ID: <48665495.30204@db.org>
References: <200806261344.32326.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from submit-tmp.sysedata.no ([195.159.29.133]:64609 "EHLO
	submit-tmp.sysedata.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbYF1PLX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Jun 2008 11:11:23 -0400
In-Reply-To: <200806261344.32326.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Henk.Vergonet@gmail.com

Oliver Neukum wrote:
> Hi,
> 
> yealink uses two URBs that submit each other. This arrangement cannot
> be reliably killed with usb_kill_urb() alone, as there's a window during which
> the wrong URB may be killed. The fix is to introduce a flag.
> 

Hi Oliver,

just a small comments about this patch;

- the declaration of 'spin' and 'shutdown' is missing,
   and hence the module does not build.

something like this should be added to struct yealink_dev:

         spinlock_t spin;
         char shutdown:1;


/alfred

> 	Regards
> 		Oliver
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> 
> ---
> 
> --- linux-2.6.26-sierra/drivers/input/misc/yealink.alt.c	2008-06-24 10:17:14.000000000 +0200
> +++ linux-2.6.26-sierra/drivers/input/misc/yealink.c	2008-06-26 13:34:35.000000000 +0200
> @@ -424,10 +424,10 @@ send_update:
>  static void urb_irq_callback(struct urb *urb)
>  {
>  	struct yealink_dev *yld = urb->context;
> -	int ret;
> +	int ret, status = urb->status;
>  
> -	if (urb->status)
> -		err("%s - urb status %d", __FUNCTION__, urb->status);
> +	if (status)
> +		err("%s - urb status %d", __func__, status);
>  
>  	switch (yld->irq_data->cmd) {
>  	case CMD_KEYPRESS:
> @@ -446,34 +446,43 @@ static void urb_irq_callback(struct urb
>  	}
>  
>  	yealink_do_idle_tasks(yld);
> -
> -	ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
> -	if (ret)
> -		err("%s - usb_submit_urb failed %d", __FUNCTION__, ret);
> +	spin_lock(&yld->spin);
> +	if (!yld->shutdown) {
> +		ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
> +		if (ret && ret != -EPERM)
> +			err("%s - usb_submit_urb failed %d", __func__, ret);
> +	}
> +	spin_unlock(&yld->spin);
>  }
>  
>  static void urb_ctl_callback(struct urb *urb)
>  {
>  	struct yealink_dev *yld = urb->context;
> -	int ret;
> +	int ret = 0, status = urb->status;
>  
> -	if (urb->status)
> -		err("%s - urb status %d", __FUNCTION__, urb->status);
> +	if (status)
> +		err("%s - urb status %d", __func__, status);
>  
>  	switch (yld->ctl_data->cmd) {
>  	case CMD_KEYPRESS:
>  	case CMD_SCANCODE:
>  		/* ask for a response */
> -		ret = usb_submit_urb(yld->urb_irq, GFP_ATOMIC);
> +		spin_lock(&yld->spin);
> +		if (!yld->shutdown)
> +			ret = usb_submit_urb(yld->urb_irq, GFP_ATOMIC);
> +		spin_unlock(&yld->spin);
>  		break;
>  	default:
>  		/* send new command */
>  		yealink_do_idle_tasks(yld);
> -		ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
> +		spin_lock(&yld->spin);
> +		if (!yld->shutdown)
> +			ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
> +		spin_unlock(&yld->spin);
>  	}
>  
> -	if (ret)
> -		err("%s - usb_submit_urb failed %d", __FUNCTION__, ret);
> +	if (ret && ret != -EPERM)
> +		err("%s - usb_submit_urb failed %d", __func__, ret);
>  }
>  
>  /*******************************************************************************
> @@ -527,12 +536,25 @@ static int input_open(struct input_dev *
>  	return 0;
>  }
>  
> -static void input_close(struct input_dev *dev)
> +static void stop_traffic(struct yealink_dev *yld)
>  {
> -	struct yealink_dev *yld = input_get_drvdata(dev);
> +	spin_lock_irq(&yld->spin);
> +	yld->shutdown = 1;
> +	spin_unlock_irq(&yld->spin);
>  
>  	usb_kill_urb(yld->urb_ctl);
>  	usb_kill_urb(yld->urb_irq);
> +
> +	spin_lock_irq(&yld->spin);
> +	yld->shutdown = 0;
> +	spin_unlock_irq(&yld->spin);
> +}
> +
> +static void input_close(struct input_dev *dev)
> +{
> +	struct yealink_dev *yld = input_get_drvdata(dev);
> +
> +	stop_traffic(yld);
>  }
>  
>  /*******************************************************************************
> @@ -809,8 +831,7 @@ static int usb_cleanup(struct yealink_de
>  	if (yld == NULL)
>  		return err;
>  
> -	usb_kill_urb(yld->urb_irq);	/* parameter validation in core/urb */
> -	usb_kill_urb(yld->urb_ctl);	/* parameter validation in core/urb */
> +	stop_traffic(yld);
>  
>          if (yld->idev) {
>  		if (err)
> @@ -866,6 +887,7 @@ static int usb_probe(struct usb_interfac
>  		return -ENOMEM;
>  
>  	yld->udev = udev;
> +	spin_lock_init(&yld->spin);
>  
>  	yld->idev = input_dev = input_allocate_device();
>  	if (!input_dev)
> 

