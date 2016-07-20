From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] input: tablet: pegasus_notetaker: Fix usb_autopm
 calls to be balanced
Date: Wed, 20 Jul 2016 14:29:43 -0700
Message-ID: <20160720212943.GA26006@dtor-ws>
References: <1468852149-2614-1-git-send-email-martink@posteo.de>
 <1468852149-2614-3-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35939 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbcGTV3r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 17:29:47 -0400
Content-Disposition: inline
In-Reply-To: <1468852149-2614-3-git-send-email-martink@posteo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Jul 18, 2016 at 04:29:07PM +0200, Martin Kepplinger wrote:
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  drivers/input/tablet/pegasus_notetaker.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
> index 27cb352..fdbc5e8 100644
> --- a/drivers/input/tablet/pegasus_notetaker.c
> +++ b/drivers/input/tablet/pegasus_notetaker.c
> @@ -208,27 +208,30 @@ static int pegasus_open(struct input_dev *dev)
>  		return retval;
>  
>  	pegasus->irq->dev = pegasus->usbdev;
> -	if (usb_submit_urb(pegasus->irq, GFP_KERNEL))
> +	if (usb_submit_urb(pegasus->irq, GFP_KERNEL)) {
>  		retval = -EIO;
> +		goto out;
> +	}
>  
>  	retval = pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);

If this fails I we should kill URB and cancel work. I adjusted and
applied.

>  
> -	usb_autopm_put_interface(pegasus->intf);
> +out:
>  
> -	return retval;
> +	if (retval < 0) {
> +		usb_autopm_put_interface(pegasus->intf);
> +		return retval;
> +	} else {
> +		return 0;
> +	}
>  }
>  
>  static void pegasus_close(struct input_dev *dev)
>  {
>  	struct pegasus *pegasus = input_get_drvdata(dev);
> -	int autopm_error;
>  
> -	autopm_error = usb_autopm_get_interface(pegasus->intf);
>  	usb_kill_urb(pegasus->irq);
>  	cancel_work_sync(&pegasus->init);
> -
> -	if (!autopm_error)
> -		usb_autopm_put_interface(pegasus->intf);
> +	usb_autopm_put_interface(pegasus->intf);
>  }
>  
>  static int pegasus_probe(struct usb_interface *intf,
> -- 
> 2.1.4
> 

-- 
Dmitry
