From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: joydev - Recognize joysticks with Z axis as
 joysticks.
Date: Thu, 25 Aug 2016 09:45:30 -0700
Message-ID: <20160825164530.GD11206@dtor-ws>
References: <1472134610-6438-1-git-send-email-ville.ranki@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33784 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760650AbcHYQpt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Aug 2016 12:45:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id i6so3512562pfe.0
        for <linux-input@vger.kernel.org>; Thu, 25 Aug 2016 09:45:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1472134610-6438-1-git-send-email-ville.ranki@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville Ranki <ville.ranki@iki.fi>
Cc: linux-input@vger.kernel.org

On Thu, Aug 25, 2016 at 05:16:50PM +0300, Ville Ranki wrote:
> Current implementation of joydev's input_device_id
> table recognizes only devices with ABS_X, ABS_WHEEL
> or ABS_THROTTLE axes as joysticks.
> 
> There are joystick devices that do not have those axes,
> for example TRC Rudder device. The device in question
> has ABS_Z, ABS_RX and ABS_RY axes causing it not being
> detected as joystick.
> 
> This patch adds ABS_Z to the input_device_id list
> allowing devices with ABS_Z axis to be detected
> correctly.

I am curious why you still use joydev and not switch your client(s) to
evdev? Or is it some legacy game?

Thanks.

> 
> Signed-off-by: Ville Ranki <ville.ranki@iki.fi>
> ---
>  drivers/input/joydev.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index 5d11fea..f3135ae 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -950,6 +950,12 @@ static const struct input_device_id joydev_ids[] = {
>  		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
>  				INPUT_DEVICE_ID_MATCH_ABSBIT,
>  		.evbit = { BIT_MASK(EV_ABS) },
> +		.absbit = { BIT_MASK(ABS_Z) },
> +	},
> +	{
> +		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
> +				INPUT_DEVICE_ID_MATCH_ABSBIT,
> +		.evbit = { BIT_MASK(EV_ABS) },
>  		.absbit = { BIT_MASK(ABS_WHEEL) },
>  	},
>  	{
> -- 
> 2.7.4
> 

-- 
Dmitry
