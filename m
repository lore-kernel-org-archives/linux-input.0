From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] usbhid:implement runtime pm with the modern AP
Date: Wed, 22 Dec 2010 19:07:53 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012221907440.16569@pobox.suse.cz>
References: <201012221533.40490.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50438 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069Ab0LVSHz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Dec 2010 13:07:55 -0500
In-Reply-To: <201012221533.40490.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Maulik Mankad <x0082077@ti.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, 22 Dec 2010, Oliver Neukum wrote:

> This patch doesn't alter functionality, but removes a dedicated kernel
> thread.

Makes sense. Applied, thank you.

> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> Tested-by: Maulik Mankad <x0082077@ti.com>
> ---
>  drivers/hid/usbhid/hid-core.c |   57 +++++++++++++---------------------------
>  drivers/hid/usbhid/usbhid.h   |    1 -
>  2 files changed, 19 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 5489eab..0d632e0 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -67,7 +67,6 @@ MODULE_PARM_DESC(quirks, "Add/modify USB HID quirks by specifying "
>   * Input submission and I/O error handler.
>   */
>  static DEFINE_MUTEX(hid_open_mut);
> -static struct workqueue_struct *resumption_waker;
>  
>  static void hid_io_error(struct hid_device *hid);
>  static int hid_submit_out(struct hid_device *hid);
> @@ -300,10 +299,19 @@ static int hid_submit_out(struct hid_device *hid)
>  	struct hid_report *report;
>  	char *raw_report;
>  	struct usbhid_device *usbhid = hid->driver_data;
> +	int r;
>  
>  	report = usbhid->out[usbhid->outtail].report;
>  	raw_report = usbhid->out[usbhid->outtail].raw_report;
>  
> +	r = usb_autopm_get_interface_async(usbhid->intf);
> +	if (r < 0)
> +		return -1;
> +
> +	/*
> +	 * if the device hasn't been woken, we leave the output
> +	 * to resume()
> +	 */
>  	if (!test_bit(HID_REPORTED_IDLE, &usbhid->iofl)) {
>  		usbhid->urbout->transfer_buffer_length = ((report->size - 1) >> 3) + 1 + (report->id > 0);
>  		usbhid->urbout->dev = hid_to_usb_dev(hid);
> @@ -314,16 +322,10 @@ static int hid_submit_out(struct hid_device *hid)
>  
>  		if (usb_submit_urb(usbhid->urbout, GFP_ATOMIC)) {
>  			err_hid("usb_submit_urb(out) failed");
> +			usb_autopm_put_interface_async(usbhid->intf);
>  			return -1;
>  		}
>  		usbhid->last_out = jiffies;
> -	} else {
> -		/*
> -		 * queue work to wake up the device.
> -		 * as the work queue is freezeable, this is safe
> -		 * with respect to STD and STR
> -		 */
> -		queue_work(resumption_waker, &usbhid->restart_work);
>  	}
>  
>  	return 0;
> @@ -334,13 +336,16 @@ static int hid_submit_ctrl(struct hid_device *hid)
>  	struct hid_report *report;
>  	unsigned char dir;
>  	char *raw_report;
> -	int len;
> +	int len, r;
>  	struct usbhid_device *usbhid = hid->driver_data;
>  
>  	report = usbhid->ctrl[usbhid->ctrltail].report;
>  	raw_report = usbhid->ctrl[usbhid->ctrltail].raw_report;
>  	dir = usbhid->ctrl[usbhid->ctrltail].dir;
>  
> +	r = usb_autopm_get_interface_async(usbhid->intf);
> +	if (r < 0)
> +		return -1;
>  	if (!test_bit(HID_REPORTED_IDLE, &usbhid->iofl)) {
>  		len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
>  		if (dir == USB_DIR_OUT) {
> @@ -375,17 +380,11 @@ static int hid_submit_ctrl(struct hid_device *hid)
>  			usbhid->cr->wValue, usbhid->cr->wIndex, usbhid->cr->wLength);
>  
>  		if (usb_submit_urb(usbhid->urbctrl, GFP_ATOMIC)) {
> +			usb_autopm_put_interface_async(usbhid->intf);
>  			err_hid("usb_submit_urb(ctrl) failed");
>  			return -1;
>  		}
>  		usbhid->last_ctrl = jiffies;
> -	} else {
> -		/*
> -		 * queue work to wake up the device.
> -		 * as the work queue is freezeable, this is safe
> -		 * with respect to STD and STR
> -		 */
> -		queue_work(resumption_waker, &usbhid->restart_work);
>  	}
>  
>  	return 0;
> @@ -435,6 +434,7 @@ static void hid_irq_out(struct urb *urb)
>  
>  	clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
>  	spin_unlock_irqrestore(&usbhid->lock, flags);
> +	usb_autopm_put_interface_async(usbhid->intf);
>  	wake_up(&usbhid->wait);
>  }
>  
> @@ -481,11 +481,13 @@ static void hid_ctrl(struct urb *urb)
>  			wake_up(&usbhid->wait);
>  		}
>  		spin_unlock(&usbhid->lock);
> +		usb_autopm_put_interface_async(usbhid->intf);
>  		return;
>  	}
>  
>  	clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
>  	spin_unlock(&usbhid->lock);
> +	usb_autopm_put_interface_async(usbhid->intf);
>  	wake_up(&usbhid->wait);
>  }
>  
> @@ -656,7 +658,7 @@ int usbhid_open(struct hid_device *hid)
>  	mutex_lock(&hid_open_mut);
>  	if (!hid->open++) {
>  		res = usb_autopm_get_interface(usbhid->intf);
> -		/* the device must be awake to reliable request remote wakeup */
> +		/* the device must be awake to reliably request remote wakeup */
>  		if (res < 0) {
>  			hid->open--;
>  			mutex_unlock(&hid_open_mut);
> @@ -857,18 +859,6 @@ static void usbhid_restart_queues(struct usbhid_device *usbhid)
>  	usbhid_restart_ctrl_queue(usbhid);
>  }
>  
> -static void __usbhid_restart_queues(struct work_struct *work)
> -{
> -	struct usbhid_device *usbhid =
> -		container_of(work, struct usbhid_device, restart_work);
> -	int r;
> -
> -	r = usb_autopm_get_interface(usbhid->intf);
> -	if (r < 0)
> -		return;
> -	usb_autopm_put_interface(usbhid->intf);
> -}
> -
>  static void hid_free_buffers(struct usb_device *dev, struct hid_device *hid)
>  {
>  	struct usbhid_device *usbhid = hid->driver_data;
> @@ -1206,7 +1196,6 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
>  
>  	init_waitqueue_head(&usbhid->wait);
>  	INIT_WORK(&usbhid->reset_work, hid_reset);
> -	INIT_WORK(&usbhid->restart_work, __usbhid_restart_queues);
>  	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
>  	spin_lock_init(&usbhid->lock);
>  
> @@ -1241,7 +1230,6 @@ static void usbhid_disconnect(struct usb_interface *intf)
>  static void hid_cancel_delayed_stuff(struct usbhid_device *usbhid)
>  {
>  	del_timer_sync(&usbhid->io_retry);
> -	cancel_work_sync(&usbhid->restart_work);
>  	cancel_work_sync(&usbhid->reset_work);
>  }
>  
> @@ -1262,7 +1250,6 @@ static int hid_pre_reset(struct usb_interface *intf)
>  	spin_lock_irq(&usbhid->lock);
>  	set_bit(HID_RESET_PENDING, &usbhid->iofl);
>  	spin_unlock_irq(&usbhid->lock);
> -	cancel_work_sync(&usbhid->restart_work);
>  	hid_cease_io(usbhid);
>  
>  	return 0;
> @@ -1461,9 +1448,6 @@ static int __init hid_init(void)
>  {
>  	int retval = -ENOMEM;
>  
> -	resumption_waker = create_freezeable_workqueue("usbhid_resumer");
> -	if (!resumption_waker)
> -		goto no_queue;
>  	retval = hid_register_driver(&hid_usb_driver);
>  	if (retval)
>  		goto hid_register_fail;
> @@ -1481,8 +1465,6 @@ usb_register_fail:
>  usbhid_quirks_init_fail:
>  	hid_unregister_driver(&hid_usb_driver);
>  hid_register_fail:
> -	destroy_workqueue(resumption_waker);
> -no_queue:
>  	return retval;
>  }
>  
> @@ -1491,7 +1473,6 @@ static void __exit hid_exit(void)
>  	usb_deregister(&hid_driver);
>  	usbhid_quirks_exit();
>  	hid_unregister_driver(&hid_usb_driver);
> -	destroy_workqueue(resumption_waker);
>  }
>  
>  module_init(hid_init);
> diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
> index 89d2e84..1673cac 100644
> --- a/drivers/hid/usbhid/usbhid.h
> +++ b/drivers/hid/usbhid/usbhid.h
> @@ -95,7 +95,6 @@ struct usbhid_device {
>  	unsigned long stop_retry;                                       /* Time to give up, in jiffies */
>  	unsigned int retry_delay;                                       /* Delay length in ms */
>  	struct work_struct reset_work;                                  /* Task context for resets */
> -	struct work_struct restart_work;				/* waking up for output to be done in a task */
>  	wait_queue_head_t wait;						/* For sleeping */
>  	int ledcount;							/* counting the number of active leds */
>  };
> -- 
> 1.7.1
> 

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
