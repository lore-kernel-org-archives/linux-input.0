From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: PATCH change for HID_BATTERY_STRENGTH kconfig
Date: Tue, 29 Jul 2014 13:39:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1407291339040.16390@pobox.suse.cz>
References: <CACo8zOfAf3cUNh4MZcQvYByiu=D5S1aA4qiH_HFuvz5GYMJF7g@mail.gmail.com> <alpine.LNX.2.00.1305240016180.13213@pobox.suse.cz> <CACo8zOcm3B7WdQpHA3J2ZtP6AWUrtAo_L63mpYJR0w13jNwLpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42730 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbaG2LjU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 07:39:20 -0400
In-Reply-To: <CACo8zOcm3B7WdQpHA3J2ZtP6AWUrtAo_L63mpYJR0w13jNwLpQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Nicoletti <dantti12@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 23 Jun 2014, Daniel Nicoletti wrote:

> 2013-05-23 19:16 GMT-03:00 Jiri Kosina <jkosina@suse.cz>:
> > On Mon, 13 May 2013, Daniel Nicoletti wrote:
> >
> >> Hi,
> >> I'd like to propose this patch while removes the need for
> >> hid to be compiled build-in, as this is the same behavior
> >> that WiiMote and Wacom have.
> >> Is this ok?
> >
> > Makes sense to me. Could you please resend with proper changelog and
> > Signed-off-by: line?
> >
> > Thanks.
> 
> Sorry it took more than a year for me to do this,
> so I called git send-email, and so far the CC and
> linux-input didn't get it, tho it said result OK.
> git send-email --to "Jiri Kosina <jkosina@suse.cz>" --cc
> "linux-input@vger.kernel.org"
> 0001-HID-Allows-for-HID_BATTERY_STRENGTH-config-be-enable.patch
> 
> I'm pasting it here hoping gmail doesn't screw
> it, if you prefer that I send it using the above
> command mind you telling what I did wrong?
> 
> Thanks.
> 
> >From df740fd81dffbb74e13c622392fe9a945006fd3c Mon Sep 17 00:00:00 2001
> From: Daniel Nicoletti <dantti12@gmail.com>
> Date: Mon, 23 Jun 2014 10:31:47 -0300
> Subject: [PATCH] HID: Allows for HID_BATTERY_STRENGTH config be enabled
>  without the need for HID module to be built-in.
> 

It'd be nice to insert a few sentences of changelog here.

Thanks.

> Signed-off-by: Daniel Nicoletti <dantti12@gmail.com>
> ---
>  drivers/hid/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index fb52f3f..d6d85ad 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -27,7 +27,8 @@ if HID
> 
>  config HID_BATTERY_STRENGTH
>         bool "Battery level reporting for HID devices"
> -       depends on HID && POWER_SUPPLY && HID = POWER_SUPPLY
> +       depends on HID
> +       select POWER_SUPPLY
>         default n
>         ---help---
>         This option adds support of reporting battery strength (for HID devices
> -- 
> 2.0.0
> 

-- 
Jiri Kosina
SUSE Labs
