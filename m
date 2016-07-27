From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad - power off wireless 360 controllers on
 suspend
Date: Wed, 27 Jul 2016 14:32:22 -0700
Message-ID: <20160727213222.GB24351@dtor-ws>
References: <6203d65c-4e15-c44c-edc9-d47cc78f1c28@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34295 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbcG0VcZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jul 2016 17:32:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id g202so2459304pfb.1
        for <linux-input@vger.kernel.org>; Wed, 27 Jul 2016 14:32:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6203d65c-4e15-c44c-edc9-d47cc78f1c28@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: rojtberg@gmail.com, linux-input@vger.kernel.org

On Mon, Jul 25, 2016 at 10:35:08PM -0700, Cameron Gutman wrote:
> When the USB wireless adapter is suspended, the controllers
> lose their connection. This causes them to start flashing
> their LED rings and searching for the wireless adapter
> again, wasting the controller's battery power.
> 
> Instead, we will tell the controllers to power down when
> we suspend. This mirrors the behavior of the controllers
> when connected to the console itself and how the official
> Xbox One wireless adapter behaves on Windows.
> 
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>
> ---
> This patch is independent of the other xpad patch [0] that I
> submitted (and decided to wait on). It applies against
> unmodified xpad.c in master.
> 
> [0] http://www.spinics.net/lists/linux-input/msg46062.html
> ---
>  drivers/input/joystick/xpad.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index a529a45..3408019 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -115,6 +115,10 @@ static bool sticks_to_null;
>  module_param(sticks_to_null, bool, S_IRUGO);
>  MODULE_PARM_DESC(sticks_to_null, "Do not map sticks at all for unknown pads");
>  
> +static bool disable_auto_poweroff;
> +module_param(disable_auto_poweroff, bool, S_IRUGO);
> +MODULE_PARM_DESC(disable_auto_poweroff, "Do not power off wireless controllers on suspend");

Why negating? Why not do

static bool xpad_auto_poweroff = true;

?

(No need to resubmit if agree/disagree, I can fix up on my side).

> +
>  static const struct xpad_device {
>  	u16 idVendor;
>  	u16 idProduct;
> @@ -1248,6 +1252,36 @@ static void xpad_stop_input(struct usb_xpad *xpad)
>  	usb_kill_urb(xpad->irq_in);
>  }
>  
> +static void xpad360w_poweroff_controller(struct usb_xpad *xpad)
> +{
> +	unsigned long flags;
> +	struct xpad_output_packet *packet =
> +			&xpad->out_packets[XPAD_OUT_CMD_IDX];
> +
> +	spin_lock_irqsave(&xpad->odata_lock, flags);
> +
> +	packet->data[0] = 0x00;
> +	packet->data[1] = 0x00;
> +	packet->data[2] = 0x08;
> +	packet->data[3] = 0xC0;
> +	packet->data[4] = 0x00;
> +	packet->data[5] = 0x00;
> +	packet->data[6] = 0x00;
> +	packet->data[7] = 0x00;
> +	packet->data[8] = 0x00;
> +	packet->data[9] = 0x00;
> +	packet->data[10] = 0x00;
> +	packet->data[11] = 0x00;
> +	packet->len = 12;
> +	packet->pending = true;

I wonder of we don't want to convert commands to something like that:

	static const u8 power_off_cmd[] = {
		0x00, 0x00, 0x08, 0xc0, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00,
	};

	...

	memcpy(packet->data, power_off_cmd, sizeof(power_off_cmd));
	// if we need to change something
	// packet->data[3] += command;
	// packet->data[6] = id;
	packet->len = sizeof(power_off_cmd);
	...

This should be a separate patch though.

Thanks.

-- 
Dmitry
