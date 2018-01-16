From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - reset the ABS_X/Y fuzz after
 initializing MT axes
Date: Tue, 16 Jan 2018 15:41:26 -0800
Message-ID: <20180116234126.4qxrvfyacy2grw37@dtor-ws>
References: <20180116053459.GA14660@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33443 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeAPXla (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jan 2018 18:41:30 -0500
Received: by mail-pl0-f66.google.com with SMTP id t4so4577655plo.0
        for <linux-input@vger.kernel.org>; Tue, 16 Jan 2018 15:41:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180116053459.GA14660@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Andrew Duggan <aduggan@synaptics.com>

On Tue, Jan 16, 2018 at 03:34:59PM +1000, Peter Hutterer wrote:
> input_mt_init_slots() resets the ABS_X/Y fuzz to 0 and expects the driver to
> call input_mt_report_pointer_emulation(). That is based on the MT position
> bits which are already defuzzed - hence a fuzz of 0.
> 
> In the case of synaptics semi-mt devices, we report the ABS_X/Y axes manually.
> This results in the MT position being defuzzed but the single-touch emulation
> missing that defuzzing.
> 
> Work around this by re-initializing the ABS_X/Y axes after the MT axis to
> get the same fuzz value back.
> 
> https://bugs.freedesktop.org/show_bug.cgi?id=104533
> 
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>

Applied, thank you.

> ---
> Semi-mt devices are Dodos, so I'd rather go for the easy fix here than a
> big rewrite of that code.
> 
>  drivers/input/mouse/synaptics.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index ee5466a374bf..0e04275e0d74 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -1280,6 +1280,14 @@ static void set_input_params(struct psmouse *psmouse,
>  				    INPUT_MT_POINTER |
>  				    (cr48_profile_sensor ?
>  					INPUT_MT_TRACK : INPUT_MT_SEMI_MT));
> +
> +		/* For semi-mt devices we send ABS_X/Y ourselves instead of
> +		 * input_mt_report_pointer_emulation. But
> +		 * input_mt_init_slots() resets the fuzz to 0, leading to a
> +		 * filtered ABS_MT_POSITION_X but an unfiltered ABS_X
> +		 * position. Let's re-initialize ABS_X/Y here. */
> +		if (!cr48_profile_sensor)
> +			set_abs_position_params(dev, &priv->info, ABS_X, ABS_Y);
>  	}
>  
>  	if (SYN_CAP_PALMDETECT(info->capabilities))
> -- 
> 2.14.3
> 

-- 
Dmitry
