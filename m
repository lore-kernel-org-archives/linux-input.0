From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Fix Speedlink VAD Cezanne support for some
 devices
Date: Tue, 30 Jul 2013 22:59:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307302258080.18809@pobox.suse.cz>
References: <51F7979C.4030306@stefankriwanek.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55212 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757231Ab3G3U7p (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jul 2013 16:59:45 -0400
In-Reply-To: <51F7979C.4030306@stefankriwanek.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Kriwanek <dev@stefankriwanek.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, 30 Jul 2013, Stefan Kriwanek wrote:

> I obtained a mouse device "Speedlink VAD Cezanne" that needs more 
> aggressive fixing than already done in the driver. It, however, reports 
> itself the same as the model hid-speedlink.c was written for.
> 
> The patch applies to any kernel from 3.1 to current 3.11-rc3, since the 
> file hasn't ever been touched since then.
> 
> Please also note that I made sure through testing that this patch would 
> not interfere with the proper working of a device that is bug-free: The 
> driver drops EV_REL events with abs(val) >= 256, which are not 
> achievable even on the highest laser resolution hardware setting. Hence 
> I believe it is safe to also apply to the older kernels (that is, if 
> your policy does allow that).

Hi Stefan,

thanks for the debugging effort and the patch. One minor thing ...

> 
> Signed-off-by: Stefan Kriwanek <mail@stefankriwanek.de>
> 
> ---
> 
> 
> --- linux-source-3.5.0/drivers/hid/hid-speedlink.c	2012-07-21 22:58:29.000000000 +0200
> +++ linux-source-3.5.0-speedlink/drivers/hid/hid-speedlink.c	2013-07-30 12:24:22.113302655 +0200
> @@ -3,7 +3,7 @@
>   *  Fixes "jumpy" cursor and removes nonexistent keyboard LEDS from
>   *  the HID descriptor.
>   *
> - *  Copyright (c) 2011 Stefan Kriwanek <mail@stefankriwanek.de>
> + *  Copyright (c) 2011, 2013 Stefan Kriwanek <dev@stefankriwanek.de>
>   */
>  
>  /*
> @@ -49,7 +49,7 @@ static int speedlink_event(struct hid_de
>  {
>  	/* No other conditions due to usage_table. */
>  	/* Fix "jumpy" cursor (invalid events sent by device). */
> -	if (value == 256)
> +	if (abs(value) >= 256)

I think it'd be valuable to have brief description of why the more strict 
condition is necessary (and correct at the same time) also in the code 
comment preceeding the if(), not just in the patch changelog.

Could you please refresh your patch and resend?

Thanks,

-- 
Jiri Kosina
SUSE Labs
