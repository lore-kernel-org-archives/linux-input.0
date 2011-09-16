From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Add MacBookAir4,1 keyboard support
Date: Fri, 16 Sep 2011 17:05:55 +0100
Message-ID: <1316189156.10576.6.camel@novo.hadess.net>
References: <20110907201552.GA1962@Caligula>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:45168 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab1IPQMC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 12:12:02 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 03A323834D
	for <linux-input@vger.kernel.org>; Fri, 16 Sep 2011 18:05:59 +0200 (CEST)
In-Reply-To: <20110907201552.GA1962@Caligula>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pieter-Augustijn Van Malleghem <p-a@scarlet.be>
Cc: linux-input@vger.kernel.org

On Wed, 2011-09-07 at 16:15 -0400, Pieter-Augustijn Van Malleghem wrote:
> This patch adds support for the Apple MacBookAir4,1 released in July 
> 2011. It was inspired by Joshua Dillon's patch for the MacBookAir4,2
> posted on http://www.almostsure.com/mba42/hid-apple-dkms.patch.

> Signed-off-by: Pieter-Augustijn Van Malleghem <p-a@scarlet.be>
> diff -uNr linux/drivers/hid/hid-apple.c patched/drivers/hid/hid-apple.c
> --- linux/drivers/hid/hid-apple.c	2011-09-06 23:41:58.000000000 -0400
> +++ patched/drivers/hid/hid-apple.c	2011-09-06 23:53:05.000000000 -0400
> @@ -183,6 +183,9 @@
>  		if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
>  				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
>  			table = macbookair_fn_keys;
> +		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI &&
> +				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS)
> +			table = macbookair_fn_keys;
>  		else if (hid->product < 0x21d || hid->product >= 0x300)
>  			table = powerbook_fn_keys;
>  		else

This is broken, the macbookair_fn_keys above are for earlier revisions
of the MacBook Air. MacBookAir4,1 and 4,1 don't have an eject button
anymore, so should use the apple_fn_keys[] translation table.

Cheers

