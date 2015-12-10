From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] Input: xpad: workaround dead irq_out after suspend/
 resume
Date: Wed, 9 Dec 2015 22:41:31 -0800
Message-ID: <20151210064131.GB35505@dtor-ws>
References: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
 <1446391899-24250-5-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32832 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbbLJGle (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2015 01:41:34 -0500
Received: by pfnn128 with SMTP id n128so43030283pfn.0
        for <linux-input@vger.kernel.org>; Wed, 09 Dec 2015 22:41:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1446391899-24250-5-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

On Sun, Nov 01, 2015 at 04:31:38PM +0100, Pavel Rojtberg wrote:
> From: Pavel Rojtberg <rojtberg@gmail.com>
> 
> the irq_out urb is dead after suspend/ resume on my x360 wr pad. (also
> reproduced by Zachary Lund [0]) Work around this by resetting the usb
> device on resume. Added suspend/ resume callbacks to do so.
> 
> [0]: https://github.com/paroj/xpad/issues/6
> 
> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index f3754c7..e8dcc80 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1423,17 +1423,23 @@ err_free_mem:
>  
>  }
>  
> -static void xpad_disconnect(struct usb_interface *intf)
> +static void xpad_stop_communication(struct usb_xpad *xpad)
>  {
> -	struct usb_xpad *xpad = usb_get_intfdata (intf);
> -
> -	xpad_deinit_output(xpad);
> +	xpad_stop_output(xpad);
>  
>  	if (xpad->xtype == XTYPE_XBOX360W) {
>  		usb_kill_urb(xpad->irq_in);
>  	}
>  
>  	cancel_work_sync(&xpad->work);
> +}
> +
> +static void xpad_disconnect(struct usb_interface *intf)
> +{
> +	struct usb_xpad *xpad = usb_get_intfdata(intf);
> +
> +	xpad_stop_communication(xpad);
> +	xpad_deinit_output(xpad);
>  
>  	if (xpad->pad_present)
>  		xpad_deinit_input(xpad);
> @@ -1447,10 +1453,26 @@ static void xpad_disconnect(struct usb_interface *intf)
>  	usb_set_intfdata(intf, NULL);
>  }
>  
> +static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
> +{
> +	struct usb_xpad *xpad = usb_get_intfdata(intf);
> +
> +	xpad_stop_communication(xpad);
> +	return 0;
> +}
> +
> +static int xpad_resume(struct usb_interface *intf)
> +{
> +	usb_queue_reset_device(intf);

Why do we have to force reset (and tear down the device)? I am sure we
can resume it properly.

Thanks.

> +	return 0;
> +}
> +
>  static struct usb_driver xpad_driver = {
>  	.name		= "xpad",
>  	.probe		= xpad_probe,
>  	.disconnect	= xpad_disconnect,
> +	.suspend	= xpad_suspend,
> +	.resume		= xpad_resume,
>  	.id_table	= xpad_table,
>  };
>  
> -- 
> 1.9.1
> 

-- 
Dmitry
