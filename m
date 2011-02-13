From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Re: [PATCH] hid kernel module for wireless remote LC Power model
 RC1000MCE
Date: Sun, 13 Feb 2011 15:04:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102131503010.2160@pobox.suse.cz>
References: <4D4019EC.8060301@gmx.de> <alpine.LNX.2.00.1102031642260.2160@pobox.suse.cz> <4D502376.5040505@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38466 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab1BMOET (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Feb 2011 09:04:19 -0500
In-Reply-To: <4D502376.5040505@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Schlund <chrisschlund@gmx.de>
Cc: linux-input@vger.kernel.org

On Mon, 7 Feb 2011, Chris Schlund wrote:

> Hi Jiri,
> 
> I already got some feedback for this module, telling me red and blue keys are exchanged.
> I checked it, and they are right. Due to my incorrect userspace settings I missed this during my testing.
> So here is the fixed mapping.
> I am sorry for the inconvenience.
> 
> Thanks, Chris
> 
> 
> Signed-off-by: Chris Schlund <chrisschlund@gmx.de>
> ---
> 
> diff -urN linux-2.6.37/drivers/hid/hid-lcpower.c linux/drivers/hid/hid-lcpower.c
> --- linux-2.6.37/drivers/hid/hid-lcpower.c      2011-02-07 17:31:49.000000000 +0100
> +++ linux/drivers/hid/hid-lcpower.c     2011-02-07 17:32:50.000000000 +0100
> @@ -30,8 +30,8 @@
>         switch (usage->hid & HID_USAGE) {
>         case 0x046: ts_map_key_clear(KEY_YELLOW);         break;
>         case 0x047: ts_map_key_clear(KEY_GREEN);          break;
> -        case 0x049: ts_map_key_clear(KEY_RED);            break;
> -        case 0x04a: ts_map_key_clear(KEY_BLUE);           break;
> +        case 0x04a: ts_map_key_clear(KEY_RED);            break;
> +        case 0x049: ts_map_key_clear(KEY_BLUE);           break;

We'd rather keep the numbers sorted. Plus your patch has been 
whitespace-damaged by your mail-client.

I have fixed both things and applied. Please fix your mail client for 
further patch submissions.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
