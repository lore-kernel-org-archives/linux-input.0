From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] input: tablet: pegasus_notetaker: Set device mode in
 reset_resume() if in use
Date: Wed, 20 Jul 2016 14:30:53 -0700
Message-ID: <20160720213053.GC26006@dtor-ws>
References: <1468852149-2614-1-git-send-email-martink@posteo.de>
 <1468852149-2614-5-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33367 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbcGTVa5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 17:30:57 -0400
Content-Disposition: inline
In-Reply-To: <1468852149-2614-5-git-send-email-martink@posteo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Jul 18, 2016 at 04:29:09PM +0200, Martin Kepplinger wrote:
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Applied, thank you.

> ---
>  drivers/input/tablet/pegasus_notetaker.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
> index 07436c6..b172247 100644
> --- a/drivers/input/tablet/pegasus_notetaker.c
> +++ b/drivers/input/tablet/pegasus_notetaker.c
> @@ -398,7 +398,19 @@ static int pegasus_resume(struct usb_interface *intf)
>  
>  static int pegasus_reset_resume(struct usb_interface *intf)
>  {
> -	return pegasus_resume(intf);
> +	struct pegasus *pegasus = usb_get_intfdata(intf);
> +	int retval = 0;
> +
> +	mutex_lock(&pegasus->dev->mutex);
> +	if (pegasus->dev->users) {
> +		retval = pegasus_set_mode(pegasus, PEN_MODE_XY,
> +					  NOTETAKER_LED_MOUSE);
> +		if (!retval && usb_submit_urb(pegasus->irq, GFP_NOIO) < 0)
> +			retval = -EIO;
> +	}
> +	mutex_unlock(&pegasus->dev->mutex);
> +
> +	return retval;
>  }

-- 
Dmitry
