From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad - fix input from Covert Forces Xbox One
 controller
Date: Wed, 9 Dec 2015 22:47:43 -0800
Message-ID: <20151210064743.GC35505@dtor-ws>
References: <5663EB97.7020103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33611 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbbLJGrq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2015 01:47:46 -0500
Received: by pfnn128 with SMTP id n128so43115817pfn.0
        for <linux-input@vger.kernel.org>; Wed, 09 Dec 2015 22:47:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5663EB97.7020103@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Cameron,

On Sun, Dec 06, 2015 at 12:02:31AM -0800, Cameron Gutman wrote:
> The Covert Forces edition of the Xbox One controller requires the full 5
> byte initialization packet to work at all. The 5 byte packet was known to
> be needed for proper rumble support, but it looks like it's needed even
> without rumble on these controllers.

I already have a patch that does this and rumble for these controllers
in my queue (in xpad branch) so this one is not needed.

Thank you.

> 
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index fd4100d..de89de0 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1052,7 +1052,10 @@ static int xpad_open(struct input_dev *dev)
>  		/* Xbox one controller needs to be initialized. */
>  		xpad->odata[0] = 0x05;
>  		xpad->odata[1] = 0x20;
> -		xpad->irq_out->transfer_buffer_length = 2;
> +		xpad->odata[2] = 0x00;
> +		xpad->odata[3] = 0x01;
> +		xpad->odata[4] = 0x00;
> +		xpad->irq_out->transfer_buffer_length = 5;
>  		return usb_submit_urb(xpad->irq_out, GFP_KERNEL);
>  	}
> 
> -- 
> 2.5.0

-- 
Dmitry
