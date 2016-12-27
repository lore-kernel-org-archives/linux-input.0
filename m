From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad - use correct product id for x360w
 controllers
Date: Tue, 27 Dec 2016 11:45:27 -0800
Message-ID: <20161227194527.GA28140@dtor-ws>
References: <1482854518-9298-1-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36477 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbcL0Tpb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Dec 2016 14:45:31 -0500
Received: by mail-pg0-f67.google.com with SMTP id n5so13280172pgh.3
        for <linux-input@vger.kernel.org>; Tue, 27 Dec 2016 11:45:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1482854518-9298-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

On Tue, Dec 27, 2016 at 05:01:58PM +0100, Pavel Rojtberg wrote:
> From: Pavel Rojtberg <rojtberg@gmail.com>
> 
> currently the controllers get the same product id as the wireless
> receiver. However the controllers actually have their own product id.
> 
> The patch makes the driver expose the same product id as the windows
> driver.
> 
> This improves compatibility when running applications with WINE.
> 
> see https://github.com/paroj/xpad/issues/54
> 
> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/xpad.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 098d8ec..34a2409 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1412,6 +1412,12 @@ static int xpad_init_input(struct usb_xpad *xpad)
>  	input_dev->name = xpad->name;
>  	input_dev->phys = xpad->phys;
>  	usb_to_input_id(xpad->udev, &input_dev->id);
> +
> +	if(xpad->xtype == XTYPE_XBOX360W) {
> +		/* x360w controllers and the receiver have different ids */
> +		input_dev->id.product = 0x02a1;
> +	}
> +
>  	input_dev->dev.parent = &xpad->intf->dev;
>  
>  	input_set_drvdata(input_dev, xpad);
> -- 
> 2.7.4
> 

-- 
Dmitry
