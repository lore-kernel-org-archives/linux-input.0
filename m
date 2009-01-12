From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: usbtouchscreen: Add support for Zytronic capacitive touchscreen
Date: Sun, 11 Jan 2009 23:53:22 -0800
Message-ID: <20090111234903.ZZRA012@mailhub.coreip.homeip.net>
References: <20090109121026.052643915@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:29916 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbZALHyF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 02:54:05 -0500
Received: by yx-out-2324.google.com with SMTP id 8so3367874yxm.1
        for <linux-input@vger.kernel.org>; Sun, 11 Jan 2009 23:54:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20090109121026.052643915@fluff.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-input@vger.kernel.org, vince@simtec.co.uk, dsilvers@simtec.co.uk

On Fri, Jan 09, 2009 at 12:10:26PM +0000, Ben Dooks wrote:
> From: Vincent Sanders <vince@simtec.co.uk>
> 
> Zytronic USB-attached capacitive touchscreen support
> within the generic USB touchscreen driver.
> 
> Signed-off-by: Daniel Silverstone <dsilvers@simtec.co.uk>
> Signed-off-by: Vincent Sanders <vince@simtec.co.uk>
> 

Since you are passing the driver on your sign off is also needed.


> Index: linux.git/drivers/input/touchscreen/usbtouchscreen.c
> ===================================================================
> --- linux.git.orig/drivers/input/touchscreen/usbtouchscreen.c	2009-01-08 15:26:04.000000000 +0000
> +++ linux.git/drivers/input/touchscreen/usbtouchscreen.c	2009-01-09 12:03:39.000000000 +0000
> @@ -13,6 +13,7 @@
>   *  - IdealTEK URTC1000
>   *  - General Touch
>   *  - GoTop Super_Q2/GogoPen/PenPower tablets
> + *  - Zytronic capacitive touchscreen
>   *
>   * Copyright (C) 2004-2007 by Daniel Ritz <daniel.ritz@gmx.ch>
>   * Copyright (C) by Todd E. Johnson (mtouchusb.c)
> @@ -68,6 +69,11 @@ struct usbtouch_device_info {
>  	int min_press, max_press;
>  	int rept_size;
>  
> +	/* Always service the USB devices irq not just when the input device is
> +	 * open.
> +	 */
> +	int irq_always;
> +

Why is this needed?

> +	case 0xC0: /* down */
> +		dev->x = (pkt[1] & 0x7f) | ((pkt[2] & 0x07) << 7);
> +		dev->y = (pkt[3] & 0x7f) | ((pkt[4] & 0x07) << 7);
> +		dev->touch = 1;
> +		dev->press = 1;

Since the device does not report real pressure readings don't try to
fake it, reporting touch is enough.

-- 
Dmitry
