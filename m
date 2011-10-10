From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] usb: Keep track of actual LED state
Date: Mon, 10 Oct 2011 19:13:14 +0200
Message-ID: <20111010171314.GA2089@polaris.bitmath.org>
References: <1318262100-24166-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:43529 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab1JJRGh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 13:06:37 -0400
Content-Disposition: inline
In-Reply-To: <1318262100-24166-1-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, oneukum@suse.de

Hi Matthew,

> The usbhid autosuspend code refuses to suspend if there are any LEDs lit,
> in order to avoid situations where this would draw more power than
> available when suspended. The current implementation is a counter that's
> incremented on LED on and decremented on LED off. However, if a system
> suspend takes place, the input core will resynchronise state on resume by
> sending LED on and off requests. This may cause the counter to underflow,
> resulting in autosuspend being disabled for the rest of system uptime.
> This patch simply replaces the counter with a bitmask of the actual LED
> state in order to avoid this.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/hid/usbhid/hid-core.c |    6 +++---
>  drivers/hid/usbhid/usbhid.h   |    2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index ad978f5..fd96d38 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -598,11 +598,11 @@ static int usb_hidinput_input_event(struct input_dev *dev, unsigned int type, un
>  	hid_set_field(field, offset, value);
>  	if (value) {
>  		spin_lock_irqsave(&usbhid->lock, flags);
> -		usbhid->ledcount++;
> +		usbhid->ledstate |= (1 << code);

To be consistent, ledstate should be a bitmask the same size as in
input_dev, but it aint pretty...

>  		spin_unlock_irqrestore(&usbhid->lock, flags);
>  	} else {
>  		spin_lock_irqsave(&usbhid->lock, flags);
> -		usbhid->ledcount--;
> +		usbhid->ledstate &= ~(1 << code);

Could simply check for ledcount > 0 here instead, but it is even uglier.

>  		spin_unlock_irqrestore(&usbhid->lock, flags);
>  	}
>  	usbhid_submit_report(hid, field->report, USB_DIR_OUT);
> @@ -1339,7 +1339,7 @@ static int hid_suspend(struct usb_interface *intf, pm_message_t message)
>  		    && !test_bit(HID_OUT_RUNNING, &usbhid->iofl)
>  		    && !test_bit(HID_CTRL_RUNNING, &usbhid->iofl)
>  		    && !test_bit(HID_KEYS_PRESSED, &usbhid->iofl)
> -		    && (!usbhid->ledcount || ignoreled))
> +		    && (!usbhid->ledstate || ignoreled))

Why not test the actual input_dev state here instead? Adding a set/get
led state function to input core could resolve this cleanly.

>  		{
>  			set_bit(HID_REPORTED_IDLE, &usbhid->iofl);
>  			spin_unlock_irq(&usbhid->lock);
> diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
> index 1673cac..1d0e2bd 100644
> --- a/drivers/hid/usbhid/usbhid.h
> +++ b/drivers/hid/usbhid/usbhid.h
> @@ -96,7 +96,7 @@ struct usbhid_device {
>  	unsigned int retry_delay;                                       /* Delay length in ms */
>  	struct work_struct reset_work;                                  /* Task context for resets */
>  	wait_queue_head_t wait;						/* For sleeping */
> -	int ledcount;							/* counting the number of active leds */
> +	int ledstate;							/* Bitmask of active LEDs */
>  };
>  
>  #define	hid_to_usb_dev(hid_dev) \
> -- 
> 1.7.6.4

Cheers,
Henrik
