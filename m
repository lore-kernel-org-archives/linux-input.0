From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] HID: check for HID_QUIRK_IGNORE during probing
Date: Tue, 25 May 2010 23:41:02 +0100
Message-ID: <1274827262.27274.19170.camel@localhost.localdomain>
References: <20100523204725.6e9e8dad@holly>  <20100525225323.134b2c00@holly>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:46611 "EHLO
	relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab0EYWlL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 May 2010 18:41:11 -0400
In-Reply-To: <20100525225323.134b2c00@holly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jindrich Makovicka <makovick@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, 2010-05-25 at 22:53 +0200, Jindrich Makovicka wrote:
> Updated to current git:
> 
> --- hid-core.c.orig	2010-05-25 22:04:58.000000000 +0200
> +++ hid-core.c	2010-05-25 22:08:53.791241376 +0200
> @@ -1759,7 +1759,8 @@
>  
>  	/* we need to kill them here, otherwise they will stay
> allocated to
>  	 * wait for coming driver */
> -	if (!(hdev->quirks & HID_QUIRK_NO_IGNORE) && hid_ignore(hdev))
> +	if (!(hdev->quirks & HID_QUIRK_NO_IGNORE)
> +            && (hid_ignore(hdev) || (hdev->quirks & HID_QUIRK_IGNORE)))
>  		return -ENODEV;
>  
>  	/* XXX hack, any other cleaner solution after the driver core

Wouldn't that mean that a device with HID_QUIRK_IGNORE for which we pass
HID_QUIRK_NO_IGNORE, would still be ignored?

If so, that's not what we want to do...


