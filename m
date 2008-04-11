From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch]suspend and autosuspend for wacom devices
Date: Fri, 11 Apr 2008 09:47:25 -0400
Message-ID: <20080411094018.ZZRA012@mailhub.coreip.homeip.net>
References: <200804111520.57418.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200804111520.57418.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Ping Cheng <pingc-JeGq9vS6aD4AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Oliver,

On Fri, Apr 11, 2008 at 03:20:56PM +0200, Oliver Neukum wrote:
> This implements suspend and autosuspend support for wacom devices.
> It works by using the usb last busy functionality triggered in the completion
> callback.
> 
> Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
> 

Please also add Ping Cheng to the list when changing wacom driver. She is in
much better position to test any changes to the driver than any of us ;)

> ---
> 
> --- linux-2.6.25-rc7-vanilla/drivers/input/tablet/wacom_sys.c	2008-03-31 15:20:58.000000000 +0200
> +++ linux-2.6.25-rc7-work/drivers/input/tablet/wacom_sys.c	2008-04-11 15:04:18.000000000 +0200
> @@ -70,6 +70,7 @@ static void wacom_sys_irq(struct urb *ur
>  		input_sync(get_input_dev(&wcombo));
>  
>   exit:
> +	usb_mark_last_busy(wacom->usbdev);
>  	retval = usb_submit_urb (urb, GFP_ATOMIC);
>  	if (retval)
>  		err ("%s - usb_submit_urb failed with result %d",
> @@ -124,10 +125,22 @@ static int wacom_open(struct input_dev *
>  {
>  	struct wacom *wacom = input_get_drvdata(dev);
>  
> +	mutex_lock(&wacom->lock);
>  	wacom->irq->dev = wacom->usbdev;
> -	if (usb_submit_urb(wacom->irq, GFP_KERNEL))
> +
> +	if (usb_autopm_get_interface(wacom->intf) < 0) {
> +		mutex_unlock(&wacom->lock);
> +		return -EIO;
> +	}
> +	if (usb_submit_urb(wacom->irq, GFP_KERNEL)) {
> +		usb_autopm_put_interface(wacom->intf);
> +		mutex_unlock(&wacom->lock);
>  		return -EIO;
> +	}
> +	wacom->open = 1;
> +	wacom->intf->needs_remote_wakeup = 1;
>  
> +	mutex_unlock(&wacom->lock);
>  	return 0;
>  }
>  
> @@ -135,7 +148,11 @@ static void wacom_close(struct input_dev
>  {
>  	struct wacom *wacom = input_get_drvdata(dev);
>  
> +	mutex_lock(&wacom->lock);
>  	usb_kill_urb(wacom->irq);
> +	wacom->open = 0;
> +	wacom->intf->needs_remote_wakeup = 0;
> +	mutex_unlock(&wacom->lock);
>  }
>  
>  void input_dev_mo(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
> @@ -243,6 +260,8 @@ static int wacom_probe(struct usb_interf
>  
>  	wacom->usbdev = dev;
>  	wacom->dev = input_dev;
> +	wacom->intf = intf;
> +	mutex_init(&wacom->lock);
>  	usb_make_path(dev, wacom->phys, sizeof(wacom->phys));
>  	strlcat(wacom->phys, "/input0", sizeof(wacom->phys));
>  
> @@ -307,20 +326,54 @@ static void wacom_disconnect(struct usb_
>  	struct wacom *wacom = usb_get_intfdata (intf);
>  
>  	usb_set_intfdata(intf, NULL);
> -	if (wacom) {
> -		usb_kill_urb(wacom->irq);
> -		input_unregister_device(wacom->dev);
> -		usb_free_urb(wacom->irq);
> -		usb_buffer_free(interface_to_usbdev(intf), 10, wacom->wacom_wac->data, wacom->data_dma);
> -		kfree(wacom->wacom_wac);
> -		kfree(wacom);
> -	}
> +
> +	usb_kill_urb(wacom->irq);
> +	input_unregister_device(wacom->dev);
> +	usb_free_urb(wacom->irq);
> +	usb_buffer_free(interface_to_usbdev(intf), 10, wacom->wacom_wac->data, wacom->data_dma);
> +	kfree(wacom->wacom_wac);
> +	kfree(wacom);
> +}
> +
> +static int wacom_suspend(struct usb_interface *intf, pm_message_t message)
> +{
> +	struct wacom *wacom = usb_get_intfdata (intf);
> +
> +	mutex_lock(&wacom->lock);
> +	usb_kill_urb(wacom->irq);
> +	mutex_unlock(&wacom->lock);
> +
> +	return 0;
> +}
> +
> +static int wacom_resume(struct usb_interface *intf)
> +{
> +	struct wacom *wacom = usb_get_intfdata (intf);
> +	int rv;
> +
> +	mutex_lock(&wacom->lock);
> +	if (wacom->open)
> +		rv = usb_submit_urb(wacom->irq, GFP_NOIO);
> +	else
> +		rv = 0;
> +	mutex_unlock(&wacom->lock);
> +
> +	return rv;
> +}
> +
> +static int wacom_reset_resume(struct usb_interface *intf)
> +{
> +	return wacom_resume(intf);
>  }
>  
>  static struct usb_driver wacom_driver = {
>  	.name =		"wacom",
>  	.probe =	wacom_probe,
>  	.disconnect =	wacom_disconnect,
> +	.suspend =	wacom_suspend,
> +	.resume =	wacom_resume,
> +	.reset_resume =	wacom_reset_resume,
> +	.supports_autosuspend = 1,
>  };
>  
>  static int __init wacom_init(void)
> --- linux-2.6.25-rc7-vanilla/drivers/input/tablet/wacom.h	2008-03-31 15:20:58.000000000 +0200
> +++ linux-2.6.25-rc7-work/drivers/input/tablet/wacom.h	2008-04-11 13:19:50.000000000 +0200
> @@ -101,8 +101,11 @@ struct wacom {
>  	dma_addr_t data_dma;
>  	struct input_dev *dev;
>  	struct usb_device *usbdev;
> +	struct usb_interface *intf;
>  	struct urb *irq;
>  	struct wacom_wac * wacom_wac;
> +	struct mutex lock;
> +	int open:1;
>  	char phys[32];
>  };
>  

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
