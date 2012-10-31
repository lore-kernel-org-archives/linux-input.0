From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] tsc40: remove wrong announcement of pressure support
Date: Tue, 30 Oct 2012 23:41:08 -0700
Message-ID: <20121031064108.GA7953@core.coreip.homeip.net>
References: <3551576.vuikKUmT5K@devpool02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34409 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab2JaGlM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 02:41:12 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so740015pad.19
        for <linux-input@vger.kernel.org>; Tue, 30 Oct 2012 23:41:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3551576.vuikKUmT5K@devpool02>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-input@vger.kernel.org

On Fri, Oct 26, 2012 at 09:35:57AM +0200, Rolf Eike Beer wrote:
> The tsc40 driver announces it supports the pressure event, but will never send
> one. The announcement will cause tslib to wait for such events and sending all
> touch events with a pressure of 0. Removing the announcement will make tslib
> fall back to emulating the pressure on touch events so everything works as
> expected.
> 
> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
> Cc: stable@vger.kernel.org

Applied, thank you Rolf. 

> ---
>  drivers/input/touchscreen/tsc40.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/tsc40.c b/drivers/input/touchscreen/tsc40.c
> index 63209aa..eb96f16 100644
> --- a/drivers/input/touchscreen/tsc40.c
> +++ b/drivers/input/touchscreen/tsc40.c
> @@ -107,7 +107,6 @@ static int tsc_connect(struct serio *serio, struct serio_driver *drv)
>  	__set_bit(BTN_TOUCH, input_dev->keybit);
>  	input_set_abs_params(ptsc->dev, ABS_X, 0, 0x3ff, 0, 0);
>  	input_set_abs_params(ptsc->dev, ABS_Y, 0, 0x3ff, 0, 0);
> -	input_set_abs_params(ptsc->dev, ABS_PRESSURE, 0, 0, 0, 0);
>  
>  	serio_set_drvdata(serio, ptsc);
>  
> -- 
> 1.7.11.5
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
