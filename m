From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] INPUT: enable remote wakeup for PNP i8042 keyboard ports
Date: Mon, 8 Mar 2010 23:46:04 -0800
Message-ID: <20100309074604.GC17288@core.coreip.homeip.net>
References: <Pine.LNX.4.44L0.1003081651220.1297-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f189.google.com ([209.85.211.189]:43876 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab0CIHqK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 02:46:10 -0500
Received: by ywh27 with SMTP id 27so3070489ywh.22
        for <linux-input@vger.kernel.org>; Mon, 08 Mar 2010 23:46:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1003081651220.1297-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-input@vger.kernel.org

On Mon, Mar 08, 2010 at 04:52:42PM -0500, Alan Stern wrote:
> This patch (as1355) enables remote wakeup by default on PNP i8042
> keyboard ports.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 

Will apply, thank you Alan.

> ---
> 
> Index: usb-2.6/drivers/input/serio/i8042-x86ia64io.h
> ===================================================================
> --- usb-2.6.orig/drivers/input/serio/i8042-x86ia64io.h
> +++ usb-2.6/drivers/input/serio/i8042-x86ia64io.h
> @@ -624,6 +624,9 @@ static int i8042_pnp_kbd_probe(struct pn
>  		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
>  	}
>  
> +	/* Keyboard ports are always supposed to be wakeup-enabled */
> +	device_set_wakeup_enable(&dev->dev, true);
> +
>  	i8042_pnp_kbd_devices++;
>  	return 0;
>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
