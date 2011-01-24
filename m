From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [patch] hid: check for kmalloc() failure
Date: Mon, 24 Jan 2011 19:44:33 +0100
Message-ID: <1295894673.4901.16.camel@neuromancer>
References: <20110124183213.GA2721@bicker>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:43727 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752945Ab1AXSon (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 13:44:43 -0500
In-Reply-To: <20110124183213.GA2721@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

Am Montag, den 24.01.2011, 21:32 +0300 schrieb Dan Carpenter:
> Return -ENOMEM if kmalloc() fails.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
> index 1608c8d..c27bc91 100644
> --- a/drivers/hid/hid-roccat-koneplus.c
> +++ b/drivers/hid/hid-roccat-koneplus.c
> @@ -220,6 +220,10 @@ static int koneplus_get_startup_profile(struct usb_device *usb_dev)
>  	int retval;
>  
>  	buf = kmalloc(sizeof(struct koneplus_startup_profile), GFP_KERNEL);
> +	if (!buf) {
> +		retval = -ENOMEM;
> +		goto out;
> +	}
>  
>  	retval = koneplus_receive(usb_dev, KONEPLUS_USB_COMMAND_STARTUP_PROFILE,
>  			buf, sizeof(struct koneplus_startup_profile));

That was already fixed by Vasiliy Kulikov. The patch was applied to the
roccat branch in Jiri Kosinas hid repository
(dacfecdbf3a0a5072984ff8b3c224a48c8461008).
Thank you anyway.
Stefan

