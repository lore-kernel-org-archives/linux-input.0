From: "Henrik Rydberg" <rydberg@bitmath.se>
Subject: Re: [PATCH] input: Fix autosuspend on bcm5974
Date: Tue, 13 Mar 2012 15:39:58 +0100
Message-ID: <20120313143958.GA2754@polaris.bitmath.org>
References: <1331596278-2495-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp3.one.com ([91.198.169.23]:8246 "EHLO csmtp3.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516Ab2CMOiJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 10:38:09 -0400
Content-Disposition: inline
In-Reply-To: <1331596278-2495-1-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Hi Matthew,

> The bcm5974 code takes a USB autosuspend reference on device open and
> releases it on device close. This means that the hardware won't sleep
> when anything holds it open. This is sensible for input devices that
> don't support remote wakeups on normal use (like most mice), but this
> hardware trigger wakeups on touch and so can suspend transparently to
> the user. Doing so allows the USB host controller to sleep when the
> machine is idle, giving measurable power savings. The downside is a small
> amount of additional latency when the device wakes up, and as a result
> this functionality isn't enabled by default.

With the previous version of this patch, the machine would not wake up
on a normal tap. Is that what you refer to with the "small amount of
additional latency"? By not enabled by default, you mean in the usb
subsystem?

Last time I checked, it seemed the first keystroke would sometimes
disappear at boot. As far as I can see, this version modifies the
needs_remote_wakeup variable to only be true while open, which might
remove that particular problem.

Still, I am concerned with the user experience. On this machine
(MBA31), turning on autopm with this patch included feels like a
regression.

> 
> [rydberg@euromail.se: wakeup before mode switch]
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  drivers/input/mouse/bcm5974.c |   30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index 927e479..aaf158c 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -634,6 +634,7 @@ static void bcm5974_irq_button(struct urb *urb)
>  
>  	switch (urb->status) {
>  	case 0:
> +		usb_mark_last_busy(dev->udev);
>  		break;
>  	case -EOVERFLOW:
>  	case -ECONNRESET:
> @@ -663,6 +664,7 @@ static void bcm5974_irq_trackpad(struct urb *urb)
>  
>  	switch (urb->status) {
>  	case 0:
> +		usb_mark_last_busy(dev->udev);
>  		break;
>  	case -EOVERFLOW:
>  	case -ECONNRESET:
> @@ -735,10 +737,15 @@ err_out:
>  	return error;
>  }
>  
> -static void bcm5974_pause_traffic(struct bcm5974 *dev)
> +static void bcm5974_kill_urbs(struct bcm5974 *dev)
>  {
>  	usb_kill_urb(dev->tp_urb);
>  	usb_kill_urb(dev->bt_urb);
> +}
> +
> +static void bcm5974_pause_traffic(struct bcm5974 *dev)
> +{
> +	bcm5974_kill_urbs(dev);
>  	bcm5974_wellspring_mode(dev, false);
>  }
>  
> @@ -759,6 +766,9 @@ static int bcm5974_open(struct input_dev *input)
>  	if (error)
>  		return error;
>  
> +	/* Required for autosuspend */
> +	dev->intf->needs_remote_wakeup = 1;
> +
>  	mutex_lock(&dev->pm_mutex);
>  
>  	error = bcm5974_start_traffic(dev);
> @@ -767,8 +777,10 @@ static int bcm5974_open(struct input_dev *input)
>  
>  	mutex_unlock(&dev->pm_mutex);
>  
> +	usb_autopm_put_interface(dev->intf);
> +
>  	if (error)
> -		usb_autopm_put_interface(dev->intf);
> +		dev->intf->needs_remote_wakeup = 0;
>  
>  	return error;
>  }
> @@ -776,15 +788,25 @@ static int bcm5974_open(struct input_dev *input)
>  static void bcm5974_close(struct input_dev *input)
>  {
>  	struct bcm5974 *dev = input_get_drvdata(input);
> +	int error;
> +
> +	dev->intf->needs_remote_wakeup = 0;
> +
> +	error = usb_autopm_get_interface(dev->intf);
>  
>  	mutex_lock(&dev->pm_mutex);
>  
> -	bcm5974_pause_traffic(dev);
> +	bcm5974_kill_urbs(dev);
>  	dev->opened = 0;
> +	if (error)
> +		err("bcm5974: wakeup failed during close: %d\n", error);
> +	else
> +		bcm5974_wellspring_mode(dev, false);
>  
>  	mutex_unlock(&dev->pm_mutex);
>  
> -	usb_autopm_put_interface(dev->intf);
> +	if (!error)
> +		usb_autopm_put_interface(dev->intf);
>  }
>  
>  static int bcm5974_suspend(struct usb_interface *iface, pm_message_t message)
> -- 
> 1.7.9.3
> 

Thanks,
Henrik
