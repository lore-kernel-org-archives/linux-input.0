From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/RFT 3/5] USB: usbtouch: Prevent possible deadlock
Date: Sun, 14 Mar 2010 00:59:49 -0800
Message-ID: <20100314085949.GC8226@core.coreip.homeip.net>
References: <201003121542.53537.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:56827 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908Ab0CNI7z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Mar 2010 04:59:55 -0400
Content-Disposition: inline
In-Reply-To: <201003121542.53537.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, linux-input@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

Hi Oliver,

On Fri, Mar 12, 2010 at 03:42:53PM +0100, Oliver Neukum wrote:
> From 5e4fc75d1031ca1c621c0f85cf1e903ffd8fb758 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver@neukum.org>
> Date: Thu, 11 Mar 2010 15:06:51 +0100
> Subject: [PATCH 3/5] USB: usbtouch: Prevent possible deadlock
> 
> For autosuspend memory in suspend/resume must be allocated with
> GFP_NOIO.

I'd prefer if this change was folded into previous patch - there was no
deadlock condition before you added reset_resume.

> @@ -806,19 +806,19 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
>  	/* prepare ACK URB */
>  	ret = -ENOMEM;
>  
> -	usbtouch->priv = kmalloc(sizeof(struct nexio_priv), GFP_KERNEL);
> +	usbtouch->priv = kmalloc(sizeof(struct nexio_priv), GFP_NOIO);
>  	if (!usbtouch->priv)
>  		goto out_buf;
>  

Remind me, how does ->exit() gets called in case of reset_resume?
Otherwise it looks like ne are leaking memory...

-- 
Dmitry
