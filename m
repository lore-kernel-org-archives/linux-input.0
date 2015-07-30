From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/8] Input: xpad: use bitmask for finding the pad_nr
Date: Wed, 29 Jul 2015 23:55:17 -0700
Message-ID: <20150730065517.GB35939@dtor-ws>
References: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
 <1436572068-10661-7-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35216 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbG3GzY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 02:55:24 -0400
Received: by pabkd10 with SMTP id kd10so18568549pab.2
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2015 23:55:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436572068-10661-7-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

Hi Pavel,

On Sat, Jul 11, 2015 at 01:47:46AM +0200, Pavel Rojtberg wrote:
> From: Pavel Rojtberg <rojtberg@gmail.com>
> 
> The pad_nr should be consistent after disconnecting/ reconnecting a
> xbox360 controllers.
> Use a bitmask to track connected pads - this way we can re-assign freed
> up pad numbers.
> 
> Consider the following case:
> 1. pad A is connected and gets pad_nr = 0
> 2. pad B is connected and gets pad_nr = 1
> 3. pad A is disconnected
> 4. pad A is connected again
> 
> using the bitmask controller A now correctly gets pad_nr = 0 again.

And what happens if I pull both out and plug B first? Why do we care
about this? If we really want stable numbering maybe it should be driven
from userspace based on connection path?

> 
> Note: this sets a limit of 32 simultaneous connected xbox360
> controllers. However this should be tolerable.
> 
> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index a9ff4c2..e28a9c1 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -346,6 +346,8 @@ struct usb_xpad {
>  	struct work_struct work;	/* init/remove device from callback */
>  };
>  
> +static unsigned long xpad_pad_seq;
> +
>  static int xpad_init_input(struct usb_xpad *xpad);
>  static void xpad_deinit_input(struct usb_xpad *xpad);
>  
> @@ -940,6 +942,12 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
>   */
>  static void xpad_identify_controller(struct usb_xpad *xpad)
>  {
> +	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
> +		return;
> +
> +	xpad->pad_nr = find_first_zero_bit(&xpad_pad_seq, 32);
> +	set_bit(xpad->pad_nr, &xpad_pad_seq);
> +

This is racy. If we really want it you might consider idr/ida.

Thanks.

-- 
Dmitry
